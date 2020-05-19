public Class ContactTriggerHanlderNew{

  public void afterInsertUpdateDeleteUndelete(List<Contact> conList, Map<Id, Contact> oldMap){
    updateCountOnAccountAfterInsert(conList, oldMap);
  }
  
  public void updateCountOnAccountAfterInsert(List<Contact> conList, Map<Id, Contact> oldMap){
    System.debug('test in updateCountOnAccountAfterInsert method');
    Map<Id, Decimal> mapOfAccIdAndCurrentAmt = new Map<Id, Decimal>();
    Decimal sum = 0;
    Decimal temp = 0;
    
    for(Contact con : conList){
      if(con.Accountid != null && con.Amount__c != null){
        if(mapOfAccIdAndCurrentAmt.containsKey(con.AccountId)){
          sum = mapOfAccIdAndCurrentAmt.get(con.AccountId);
          temp = sum+ con.Amount__c;
          mapOfAccIdAndCurrentAmt.put(con.AccountId, temp);
        }
        else{
          mapOfAccIdAndCurrentAmt.put(con.AccountId, con.Amount__c);
        }
      }
    }
  
  }
}