global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leadList = [SELECT LeadSource  FROM Lead where LeadSource =null];
        
        for(Lead ld : leadList){
          ld.LeadSource = 'Dreamforce';
        }
        
        update leadList;
    }
    
}