trigger CaseTrigger on Case (after update) {
  if(Trigger.isAfter && Trigger.isUpdate){
      CaseTriggerHandler.afterUpdate(Trigger.New, Trigger.old, Trigger.newMap, Trigger.oldMap);
  }
}