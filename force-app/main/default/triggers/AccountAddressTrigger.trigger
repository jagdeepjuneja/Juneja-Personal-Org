trigger AccountAddressTrigger on Account (before insert, before update) {
  AccountAddressTriggerHandler obj = new AccountAddressTriggerHandler();
  
  if(Trigger.isBefore && Trigger.isInsert){
    obj.beforeInsert(Trigger.New);
  }
  if(Trigger.isBefore && Trigger.isUpdate){
    obj.beforeUpdate(Trigger.New, Trigger.oldMap);
  }
}