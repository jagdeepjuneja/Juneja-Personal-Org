public class contactRolePageExtension {
  
  public Opportunity oppt;

  
  public contactRolePageExtension(ApexPages.StandardController stdController) {
        this.oppt = (Opportunity)stdController.getRecord();
        System.debug('test oppt is '+oppt);
    }

}