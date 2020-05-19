trigger AccountTrigger on Account (before insert, after insert) {
  if(Trigger.isBefore && Trigger.isInsert){
    AccountTriggerHandler.beforeInsert(Trigger.New);
  }

  if(Trigger.isAfter && Trigger.isInsert){
    AccountTriggerHandler.afterInsert(Trigger.New);
  }
}