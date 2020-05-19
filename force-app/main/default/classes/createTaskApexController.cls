public class createTaskApexController {
	@AuraEnabled
    public static Task createNewTask(String subject, String priority, String type, String description){
        System.debug('in apex method');
    	Task t = new Task(Subject= subject, Priority=priority, Type=type, Description= description);
        insert t;
        return t;
    }
}