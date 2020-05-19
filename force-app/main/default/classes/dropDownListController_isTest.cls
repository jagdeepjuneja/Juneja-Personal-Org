@isTest(SeeAllData = false)
/*
    Created By  : Appirio - Jagdeep Juneja
    Created On  : 5/1/2017
    Purpose     : A test class for dropDownListController page controller.
    --------------------------------------------------------------------------
*/
public class dropDownListController_isTest {
    
    @testsetup 
    static void prepareTestData() {
      List<Account> accList = Utility.createAccount(100, true);
      
    }//ENd @testsetup static void prepareTestData()
      
    static TestMethod void querySelectedRecordTestMethod() {
        
        Test.startTest();
        
            dropDownListController ctrl = new dropDownListController();
            
            //Test when user don't select any object.
            ctrl.selectedObjectApiName = 'None';
            ctrl.showFieldTable();
            ctrl.queryRecords();
            
            //Test when user select Account object, but don't select any field to query.
            ctrl.selectedObjectApiName = 'Account';
            ctrl.showFieldTable();
            ctrl.queryRecords();
            
            //Test when user select Account object, and also make field selection.
            dropDownListController.FieldTableWrapper wrap = new dropDownListController.FieldTableWrapper('Name','String'); 
            ctrl.selectedObjectApiName = 'Account';
            ctrl.showFieldTable();
            ctrl.fieldTableWrapperList.get(0).selected = true;
            ctrl.queryRecords();
            
            List<Account> accList = [SELECT Name FROM Account];
            
            for(Integer i=0; i<accList.size(); i++ ){
                System.assertEquals('test '+i, accList[i].Name, 'Account Name is not retrieved in query from Database');
            }
        
        Test.stopTest();
      
    }
    
}