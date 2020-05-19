public Class ContactTriggerHanlder{

  /*public void afterInsertUpdateDeleteUndelete(List<Contact> conList, Map<Id, Contact> oldMap){
    updateCountOnAccountAfterInsert(conList, oldMap);
  }
  
  public void updateCountOnAccountAfterInsert(List<Contact> conList, Map<Id, Contact> oldMap){
    Set<Id> accIds = new Set<Id>();
    Map<Id, List<Contact>> mapOfAccIdAndConList = new Map<Id, List<Contact>>();
    List<Account> accListToUpdate = new List<Account>();
    
    for(Contact con: conList){
      //System.debug('test parent checkbox is '+con.Account.Match_Billing_Address__c); parent field is false but actually it is true.
      //Account acc = [select Match_Billing_Address__c from Account where id = :con.AccountId];
      //System.debug('test parent checkbox is '+acc.Match_Billing_Address__c);  //show correct value that is true.
      if(Trigger.isInsert || Trigger.isDelete || Trigger.isUndelete){
        if(con.AccountId != NULL){
              accIds.add(con.AccountId);
            }
        }
      
      if(Trigger.isUpdate){
        if(con.AccountId != oldMap.get(con.Id).AccountId){
              if(con.AccountId != NULL){
                accIds.add(con.AccountId);
              }
              if(oldMap.get(con.Id).AccountId != NULL){
                accIds.add(oldMap.get(con.Id).AccountId);
              }
            }
      }
    }
    
    if(!accIds.isEmpty()){
      for(Contact con: [SELECT AccountId FROM Contact WHERE AccountId IN: accIds]){
        if(mapOfAccIdAndConList.containsKey(con.AccountId)){
          mapOfAccIdAndConList.get(con.AccountId).add(con);
        }
        else{
          mapOfAccIdAndConList.put(con.AccountId, new List<Contact>{con});  
        }
      }
    }
    
    if(!mapOfAccIdAndConList.isEmpty()){
      for(Id accId : mapOfAccIdAndConList.keySet()){
        accListToUpdate.add(new Account(Id = accId, Child_Contacts__c = mapOfAccIdAndConList.get(accId).size()));
      }
    }
    
    if(!accListToUpdate.isEmpty()){
      update accListToUpdate;
    }
    
  }*/
  
  public void afterInsertUpdateDeleteUndelete(List<Contact> conList, Map<Id, Contact> oldMap){
    for(Contact con : conList){
      String phone = con.Phone;
      System.debug('trigger in before udpate 1 ');
      if(phone!= null && phone.startsWith('0')){
        System.debug('trigger in before udpate 2');
        phone = phone.replaceFirst('0', '+91');
        con.Phone = phone;
        System.debug('test phone is '+con.Phone);
      }
    }
  }
  
  
}