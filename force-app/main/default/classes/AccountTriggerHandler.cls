public class AccountTriggerHandler {
  public static void beforeInsert(List<Account> newList){
    for(Account acc: newList){
      if(String.isBlank(acc.AccountNumber)){
        System.debug('jagdeep in before insert trigger');
        //acc.addError('Account Number can not be blank - error from Apex before Trigger');
      }
      System.debug('jagdeep in before insert trigger');
      acc.AccountNumber = '1234';
    }
  }
  
  public static void afterInsert(List<Account> newList){
    for(Account acc: newList){
      System.debug('test in after insert to show error');
      //acc.addError('record error on after insert.');
    }
  }  
}