trigger AccountTrigger2 on Account (after insert, after update) {
  if(Trigger.Isafter && Trigger.isInsert){
    AccountTriggerHandler2.afterInsert(Trigger.New);
  }

  /*if(Trigger.isAfter && Trigger.isUpdate){
    AccountTriggerHandler2.afterUpdate(Trigger.New, Trigger.oldMap);
  }*/
}