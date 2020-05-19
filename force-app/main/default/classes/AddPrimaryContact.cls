public class AddPrimaryContact implements Queueable {
    
    private Contact con;
    private String state;
    
    public AddPrimaryContact(Contact con, String state) {
        this.con = con;
        this.state = state;
    }
    
    public void execute(QueueableContext context) {
      
      List<Account> accList = [select id from Account where billingState =: state];
      List<Contact> conListToInsert  = new List<Contact>();
      Contact con1 = new Contact();
      
        for(Account acc : accList) {
          con1 = con.clone();
          con1.AccountId = acc.Id;
          conListToInsert.add(con1);
        }
        
        insert conListToInsert;
    }
    
}