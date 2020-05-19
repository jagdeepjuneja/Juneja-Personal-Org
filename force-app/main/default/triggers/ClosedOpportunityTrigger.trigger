trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
  ClosedOpportunityTriggerHandler obj = new ClosedOpportunityTriggerHandler();
  
  if(Trigger.isBefore && Trigger.isInsert){
    obj.beforeInsert(Trigger.New);
  }
  if(Trigger.isBefore && Trigger.isUpdate){
    obj.beforeUpdate(Trigger.New, Trigger.oldMap);
  }
}