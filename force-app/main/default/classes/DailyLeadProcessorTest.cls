@isTest
private class DailyLeadProcessorTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @testsetup 
    static void prepareTestData() {
      List<Lead> leadList = new List<Lead>();
      for(Integer i=0; i<200; i++){
        leadList.add(new Lead(lastName = 'test lastName', company = 'test comp'));
      }
      
      insert leadList;
      
    }//ENd @testsetup static void prepareTestData()
    
    
    static testmethod void testScheduledJob() {
        
        List<Lead> leadList = [select leadSource from Lead];
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP, new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.
        List<Lead> leadList1 = [select leadSource from Lead where leadSource = 'Dreamforce'];
        System.assertEquals(0, leadList1.size(), 'Lead are not updated yet');
        // Stopping the test will run the job synchronously
        Test.stopTest();
        
        // Now that the scheduled job has executed,
        // check that our tasks were created
        List<Lead> leadList2 = [select leadSource from Lead where leadSource = 'Dreamforce'];
        System.assertEquals(200, leadList2.size(), 'Lead are now updated');
    }
}