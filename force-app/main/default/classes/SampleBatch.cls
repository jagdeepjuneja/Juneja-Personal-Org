global class SampleBatch implements Database.Batchable<sObject>{
    
	global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select id from Task');
    }
    global void execute(Database.BatchableContext bc, List<Task> scope){
        System.debug('scope size is '+scope.size());
        update scope;
    }    
    global void finish(Database.BatchableContext bc){
    }    
}