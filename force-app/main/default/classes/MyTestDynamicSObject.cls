public class MyTestDynamicSObject {
  
  
    public MyTestDynamicSObject() {
        sObjRecord      = (sObject) Schema.getGlobalDescribe().get('Contact').newSObject(null, true);
        sObjRecord.put('LastName', 'Test name');
    }

    public  sObject     sObjRecord  { get;set; }

    public void saveRecord() {
      System.debug('test sObjRecord is '+sObjRecord);
        try {
            insert sObjRecord;
        } catch (Exception ex) {
            ApexPages.addMessages(ex);
        }
    }
    
    public void myActionInController(){
      System.debug('test sObjRecord is '+sObjRecord);
      ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error,'Account record does not exist'));
    }
}