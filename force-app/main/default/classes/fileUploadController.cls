public class fileUploadController {
  public Account obj {get;set;}
  
  public fileUploadController(){
    System.debug('first');
    //obj = new Demo_Object__c();
    //obj = [select id from Demo_Object__c where id = 'a0S0I00000CqOgl'];
    obj = new Account(Id = '0016F000035LTwI');
  }
  
  
  public void createDemoObjectRecord(){
    System.debug('second');
    //insert obj;
  }
}