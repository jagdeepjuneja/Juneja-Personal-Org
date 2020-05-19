public class CaseTriggerHandler {
  public static void afterUpdate(List<Case> newList, List<Case> oldList, Map<Id, Case> newMap, Map<Id, Case> oldMap){
      //closeTaskOnCaseClose(newList,oldList,newMap,oldMap);
  }
  
  public static void closeTaskOnCaseClose(List<Case> newList, List<Case> oldList, Map<Id, Case> newMap, Map<Id, Case> oldMap){
      Set<Id> caseIdSet = new Set<Id>();
      List<Task> taskListToUpdate = new List<Task>();
      for(Case c: newList){
          if(c.status == 'Closed'){
              caseIdSet.add(c.Id);
          }
      }
     
     System.debug('jagdeep caseIdSet is '+caseIdSet); 
     for(Task t: [SELECT ID FROM Task WHERE WhatID IN : caseIdSet]){
         t.status = 'closed';
         taskListToUpdate.add(t);
     }
     
     System.debug('jagdeep taskListToUpdate is '+taskListToUpdate); 
     update taskListToUpdate;
  }
}