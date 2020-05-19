@isTest
private class LeadProcessorTest {
    @testSetup 
    static void setup() {
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 0; i<200; i++){
          leadList.add(new Lead(LastName = 'test last', company = 'test company'));
        }
        insert leadList;
        
    }
    static testmethod void test() {        
      
        List<Lead> leadList = [select LeadSource FROM Lead];
        Test.startTest();
        LeadProcessor obj = new LeadProcessor();
        Id batchId = Database.executeBatch(obj);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        for(Lead ld : [select LeadSource FROM Lead]){
          System.assertEquals('Dreamforce', ld.LeadSource);  
        }
    }
    
}