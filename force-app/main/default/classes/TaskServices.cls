/**************************************************************************
    Author      :   Jagdeep Juneja        
    Purpose     :   Services class for TaskTrigger
    Company     :   Appirio 
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
**************************************************************************/
public class TaskServices {
    
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
    Purpose     :   It update the Type of Task as per the value of Subject.
    Return      :   MAP<string, string>
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
    **************************************************************************/
    
    public static MAP<string, string> updateTaskType(
        LIST<Task> triggerOldLIST,  
        LIST<Task>triggerNewLIST, 
        MAP<ID, Task> triggerOldMAP, 
        MAP<ID, Task>triggerNewMAP, 
        boolean bIsBefore, boolean bIsAfter, boolean bIsInsert, boolean bIsUpdate, boolean bIsDelete){
            
        MAP<string, string> errorMAP = new MAP<string, string>();    
        System.debug('test in updateTaskType method');
    
        for(Task t: triggerNewLIST){
            
            if(t.Subject != NULL && !String.isBlank(t.Subject)){
                if(t.Subject.startsWithIgnoreCase('Call')){
                    t.Type= 'Call'; 
                }
                else if(t.Subject.startsWithIgnoreCase('Email')){
                    t.Type= 'Email';  
                }
                else{
                    t.Type= 'Task';  
                }
            }
        }
        return errorMAP; 
    }
    
} // END public class RewardPaymentServices