// This class should contains the utility methods that will be used by test class to create sample records.
public class Utility {
    /*
    Created By: Jagdeep Juneja
    Created On: 12/02/2017
    Purpose: Utility Class for various common/generic methods
    */
    
    public static boolean canTrigger(string strTriggerName) {
        /*
        Created By: Robert Nunemaker 
        Created On: 11/21/2014
        Purpose: Provides a mechanism for checking the CS_Key_IDs__c for the provided entry, and then looking for "Disable", Profile ID(s), or User ID(s).
        --------------------------------------------------------------------------
        Modified By:    
        Modified On:  
        Modification: 
         */

        CS_Key_IDs__c csItem = CS_Key_IDs__c.getInstance(strTriggerName);
        if (csItem == null || csItem.Flag__c == null) {
            return true;
        } else if (csItem.Flag__c.equalsIgnoreCase('Disable')) {
            return false;
        }
        
        return true;
    } // END canTrigger
    

    public static List<Task> createTask(Integer count, String subject, Boolean isInsert) {
        /*
        Created By: Jagdeep Juneja
        Created On: 12/02/2017
        Purpose: This method is used to create task records.
         */
        List<Task> taskList = new List<Task>();
        for(Integer i=0; i< count; i++){
            taskList.add(new Task(Subject = subject));
        }
        
        if(isInsert){
            if(taskList.size() > 0){
                insert taskList;
            }
        }
        return taskList;
    }
    
    public static List<Event> createEvent(Integer count, String subject, Boolean isInsert) {
        /*
        Created By: Jagdeep Juneja
        Created On: 12/02/2017
        Purpose: This method is used to create Event records.
         */
        List<Event> eventList = new List<Event>();
        for(Integer i=0; i< count; i++){
            eventList.add(new Event(DurationInMinutes = 60, ActivityDateTime=System.now(), Subject = subject));
        }
        
        if(isInsert){
            if(eventList.size() > 0){
                insert eventList;
            }
        }
        return eventList;
    }
    
    
    public static List<Account> createAccount(Integer count, Boolean isInsert){
        /*
        Created By: Jagdeep Juneja
        Created On: 12/02/2017
        Purpose: This method is used to create Account records.
         */
        List<Account> accList = new List<Account>();
        for(Integer i=0; i< count; i++){
            accList.add(new Account(Name = 'test '+ i));
        }
        
        if(isInsert){
            if(accList.size() > 0){
                insert accList;
            }
        }
        return accList;
    }
    
    public static List<Contact> createContact(Integer count, Boolean isInsert){
        /*
        Created By: Jagdeep Juneja
        Created On: 12/02/2017
        Purpose: This method is used to create Contact records.
         */
        List<Contact> conList = new List<Contact>();
        for(Integer i=0; i< count; i++){
            conList.add(new Contact(LastName = 'test '+ i));
        }
        
        if(isInsert){
            if(conList.size() > 0){
                insert conList;
            }
        }
        return conList;
    }
    


} // END Utility