public class picklistController {
  public Position__c pos {get;set;}
  
  public picklistController(){
    pos = new Position__c();
  }
  
  public void save(){
    insert pos;
  }
}