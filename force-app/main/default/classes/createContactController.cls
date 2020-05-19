public class createContactController {
    
  public string companyDiscussed {get;set;}
  public Contact con{get;set;}
  
  public createContactController(ApexPages.StandardController controller) {
      con = new Contact();
  }
  
  
  public PageReference save(){
      System.debug('jagdeep con.LastName is '+con.LastName);
      
      if(con.LastName == null){
          ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error,'Last name can not be null'));
      }
      system.debug('jagdeep companyDiscussed is '+companyDiscussed);
      List<Account> accList = [SELECT Company__c FROM Account WHERE Company__c =: companyDiscussed];
      if(accList.size() > 0 && con.LastName != null){
        con.AccountId =  accList[0].Id;
        insert con;
        
        
      }
      if(con != null){
        return new Pagereference('/'+con.Id);  
      }
      else {
          return new Pagereference('https://junejajagdeep-dev-ed--c.ap4.visual.force.com/apex/createContactPage');  
      }
      
      
  }
  
}