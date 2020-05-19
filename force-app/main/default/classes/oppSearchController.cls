public with sharing class oppSearchController{
    @AuraEnabled
    
    public static List<Opportunity> getOpportunities(String OppStage , Integer Oppamount) {
        System.debug('in apex');
        return [SELECT Id, Name, CloseDate,Amount,StageName FROM Opportunity LIMIT 5];
        
    }
}