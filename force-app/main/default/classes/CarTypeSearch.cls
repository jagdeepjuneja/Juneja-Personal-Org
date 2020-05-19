public class CarTypeSearch {

    @auraEnabled
    public static list<Car_type__c> getCarTypes(){
        return [select Name from Car_type__c];
    }
}