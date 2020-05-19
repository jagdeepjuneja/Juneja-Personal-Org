global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT LeadSource FROM Lead ');
    }
    global void execute(Database.BatchableContext bc, List<Lead> leadList){
        // process each batch of records
        
        for(Lead ld: leadList){
          ld.LeadSource = 'Dreamforce';
        }
        update leadList;
    }
    
    global void finish(Database.BatchableContext bc){
        
    }    
}