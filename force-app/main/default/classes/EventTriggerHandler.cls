public class EventTriggerHandler {
    
    public static void onBeforeInsertUpdate(List<Event> newLIst){
        updateEventType(newLIst);
    }
    
    public static void onAfterInsertUpdate(List<Event> newLIst){
        updateActivityScoreOnAccountOrContact(newLIst);
    }
  
    public static void updateActivityScoreOnAccountOrContact(List<Event> newList){
        System.debug('test in updateActivityScoreOnAccountOrContact method');
        Set<Id> conIdSet = new Set<Id>();
        Set<Id> accIdSet = new Set<Id>();
        List<Contact> conListToUpdate = new List<Contact>();
        List<Account> accListToUpdate = new List<Account>();
        Integer callCount;
        Integer emailCount;
        Integer meetingCount;
        
        for(Event et: newList){
            if(et.whoId != NULL && String.valueof(et.WhoId).startsWith('003')){
                conIdSet.add(et.whoId);
            }
            
            if(et.whatId != NULL && String.valueof(et.whatId).startsWith('001')){
                accIdSet.add(et.whatId);
            }
            
        }
        System.debug('test conIdSet is'+conIdSet);
        System.debug('test accIdSet is'+accIdSet);
        
        if(!conIdSet.isEmpty()){
            List<Contact> conList = [SELECT Activity_score__c, (SELECT Type FROM Events WHERE Type IN ('Call', 'Email', 'Meeting'))
                                        FROM Contact WHERE ID IN: conIdSet];
            for(Contact con: conList){
                callCount = 0;
                emailCount = 0;
                meetingCount = 0;
                
                for(Event et: con.Events){
                    if(et.Type == 'Call'){
                        callCount++;
                    }
                    else if(et.Type == 'Email'){
                        emailCount++;
                    }
                    else if(et.Type == 'Meeting'){
                        meetingCount++;
                    }
                }
                con.Activity_score__c = meetingCount*3 + callCount*2 + emailCount;
                conListToUpdate.add(con);
            }                            
        }
        
        if(!accIdSet.isEmpty()){
            List<Account> accList = [SELECT Activity_score__c, (SELECT Type FROM Events WHERE Type IN ('Call', 'Email', 'Meeting'))
                                        FROM Account WHERE ID IN: accIdSet];
            for(Account acc: accList){
                callCount = 0;
                emailCount = 0;
                meetingCount = 0;
                
                for(Event et: acc.Events){
                    if(et.Type == 'Call'){
                        callCount++;
                    }
                    else if(et.Type == 'Email'){
                        emailCount++;
                    }
                    else if(et.Type == 'Meeting'){
                        meetingCount++;
                    }
                }
                acc.Activity_score__c = meetingCount*3 + callCount*2 + emailCount;
                accListToUpdate.add(acc);
            }                            
        }
        
        System.debug('test conListToUpdate is '+conListToUpdate);
        System.debug('test accListToUpdate is '+accListToUpdate);
        
        if(conListToUpdate.size() > 0){
            update conListToUpdate;
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
        
    }  
  
    public static void updateEventType(List<Event> newList){
        System.debug('test in updateEventType method');
    
        for(Event evt: newList){
            if(evt.Subject != NULL && !String.isBlank(evt.Subject)){
                if(evt.Subject.startsWithIgnoreCase('Call')){
                    evt.Type= 'Call'; 
                }
                else if(evt.Subject.startsWithIgnoreCase('Email')){
                    evt.Type= 'Email';  
                }
                else{
                    evt.Type= 'Meeting';  
                }
            }
        }
    }
    
}