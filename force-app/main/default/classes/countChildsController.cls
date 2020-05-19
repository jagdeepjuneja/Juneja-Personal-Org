public class countChildsController {
  private String accountId;
  public Integer contactListSize {get;set;}
  
  public countChildsController(ApexPages.StandardController controller) {
	  accountId=ApexPages.currentPage().getParameters().get('Id');
	  contactListSize = [SELECT ID FROM Contact WHERE AccountId =: accountId].size();
  }
}