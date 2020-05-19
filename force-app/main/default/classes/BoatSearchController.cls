public Class BoatSearchController{
    
    @AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId){
        if(boatTypeId.equalsIgnoreCase('')){
            return [select id,name, picture__c, Contact__r.Name, geolocation__latitude__s, geolocation__longitude__s,
                   Year_Built__c,  Price__c, Length__c
                    FROM Boat__c];
        }
        else{
            return [select id,name, picture__c, Contact__r.Name, geolocation__latitude__s, geolocation__longitude__s,
                   Year_Built__c,  Price__c, Length__c
                    FROM Boat__c WHERE BoatType__c =: boatTypeId];
        }
    }
}