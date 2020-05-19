public class test {
    
    private static final String OriginAddress = 'Origin_Address__c';
    private static final String OriginCity = 'Origin_City__c';
    private static final String OriginState = 'Origin_State__c';
    private static final String OriginCountry = 'Origin_Country__c';
    private static final Integer OriginZipcode = 0;
    private static final String DestinationAddress = 'Destination_Address__c';
    private static final String Destinationcity = 'Destination_City__c';
    private static final String DestinationCountry = 'Destination_Country__c';
    private static final String DestinationState = 'Destination_State__c';
    private static final Integer DestinationZipcode = 0;
    private static final Integer TravelTime = 0;
    private static final String ModeofTravel = 'Mode_of_Travel__c';
    
    private decimal getdistance (){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        
        String url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
            + '?origins=' + OriginAddress + OriginCity + OriginCountry + OriginState + OriginZipcode
            + '&destinations=' + DestinationAddress + Destinationcity + DestinationCountry + DestinationState + DestinationZipcode
            + '?&mode=' + ModeofTravel
            + '?arrival_time=' + TravelTime
            + '&sensor=false'
            + '&language=en'
            + '&units=imperial';
        
        req.setEndPoint(url);
        HttpResponse res = h.send(req);
        Decimal distance = Decimal.valueOf(res.getBody());
        return distance;
    }
}