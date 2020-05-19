/*Trigger ContactTrigger2 on Contact(after insert, after update, after delete, after undelete){
  ContactTriggerHanlder obj = new ContactTriggerHanlder();
  if(Trigger.isInsert || Trigger.isUndelete){
    obj.afterInsertUpdateDeleteUndelete(Trigger.New, null);
  }
  if(Trigger.isUpdate){
    obj.afterInsertUpdateDeleteUndelete(Trigger.New, Trigger.oldMap);
  }
  if(Trigger.isDelete){
    obj.afterInsertUpdateDeleteUndelete(Trigger.old, null);
  }
}*/

Trigger ContactTrigger2 on Contact(before insert, before update){
  ContactTriggerHanlder obj = new ContactTriggerHanlder();
  if(Trigger.isInsert || Trigger.isUpdate){
    obj.afterInsertUpdateDeleteUndelete(Trigger.New, null);
  }
  
}