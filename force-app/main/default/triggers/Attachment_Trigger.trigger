trigger Attachment_Trigger on Attachment (after insert, after update, after delete) {
    
    AttachmentTriggerHandler obj = new AttachmentTriggerHandler();
    if(Trigger.isAfter && Trigger.isInsert){
      obj.afterInsert(Trigger.New);
    }
    
    else if(Trigger.isAfter && Trigger.isUpdate){
      obj.afterUpdate(Trigger.New, Trigger.oldMap);
    }
    
    else if(Trigger.isAfter && Trigger.isDelete){
      obj.afterDelete(Trigger.old);
    }
}