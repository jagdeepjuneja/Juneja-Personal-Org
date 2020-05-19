@IsTest
private class AccountProcessorTest {
  
  @testsetup 
  static void prepareTestData() {
      List<Account> accList = Utility.createAccount(1, true);
      
      List<Contact> conList = Utility.createContact(2, false);
      
      for(Contact con : conList){
        con.AccountId = accList[0].Id;
      }
      
      insert conList;
      
  }//ENd @testsetup static void prepareTestData()
  
  
  @IsTest
  private static void testSendSms() {
    Map<Id, Account> accMap = new Map<Id, Account>([select id from Account]);
    
    Test.setMock(HttpCalloutMock.class, new AccountProcessorMock());
    Test.startTest();
      AccountProcessor.countContacts(new List<Id>(accMap.keySet()));
    Test.stopTest();
    // runs callout and check results
    
    for(Account acc : [select Number_of_Contacts__c FROM Account]){
      System.assertEquals(2, acc.Number_of_Contacts__c, 'Number of child contacts are not equals');  
    }
  }
}