//https://salesforce.stackexchange.com/questions/258599/trigger-to-implement-one-ticket-per-active-user-per-day/258615#258615
public class TicketHandlerClass {
  
  public static void beforeInsert(List<Ticket__c> newList){
    handleTicketUpsert(newList, null);
  }
  public static void beforeUpdate(List<Ticket__c> newList, Map<Id, Ticket__c> oldMap){
    handleTicketUpsert(newList, oldMap);
  }
  
  public static void handleTicketUpsert(List<Ticket__c> newList, Map<Id, Ticket__c> oldMap){
    Set<Id> assigneeIdSet = new Set<Id>();
    
    for(Ticket__c t : [select Assigned_To__c FROM Ticket__c WHERE Assigned_To__c <> NULL AND Status__c = 'Active' AND ID NOT IN: newList AND CreatedDate = TODAY]){
      assigneeIdSet.add(t.Assigned_To__c);
    }
    
    System.debug('test assigneeIdSet is '+assigneeIdSet);
    
    for(Ticket__c t : newList){
      if(t.Assigned_To__c <> NULL && t.Status__c == 'Active'){
        System.debug('test first if');
        if(assigneeIdSet.contains(t.Assigned_To__c)){
          System.debug('test second if');
          t.addError('one active ticket per user in a day');
        }
      }
    }
  }
}