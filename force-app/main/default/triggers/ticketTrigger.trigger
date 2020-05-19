trigger ticketTrigger on Ticket__c (before insert, before update) {
  
  if(Trigger.isInsert){
    TicketHandlerClass.beforeInsert(Trigger.New);
  }
  else if(Trigger.isUpdate){
    TicketHandlerClass.beforeUpdate(Trigger.New, Trigger.oldMap);
  }
}