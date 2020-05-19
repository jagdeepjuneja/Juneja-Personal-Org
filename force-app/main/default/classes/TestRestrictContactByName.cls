@isTest(seeAllData = false)

//https://trailhead.salesforce.com/modules/apex_testing/units/apex_testing_triggers
public class TestRestrictContactByName {
  
  static testMethod void contactInsertTestMethod(){
    Contact con = new Contact(lastName = 'INVALIDNAME');
    Database.SaveResult[] srList = Database.insert(new List<Contact>{con}, false);
    
    for (Database.SaveResult sr : srList) {
      if(!sr.isSuccess()) {
        for(Database.Error err : sr.getErrors()) {
          System.assertEquals('The Last Name INVALIDNAME is not allowed for DML', err.getMessage());
        }
      }
    }
  }
}