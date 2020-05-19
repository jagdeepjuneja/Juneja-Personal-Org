public class BoatTypeSearch {
  
    @AuraEnabled
    public static List<BoatType__c> getBoatTypes(){
        return [SELECT Name FROM BoatType__c];
    } 
    
}