public class ContactTriggerHandler {
    
    public static void onAfterInsertUpdateDelete(List<Contact> newLIst, Map<Id, Contact> oldMap, List<Contact> oldLIst){
        updateFieldOnAccount(newLIst, oldMap, oldLIst);
    }
    
  
    public static void updateFieldOnAccount(List<Contact> newList, Map<Id, Contact> oldMap, List<Contact> oldList){
        System.debug('test in updateFieldOnAccount method');
        Set<Id> accIdSet = new Set<Id>();
        List<Account> accListToUpdate = new List<Account>();
        
        if(Trigger.isInsert || Trigger.isUpdate){
            for(Contact con: newList ){
                if(Trigger.isInsert && con.AccountId != NULL){
                    accIdSet.add(con.AccountId);
                }
                else if(Trigger.isUpdate && oldMap.get(con.Id).AccountId != con.AccountId){
                    if(con.AccountId != NULL){
                      accIdSet.add(con.AccountId);  
                    }
                    if(oldMap.get(con.Id).AccountId != NULL){
                        accIdSet.add(oldMap.get(con.Id).AccountId);  
                    }
                }
                
            }
        }
        
        
        if(Trigger.isDelete){
            for(Contact con: oldList){
                if(con.AccountId != NULL){
                    accIdSet.add(con.AccountId);
                }
            }
        }
        
        
        System.debug('test accIdSet is '+accIdSet);
        for(Account acc: [SELECT Child_Contacts_Id__c, (SELECT Id FROM Contacts) FROM Account WHERE ID IN: accIdSet]){
            acc.Child_Contacts_Id__c = '';
            for(Contact con : acc.Contacts){
                acc.Child_Contacts_Id__c += con.Id + ' ** ';
            }
            accListToUpdate.add(acc);
        }
        
        System.debug('test accListToUpdate is '+accListToUpdate);
        
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }
    
}