public class AccountPageController {
  
  private String accId;
  public String accName {get;set;}
  public String accPhone {get;set;}
  public String accType {get;set;}
  public Account acc {get;set;}
  
  
  
  public AccountPageController(){
    accName = '';
    accPhone = '';
    accType = '';
    accId = ApexPages.currentPage().getParameters().get('Id');
      
    //AccountProcessor.countContacts(new List<Id>{});  //This will now wok.Error System.LimitException: @future call currently not allowed
      
    acc = new Account();
    
    if(accId <> null){
      acc = [SELECT Joint_Field__c FROM Account WHERE ID =: accId];
      System.debug('test acc.Joint_Field__c is '+acc.Joint_Field__c);
      String[] arr = String.valueOf(acc.Joint_Field__c).split('-');
      accName = arr[0];
      accPhone = arr[1];
      accType = arr[2];
    }
    
  }
  
  public void createAccount(){
     acc.Name = accName;
     acc.Phone = accPhone;
     acc.Type = accType;
     acc.Joint_Field__c = acc.Name + '-' + acc.Phone + '-' + acc.Type;
     upsert acc;
  }
    
    public void CallFutureHere(){//Example to invoke future using action attribute.
        AccountProcessor.countContacts(new List<Id>{});
    }


}