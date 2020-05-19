public class deleteContactController {
  
  public String conDeleteId {get;set;}
  public List<Contact> conList {get;set;}
  ApexPages.StandardController stdCtrl;
  
  public deleteContactController(ApexPages.StandardController controller) {
  	stdCtrl = controller;
  	setupContacts();
  }
  
  public void setupContacts(){
    conList = [SELECT Name, Phone, Email, AccountId FROM Contact WHERE AccountId =: stdCtrl.getId()];
  }
  
  public void deleteSelectedContact(){
    System.debug('jagdeep conDeleteId is '+conDeleteId);
    Contact con = new Contact(Id = conDeleteId);
    delete con;
    
    setupContacts();
  }
}