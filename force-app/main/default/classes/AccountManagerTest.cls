@IsTest
private class AccountManagerTest {
    @isTest static void testGetCaseById() {
        Account acc = createTestAccount();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri ='https://junejajagdeep-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+ acc.id +'/contacts' ;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
    }
      
    // Helper method
    static Account createTestAccount() {
        List<Account> accList = Utility.createAccount(1, true);
        
        List<Contact> conList = Utility.createContact(2, false);
      
        for(Contact con : conList){
          con.AccountId = accList[0].Id;
        }
        
        insert conList;
        
        return accList[0];
    }          
}