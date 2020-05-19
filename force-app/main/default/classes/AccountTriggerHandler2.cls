public class AccountTriggerHandler2 {
    
  public static void afterInsert(List<Account> newList){
      updateDescriptionOnInsert(newList);
  }
  public static void afterUpdate(List<Account> newList){
      updateDescriptionOnInsert(newList);
  }
  
  public static void updateDescriptionOnInsert(List<Account> newList){
    Set<Id> parentAccIds = new Set<Id>();
    List<Account> accListToUpdate = new List<Account>();
    for(Account acc: newList){
        System.debug('test first debug');
        if(acc.ParentId != NULL){
          parentAccIds.add(acc.ParentId);    
        }
        
    }
    System.debug('test parentAccIds is '+parentAccIds);
    for(Account acc:  [select id,Description, (select Name,ParentId from ChildAccounts) from Account where id In: parentAccIds]){
        acc.Description = '';
        for(Account childAcc : acc.ChildAccounts){
          acc.Description +=   childAcc.Name+',';
          accListToUpdate.add( new Account(Id = acc.Id));
          System.debug('test in for loop');
        }
    }
    
    if(!accListToUpdate.isEmpty()){
        update accListToUpdate;
    }  
      
      
  }
      
      
  
  
}