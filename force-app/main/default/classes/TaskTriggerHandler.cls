public class TaskTriggerHandler {
    
    public static void onBeforeInsertUpdate(List<Task> newLIst){
        updateTaskType(newLIst);
    }
  
    public static void updateTaskType(List<Task> newList){
        System.debug('test in updateTaskType method');
    
        for(Task t: newList){
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
    }
}