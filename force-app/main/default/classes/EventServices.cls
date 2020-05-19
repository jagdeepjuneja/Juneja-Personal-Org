/**************************************************************************
    Author      :   Jagdeep Juneja        
    Purpose     :   Services class for TaskTrigger
    Company     :   Appirio 
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
**************************************************************************/
public class EventServices {
    
    public static boolean bPreventRecursion = false;
    public static boolean bPreventBI = false; // Provided for more granular capabilities
    public static boolean bPreventBU = false; // Provided for more granular capabilities
    public static boolean bPreventBD = false; // Provided for more granular capabilities
    public static boolean bPreventAI = false; // Provided for more granular capabilities
    public static boolean bPreventAU = false; // Provided for more granular capabilities
    public static boolean bPreventAD = false; // Provided for more granular capabilities
    public static MAP<string, sObject> sObjInsMAP = new MAP<string, sObject>(); 
    public static MAP<string, sObject> sObjUpdMAP = new MAP<string, sObject>(); 
    public static MAP<string, sObject> sObjDelMAP = new MAP<string, sObject>();
    public static MAP<integer, string> sObjInsErrMAP = new MAP<integer, string>(); 
    public static MAP<integer, string> sObjUpdErrMAP = new MAP<integer, string>(); 
    public static MAP<integer, string> sObjDelErrMAP = new MAP<integer, string>(); 
    
    /**************************************************************************
    Author      :   Jagdeep Juneja
    Company     :   Appirio
    Purpose     :   It update the Type of Event as per the value of Subject.
    Return      :   MAP<string, string>
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
    **************************************************************************/
    
    public static MAP<string, string> updateEventType(
        LIST<Event> triggerOldLIST,  
        LIST<Event>triggerNewLIST, 
        MAP<ID, Event> triggerOldMAP, 
        MAP<ID, Event>triggerNewMAP, 
        boolean bIsBefore, boolean bIsAfter, boolean bIsInsert, boolean bIsUpdate, boolean bIsDelete){
        MAP<string, string> errorMAP = new MAP<string, string>();
        System.debug('test in updateEventType method');
    
        for(Event evt: triggerNewLIST){
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
        
        return errorMAP;
    }
    
    /**************************************************************************
    Author      :   Jagdeep Juneja
    Company     :   Appirio
    Purpose     :   It roll up the count of Meeting,call and email on Account and Contact record.
    Return      :   MAP<string, string>
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
    **************************************************************************/
    
    public static MAP<string, string> updateActivityScoreOnAccountOrContact(
        LIST<Event> triggerOldLIST,  
        LIST<Event>triggerNewLIST, 
        MAP<ID, Event> triggerOldMAP, 
        MAP<ID, Event>triggerNewMAP, 
        boolean bIsBefore, boolean bIsAfter, boolean bIsInsert, boolean bIsUpdate, boolean bIsDelete){
        
        MAP<string, string> errorMAP = new MAP<string, string>();
        String eventId = '';
        Integer i=0;
        
        System.debug('test in updateActivityScoreOnAccountOrContact method');
        Set<Id> conIdSet = new Set<Id>();
        Set<Id> accIdSet = new Set<Id>();
        Integer callCount;
        Integer emailCount;
        Integer meetingCount;
        
        for(Event et: triggerNewLIST){
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
                con.Activity_score__c = 0;
                eventId = '';
                
                for(Event et: con.Events){
                    if(et.Type == 'Call'){
                        callCount++;
                        eventId = et.Id;
                    }
                    else if(et.Type == 'Email'){
                        emailCount++;
                        eventId = et.Id;
                    }
                    else if(et.Type == 'Meeting'){
                        meetingCount++;
                        eventId = et.Id;
                    }
                }
                con.Activity_score__c = meetingCount*3 + callCount*2 + emailCount;
                sObjUpdMAP.put(con.Id, con);
                sObjInsErrMAP.put(i, eventId);
                i++;
            }                            
        }
        
        if(!accIdSet.isEmpty()){
            List<Account> accList = [SELECT Activity_score__c, (SELECT Type FROM Events WHERE Type IN ('Call', 'Email', 'Meeting'))
                                        FROM Account WHERE ID IN: accIdSet];
            for(Account acc: accList){
                callCount = 0;
                emailCount = 0;
                meetingCount = 0;
                acc.Activity_score__c = 0;
                eventId = '';
                
                for(Event et: acc.Events){
                    if(et.Type == 'Call'){
                        callCount++;
                        eventId = et.Id;
                    }
                    else if(et.Type == 'Email'){
                        emailCount++;
                        eventId = et.Id;
                    }
                    else if(et.Type == 'Meeting'){
                        meetingCount++;
                        eventId = et.Id;
                    }
                }
                acc.Activity_score__c = meetingCount*3 + callCount*2 + emailCount;
                sObjUpdMAP.put(acc.Id, acc);
                sObjInsErrMAP.put(i, eventId);
                i++;
            }                            
        }
        
        return errorMAP;
        
    }  
  
} // END public class EventServices