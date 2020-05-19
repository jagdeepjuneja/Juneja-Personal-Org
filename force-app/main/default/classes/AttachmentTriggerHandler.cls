public class AttachmentTriggerHandler {
  
  public void afterInsert(List<Attachment> newList){
    updateCountOnParent(newList, null);
  }
  
  public void afterUpdate(List<Attachment> newList, Map<Id, Attachment> oldMap){
    updateCountOnParent(newList, oldMap);
  }
  
  public void afterDelete(List<Attachment> oldList){
    updateCountOnParent(oldList, null);
  }
  
  public void updateCountOnParent(List<Attachment> newList, Map<Id, Attachment> oldMap){
    List<sObject> sObjListToUpdateIncrement = new List<sObject>();
    List<sObject> sObjListToUpdateDecrement = new List<sObject>();
    
    Set<String> parentIdSetForInsertCount = new Set<String>();
    Set<String> parentIdSetForDeleteCount = new Set<String>();
    
    Set<String> parentIdSet = new Set<String>();
    
    
    System.debug('test in update count method.');
    for(Attachment att : newList){
      if(Trigger.isInsert){
        if(att.ParentId <> NULL){
          parentIdSetForInsertCount.add(att.ParentId);
          parentIdSet.add(att.ParentId);
        }
      }
      
      if(Trigger.isUpdate){
        if(oldMap.get(att.Id).ParentId != att.ParentId){
          if(oldMap.get(att.Id).ParentId <> null){
            parentIdSetForDeleteCount.add(oldMap.get(att.Id).ParentId);
            parentIdSet.add(oldMap.get(att.Id).ParentId);
          }
          
          if(att.ParentId <> null){
            parentIdSetForInsertCount.add(att.ParentId);
            parentIdSet.add(att.ParentId);
          }
        }
      }
      
    }
    
    System.debug('test parentIdSetForInsertCount is '+parentIdSetForInsertCount);
    System.debug('test parentIdSetForDeleteCount is '+parentIdSetForDeleteCount);
    
    /*for(String recId : parentIdSetForInsertCount){
      String recordId = recId;
      String objectAPIName = '';
      String keyPrefix = recordId.substring(0,3);
        for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
          String prefix = obj.getDescribe().getKeyPrefix();
          if(prefix == keyPrefix){
            objectAPIName = obj.getDescribe().getName();
            break;
          }
        }
      System.debug(objectAPIName);
      sObject sObj = Schema.getGlobalDescribe().get(objectAPIName).newSObject() ;
      sObj.Id = recId;
      sObjListToUpdateIncrement.add(sObj);
    }
    
    for(String recId : parentIdSetForDeleteCount){
      String recordId = recId;
      String objectAPIName = '';
      String keyPrefix = recordId.substring(0,3);
        for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
          String prefix = obj.getDescribe().getKeyPrefix();
          if(prefix == keyPrefix){
            objectAPIName = obj.getDescribe().getName();
            break;
          }
        }
      System.debug(objectAPIName);
      sObject sObj = Schema.getGlobalDescribe().get(objectAPIName).newSObject() ;
      sObj.Id = recId;
      sObjListToUpdateDecrement.add(sObj);
    }*/
    
    List<String> parentIdList = new List<String>();
    parentIdList.addAll(parentIdSet);
    parentIdList.sort();
    
    Map<String, List<String>> mapOfApiNameAndIdSet = new Map<String, List<String>>();
    
    for(String recId : parentIdSetForInsertCount){
      String recordId = recId;
      String objectAPIName = '';
      String keyPrefix = recordId.substring(0,3);
        for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
          String prefix = obj.getDescribe().getKeyPrefix();
          if(prefix == keyPrefix){
            objectAPIName = obj.getDescribe().getName();
            break;
          }
        }
      System.debug(objectAPIName);
      sObject sObj = Schema.getGlobalDescribe().get(objectAPIName).newSObject() ;
      sObj.Id = recId;
      sObjListToUpdateIncrement.add(sObj);
      
      if(mapOfApiNameAndIdSet.containsKey(objectAPIName)){
      	mapOfApiNameAndIdSet.get(objectAPIName).add(recId); 
       }
       else{
      	mapOfApiNameAndIdSet.put(objectAPIName, new List<String>{recId});  
       }
    }
    
    for(String recId : parentIdSetForDeleteCount){
      String recordId = recId;
      String objectAPIName = '';
      String keyPrefix = recordId.substring(0,3);
        for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
          String prefix = obj.getDescribe().getKeyPrefix();
          if(prefix == keyPrefix){
            objectAPIName = obj.getDescribe().getName();
            break;
          }
        }
      System.debug(objectAPIName);
      sObject sObj = Schema.getGlobalDescribe().get(objectAPIName).newSObject() ;
      sObj.Id = recId;
      sObjListToUpdateDecrement.add(sObj);
      
      if(mapOfApiNameAndIdSet.containsKey(objectAPIName)){
      	mapOfApiNameAndIdSet.get(objectAPIName).add(recId); 
       }
       else{
      	mapOfApiNameAndIdSet.put(objectAPIName, new List<String>{recId});  
       }
    }
    
    System.debug('test mapOfApiNameAndIdSet is '+mapOfApiNameAndIdSet);
    
    for(String objApiName : mapOfApiNameAndIdSet.keySet()){
      sObject sObj = Schema.getGlobalDescribe().get(objApiName).newSObject();
      //List<sObject> li = [select count__c from sObject];
    }
    
    
  }
}