@isTest(seeAllData = false)

//https://trailhead.salesforce.com/modules/apex_testing/units/apex_testing_triggers
public class TestVerifyDate {
  
  static testMethod void CheckDatesTest(){
    VerifyDate.CheckDates(System.today(), System.today().addDays(-2));
    
    VerifyDate.CheckDates(System.today(), System.today().addDays(2));
  }

}