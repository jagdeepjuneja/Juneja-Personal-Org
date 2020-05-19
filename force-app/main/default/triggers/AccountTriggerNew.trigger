trigger AccountTriggerNew on Account (after insert) {
  AccounttTriggerHandler ctrl = new AccounttTriggerHandler();
  
  if(Trigger.isAfter && Trigger.isInsert){
    ctrl.afterInsert(Trigger.New);
  }
}