trigger StudentTrigger on Student__c (after insert, after update) {
  StudentTriggerHandler ctrl = new StudentTriggerHandler();
  
  if(Trigger.isAfter && Trigger.isInsert){
    ctrl.afterInsert(Trigger.New);
  }
}