trigger ContactTrigger on Contact (after insert, after update, after delete) {
    
  if(Trigger.isAfter && (Trigger.isInsert  || Trigger.isUpdate || Trigger.isDelete)){
    ContactTriggerHandler.onAfterInsertUpdateDelete(Trigger.New, Trigger.oldMap, Trigger.old);
  }
  
}