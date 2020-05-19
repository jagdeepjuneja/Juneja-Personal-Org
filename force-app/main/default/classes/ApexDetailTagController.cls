public class ApexDetailTagController {
    public Id AccountId {get;set;}
  
    public ApexDetailTagController() {
        AccountId = [SELECT Id FROM Account LIMIT 1].Id;
    }
}