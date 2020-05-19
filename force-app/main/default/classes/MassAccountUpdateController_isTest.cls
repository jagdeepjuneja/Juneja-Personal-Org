@isTest
private class MassAccountUpdateController_isTest {

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
    
    @isTest static void FilterAccountTest() {
        // Get account list by using a SOQL query
        List<Id> accIdSet = new List<Id>();
        List<Account> acctList = [SELECT Name, Active__c, Type, Industry, AccountSource FROM Account];
        for(Account acc : acctList){
            accIdSet.add(acc.Id);
        }
        
        DataTableController.filterAccountList('Pending', 'Agriculture', null);
        DataTableController.filterAccountList('Pending', null, 'Web');
        
        DataTableController.updateRecords(accIdSet);
        
        for(Account acc : [SELECT Active__c FROM Account]){
            System.assertEquals('Yes', acc.Active__c, 'Account not updated successfully');
        }
        
        DataTableController.getAccountList();
    }
    
    @isTest static void ActivateAccountTest() {
        // Get account list by using a SOQL query
        List<String> accIdSet = new List<String>();
        List<Account> acctList = [SELECT Name, Active__c, Type, Industry, AccountSource FROM Account];
        for(Account acc : acctList){
            accIdSet.add(acc.Id);
        }
        delete acctList;
        try{
            DataTableController.updateRecords(accIdSet);
        }catch(Exception e){}
        System.assertEquals(0, acctList.size(), 'Records not deleted');
        
        DataTableController.getAccountList();
        
        // Perform some testing
    }
}