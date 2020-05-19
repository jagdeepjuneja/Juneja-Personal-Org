public class AccountAddressTriggerHandler {
  //hello test
  public void beforeInsert(List<Account> newList){
    updateShippingAddressSameBillingAddress(newList, null);
  }
  
  public void beforeUpdate(List<Account> newList, Map<Id, Account> oldMap){
    updateShippingAddressSameBillingAddress(newList, oldMap);
  }
  
  public static void updateShippingAddressSameBillingAddress(List<Account> newList, Map<Id, Account> oldMap){
    for(Account acc: newList){
      if(acc.Match_Billing_Address__c && acc.BillingPostalCode != null){
        acc.ShippingPostalCode = acc.BillingPostalCode;
      }
    }
  }
}