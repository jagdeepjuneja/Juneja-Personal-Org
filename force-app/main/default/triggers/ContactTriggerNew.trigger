Trigger ContactTriggerNew on Contact(after insert, after update, after delete, after undelete){
 ContactTriggerHanlderNew obj = new ContactTriggerHanlderNew();
 
 if(Trigger.isInsert /*|| Trigger.isUndelete*/){
   obj.afterInsertUpdateDeleteUndelete(Trigger.New, null);
 }
 /*if(Trigger.isUpdate){
   obj.afterInsertUpdateDeleteUndelete(Trigger.New, Trigger.oldMap);
 }
 if(Trigger.isDelete){
   obj.afterInsertUpdateDeleteUndelete(Trigger.old, null);
 }*/
}