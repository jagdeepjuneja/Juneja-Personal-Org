/**************************************************************************
    Author      :   Jagdeep Juneja
    Purpose     :   Dispatcher class for TaskTrigger
    Company     :   Appirio 
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
**************************************************************************/
public class EventDispatcher {
    

    public static MAP<string, string> errorMAP = new MAP<string, string>();

    
    /**************************************************************************
    Author      :   Jagdeep Juneja
    Company     :   Appirio
    Purpose     :   Trigger_Handler method called from the trigger.  
    Return      :   MAP<string, string>
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja       Appirio             Created
    **************************************************************************/

    public static MAP<string, string> Trigger_Handler(
        LIST<Event> triggerOldLIST, 
        MAP<ID, Event> triggerOldMAP, 
        LIST<Event> triggerNewLIST, 
        MAP<ID, Event> triggerNewMAP, 
        boolean bIsBefore, boolean bIsAfter, boolean bIsInsert, boolean bIsUpdate, boolean bIsDelete){
        

        EventServices.sObjInsMAP = new MAP<string, sObject>(); // Must initialize in case of recursive call
        EventServices.sObjUpdMAP = new MAP<string, sObject>(); // Must initialize in case of recursive call
        EventServices.sObjDelMAP = new MAP<string, sObject>(); // Must initialize in case of recursive call
        EventServices.sObjInsErrMAP = new MAP<integer, string>(); // Must initialize in case of recursive call
        EventServices.sObjUpdErrMAP = new MAP<integer, string>(); // Must initialize in case of recursive call
        EventServices.sObjDelErrMAP = new MAP<integer, string>(); // Must initialize in case of recursive call

        integer nIndex = 0;

        // ********** ACTION LOGIC **********
        Action(triggerOldLIST, triggerOldMAP, triggerNewLIST, triggerNewMAP, 
            bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete);
        
        // Update Prevent Recursion booleans
        if (bIsBefore && bIsInsert) {
            EventServices.bPreventBI = true;
        } else if (bIsBefore && bIsUpdate) {
            EventServices.bPreventBU = true;
        } else if (bIsBefore && bIsDelete) {
            EventServices.bPreventBD = true;
        } else if (bIsAfter && bIsInsert) {
            EventServices.bPreventAI = true;
        } else if (bIsAfter && bIsUpdate) {
            EventServices.bPreventAU = true;
        } else if (bIsAfter && bIsDelete) {
            EventServices.bPreventAD = true;            
        } // END if (bIsBefore)
        if (bIsAfter) EventServices.bPreventRecursion = true;        

        
        // If we have updates to handle, process them here and return errors
        if (EventServices.sObjUpdMAP.values().size() > 0) {
            nIndex = 0;
            
            LIST<database.SaveResult> srLIST = database.update(EventServices.sObjUpdMAP.values(), false);
            system.debug('Update SaveResult LIST: ' + srLIST);
            for (database.SaveResult srItem : srLIST) {
                if (!srItem.isSuccess()) {
                    errorMAP.put(EventServices.sObjUpdErrMAP.get(nIndex), srItem.getErrors()[0].getMessage());
                } // END if (!srItem.isSuccess())
                nIndex += 1;        
            } // END for (database.SaveResult srItem : srLIST)
        } // END if (AccountServices_SampleEDA.sObjUpdMAP.values().size() > 0)

        system.debug('Returning Error MAP to Trigger: ' + errorMAP);
        return errorMAP;
    } // END Trigger_Handler

    /**************************************************************************
    Author      :   Jagdeep Juneja
    Company     :   Appirio
    Purpose     :   Action method called from the Trigger_Handler method of the same class.  
    Return      :   MAP<string, string>
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
    **************************************************************************/
    private static void Action(
        LIST<Event> triggerOldLIST, 
        MAP<ID, Event> triggerOldMAP,
        LIST<Event> triggerNewLIST, 
        MAP<ID, Event> triggerNewMAP, 
        boolean bIsBefore, boolean bIsAfter, boolean bIsInsert, boolean bIsUpdate, boolean bIsDelete){
        

        // ACTION LOGIC
        // Handle Contact Update

        
        if(!EventServices.bPreventBI){

            if(bIsBefore && bIsInsert){
                
                errorMAP.putAll(EventServices.updateEventType(
                    triggerOldLIST, triggerNewLIST, 
                    triggerOldMAP, triggerNewMAP, 
                    bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete));
            }
        }

        if(!EventServices.bPreventBU){

            if(bIsBefore && bIsUpdate){

                 errorMAP.putAll(EventServices.updateEventType(
                    triggerOldLIST, triggerNewLIST, 
                    triggerOldMAP, triggerNewMAP, 
                    bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete));
            }
        }
        
        if(!EventServices.bPreventAI){

            if(bIsAfter && bIsInsert){

                errorMAP.putAll(EventServices.updateActivityScoreOnAccountOrContact(
                    triggerOldLIST, triggerNewLIST, 
                    triggerOldMAP, triggerNewMAP, 
                    bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete));


            }
        }

        if(!EventServices.bPreventAU){

            if(bIsAfter && bIsUpdate){

                errorMAP.putAll(EventServices.updateActivityScoreOnAccountOrContact(
                    triggerOldLIST, triggerNewLIST, 
                    triggerOldMAP, triggerNewMAP, 
                    bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete));     
            }
        }


    } // END Action
} // END TaskDispatcher_SampleEDA