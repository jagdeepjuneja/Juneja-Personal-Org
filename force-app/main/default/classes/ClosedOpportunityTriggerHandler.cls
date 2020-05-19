public class ClosedOpportunityTriggerHandler {
  
  public void beforeInsert(List<Opportunity> newList){
    createTaskForClosedWonOpp(newList, null);
  }
  
  public void beforeUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
    createTaskForClosedWonOpp(newList, oldMap);
  }
  
  public static void createTaskForClosedWonOpp(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
    List<Task> taskListToCreate = new List<Task>();
    
    for(Opportunity opp : newList){
      if( (Trigger.isInsert || (Trigger.isUpdate && oldMap.get(opp.Id).StageName != opp.StageName) && opp.StageName == 'Closed won')){
        taskListToCreate.add(new Task(subject = 'Follow Up Test Task', whatId = opp.id));
      }
    }
    
    if(!taskListToCreate.isEmpty()){
      insert taskListToCreate;
    }
  }
}