@isTest(SeeAllData = false)
/*
    Created By  : Appirio - Jagdeep Juneja
    Created On  : 12/2/2017
    Purpose     : A class containing tests for TaskTriggerHandler class.
    --------------------------------------------------------------------------
*/
public class TaskTriggerHandler_isTest {
    
    @testsetup 
    static void prepareTestData() {
        
        List<Task> taskListToCreate = new List<Task>();
        taskListToCreate.addAll(Utility.createTask(50, 'Calltest', false));
        taskListToCreate.addAll(Utility.createTask(50, 'Emailtest', false));
        taskListToCreate.addAll(Utility.createTask(50, 'test123', false));
        
        insert taskListToCreate;
        
    }//ENd @testsetup static void prepareTestData()
      
    static TestMethod void updateTaskTypeTestMethod() {
        
        Test.startTest();
            List<Task> callTypeTasks = [SELECT Type FROM Task WHERE Subject LIKE 'call%'];
            for(Task t: callTypeTasks){
                System.assertEquals('Call', t.Type, 'Task type is not Call');
            }
            
            List<Task> emailTypeTasks = [SELECT Type FROM Task WHERE Subject LIKE 'email%'];
            for(Task t: emailTypeTasks){
                System.assertEquals('Email', t.Type, 'Task type is not Email');
            }
            
            List<Task> otherTypeTasks = [SELECT Type, Subject FROM Task WHERE Subject = 'test123'];
            for(Task t: otherTypeTasks){
                System.assertEquals('Task', t.Type, 'Task type is not Task');
            }
            
            //Update scenario
            for(Task t: otherTypeTasks){
                t.Subject = '123test';
            }
            update otherTypeTasks;
            
            for(Task t: [SELECT Type FROM Task WHERE Subject = '123test']){
                System.assertEquals('Task', t.Type, 'Task type is not Task');
            }
            
            //Error handling
            for(Task t: otherTypeTasks){
                t.Subject = '1234test';
                TaskDispatcher.errorMAP.put(t.ID, 'COVER Update'); // To cover error part of Trigger.
            }
            for (database.SaveResult urItem : database.update(otherTypeTasks, false)) {
                system.assertEquals(false, urItem.isSuccess());
            }
            
            Integer i = 0;
            for(Task t : otherTypeTasks){
                t.Subject = '12345test';
                TaskDispatcher.errorMAP.put(String.valueOf(i), 'COVER Update'); // To cover error part of Trigger.
                i++;
            }
            
            for (database.SaveResult urItem : database.update(otherTypeTasks, false)) {
                system.assertEquals(false, urItem.isSuccess());
            }
            
            
        Test.stopTest();
      
          
    }//END of static TestMethod void updateTaskTypeTestMethod()
}//  END of class PriorityCustomer_Trigger_isTest