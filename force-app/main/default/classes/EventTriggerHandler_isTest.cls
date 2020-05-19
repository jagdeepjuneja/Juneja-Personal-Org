@isTest(SeeAllData = false)
/*
    Created By  : Appirio - Jagdeep Juneja
    Created On  : 12/2/2017
    Purpose     : A class containing tests for EventTriggerHandler class.
    --------------------------------------------------------------------------
*/
public class EventTriggerHandler_isTest {
    
    @testsetup 
    static void prepareTestData() {
        
        List<Account> accList = Utility.createAccount(100, true);
        List<Contact> conList = Utility.createContact(100, true);
        
        List<Event> eventLists = new List<Event>();
        
        for(Event et: Utility.createEvent(10, 'Calltest', false)){
          et.whoId = conList[0].Id;
          et.whatId = accList[0].Id;
          eventLists.add(et);
        }
        
        for(Event et: Utility.createEvent(10, 'Emailtest', false)){
          et.whoId = conList[0].Id;
          et.whatId = accList[0].Id;
          eventLists.add(et);
        }
        
        for(Event et: Utility.createEvent(10, 'test123', false)){
          et.whoId = conList[0].Id;
          et.whatId = accList[0].Id;
          eventLists.add(et);
        }
        
        insert eventLists;
        
    }//ENd @testsetup static void prepareTestData()
      
    static TestMethod void updateEventTypeTestMethod() {
        
        Test.startTest();
            List<Event> callTypeEvents = [SELECT Type FROM Event WHERE Subject LIKE 'call%'];
            for(Event et: callTypeEvents){
                System.assertEquals('Call', et.Type, 'Task type is not Call');
            }
            
            List<Event> emailTypeEvents = [SELECT Type FROM Event WHERE Subject LIKE 'email%'];
            for(Event et: emailTypeEvents){
                System.assertEquals('Email', et.Type, 'Task type is not Email');
            }
            
            List<Event> otherTypeEvents = [SELECT Type, Subject FROM Event WHERE Subject = 'test123'];
            for(Event et: otherTypeEvents){
                System.assertEquals('Meeting', et.Type, 'Event type is not Meeting');
            }
            
            //Update scenario
            for(Event et : otherTypeEvents){
                et.Subject = '123test';
            }
            
            for(Event et: [SELECT Type, Subject FROM Event WHERE Subject = '123test']){
                System.assertEquals('Meeting', et.Type, 'Event type is not Meeting');
            }
            
            for(Event et : otherTypeEvents){
                et.Subject = '1234test';
            }
            update otherTypeEvents;
            
            //Error handling.
            
            for(Event et : otherTypeEvents){
                et.Subject = '12345test';
                EventDispatcher.errorMAP.put(et.ID, 'COVER Update'); // To cover error part of Trigger.
            }
            for (database.SaveResult urItem : database.update(otherTypeEvents, false)) {
                system.assertEquals(false, urItem.isSuccess());
            }
            
            Integer i = 0;
            for(Event et : otherTypeEvents){
                et.Subject = '123456test';
                EventDispatcher.errorMAP.put(String.valueOf(i), 'COVER Update'); // To cover error part of Trigger.
                i++;
            }
            
            for (database.SaveResult urItem : database.update(otherTypeEvents, false)) {
                system.assertEquals(false, urItem.isSuccess());
            }
            
            
        Test.stopTest();
        
    }//END of static TestMethod void createTaskForPriorityCustomerRecordTest()
    
    
    static TestMethod void updateActivityScoreOnAccountOrContactTestMethod() {
        
        Test.startTest();
            Account acc  = [SELECT Activity_Score__c FROM Account WHERE Activity_Score__c != NULL];
            System.assertEquals(60, acc.Activity_Score__c, 'Activity score is not rolled up on Account');
            
            Contact con  = [SELECT Activity_Score__c FROM Contact WHERE Activity_Score__c != NULL];
            System.assertEquals(60, con.Activity_Score__c, 'Activity score is not rolled up on Contact');
            
            
        Test.stopTest();
        
    }//END of static TestMethod void createTaskForPriorityCustomerRecordTest()
    
}//  END of class PriorityCustomer_Trigger_isTest