public class encryptClass {
  
  public Position__c pos{get;set;} 
  public encryptClass(ApexPages.StandardController controller) {
	  pos = new Position__c();
  }
  
  public void save(){
    
  }
  
  public void onLookupChange(){
    system.debug('test '+pos.Hiring_Manager__c);
  }
}