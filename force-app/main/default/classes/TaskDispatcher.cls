/**************************************************************************
    Author      :   Jagdeep Juneja
    Purpose     :   Dispatcher class for TaskTrigger
    Company     :   Appirio 
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
**************************************************************************/
public class TaskDispatcher {
    

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
        LIST<Task> triggerOldLIST, 
        MAP<ID, Task> triggerOldMAP, 
        LIST<Task> triggerNewLIST, 
        MAP<ID, Task> triggerNewMAP, 
        boolean bIsBefore, boolean bIsAfter, boolean bIsInsert, boolean bIsUpdate, boolean bIsDelete){
        

        TaskServices.sObjInsMAP = new MAP<string, sObject>(); // Must initialize in case of recursive call
        TaskServices.sObjUpdMAP = new MAP<string, sObject>(); // Must initialize in case of recursive call
        TaskServices.sObjDelMAP = new MAP<string, sObject>(); // Must initialize in case of recursive call
        TaskServices.sObjInsErrMAP = new MAP<integer, string>(); // Must initialize in case of recursive call
        TaskServices.sObjUpdErrMAP = new MAP<integer, string>(); // Must initialize in case of recursive call
        TaskServices.sObjDelErrMAP = new MAP<integer, string>(); // Must initialize in case of recursive call

        integer nIndex = 0;

        // ********** ACTION LOGIC **********
        Action(triggerOldLIST, triggerOldMAP, triggerNewLIST, triggerNewMAP, 
            bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete);
        
        // Update Prevent Recursion booleans
        if (bIsBefore && bIsInsert) {
            TaskServices.bPreventBI = true;
        } else if (bIsBefore && bIsUpdate) {
            TaskServices.bPreventBU = true;
        } else if (bIsBefore && bIsDelete) {
            TaskServices.bPreventBD = true;
        } else if (bIsAfter && bIsInsert) {
            TaskServices.bPreventAI = true;
        } else if (bIsAfter && bIsUpdate) {
            TaskServices.bPreventAU = true;
        } else if (bIsAfter && bIsDelete) {
            TaskServices.bPreventAD = true;            
        } // END if (bIsBefore)
        if (bIsAfter) TaskServices.bPreventRecursion = true;        

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
        LIST<Task> triggerOldLIST, 
        MAP<ID, Task> triggerOldMAP,
        LIST<Task> triggerNewLIST, 
        MAP<ID, Task> triggerNewMAP, 
        boolean bIsBefore, boolean bIsAfter, boolean bIsInsert, boolean bIsUpdate, boolean bIsDelete){
        

        // ACTION LOGIC
        // Handle Contact Update

        
        if(!TaskServices.bPreventBI){

            if(bIsBefore && bIsInsert){
                
                errorMAP.putAll(TaskServices.updateTaskType(
                    triggerOldLIST, triggerNewLIST, 
                    triggerOldMAP, triggerNewMAP, 
                    bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete));
            }
        }

        if(!TaskServices.bPreventBU){

            if(bIsBefore && bIsUpdate){

                 errorMAP.putAll(TaskServices.updateTaskType(
                    triggerOldLIST, triggerNewLIST, 
                    triggerOldMAP, triggerNewMAP, 
                    bIsBefore, bIsAfter, bIsInsert, bIsUpdate, bIsDelete));
            }
        }


    } // END Action
} // END TaskDispatcher_SampleEDA