@isTest
public class AddPrimaryContactTest {
    @testSetup 
    static void setup() {
        List<Account> accList = Utility.createAccount(100, false);
        
        for(Integer i=0 ;i<100 ;i++){
          if(i<50){
            accList[i].BillingState = 'NY';
          }
          else{
            accList[i].BillingState = 'CA';
          }
        }
        
        insert accList;
        
        List<Contact> conList = Utility.createContact(1, true);
    }
    
    static testmethod void testQueueable() {
        List<Account> accList = [select billingState from Account];
        Contact con = [select LastName from Contact];
        
        AddPrimaryContact updater = new AddPrimaryContact(con, 'NY');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(51, [select count() from Contact]);
    }
    
    static testmethod void testQueueable2() {
        List<Account> accList = [select billingState from Account];
        Contact con = [select LastName from Contact];
        
        AddPrimaryContact updater = new AddPrimaryContact(Con, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(51, [select count() from Contact]);
    }
    
}