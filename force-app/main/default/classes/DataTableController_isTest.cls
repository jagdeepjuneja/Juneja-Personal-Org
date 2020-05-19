@isTest
private class DataTableController_isTest {

    @testSetup static void setup() {
        // Create common test accounts
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<200;i++) {
            if(math.mod(i,3) == 0){
                testAccts.add(new Account(Name = 'TestAcct'+i, Type = 'Pending'));    
            }
            else if(math.mod(i,3) == 1){
                testAccts.add(new Account(Name = 'TestAcct'+i, Type = 'Pending', Industry = 'Agriculture'));
            }
            else{
                testAccts.add(new Account(Name = 'TestAcct'+i, Type = 'Pending', AccountSource = 'Web'));
            }
            
        }
        insert testAccts;
    }
    
    @isTest static void testMethod1() {
        // Get account list by using a SOQL query
        List<Id> accIdSet = new List<Id>();
        List<Account> acctList = [SELECT Name, Active__c, Type, Industry, AccountSource FROM Account];
        for(Account acc : acctList){
            accIdSet.add(acc.Id);
        }
        
        DataTableController.filterAccountList('Pending', 'Agriculture', null);
        DataTableController.filterAccountList('Pending', null, 'Web');
        // This update is local to this test method only.
        
        DataTableController.updateRecords(accIdSet);
        
        for(Account acc : [SELECT Active__c FROM Account]){
            System.assertEquals('Yes', acc.Active__c, 'Account not updated successfully');
        }
        
        DataTableController.getAccountList();
        
        // Perform some testing
    }
    
    @isTest static void testMethod2() {
        // Get account list by using a SOQL query
        List<String> accIdSet = new List<String>();
        List<Account> acctList = [SELECT Name, Active__c, Type, Industry, AccountSource FROM Account];
        for(Account acc : acctList){
            accIdSet.add(acc.Id);
        }
        delete acctList;
        // This update is local to this test method only.
        try{
            DataTableController.updateRecords(accIdSet);
        }catch(Exception e){}
        
        
        DataTableController.getAccountList();
        
        // Perform some testing
    }
}