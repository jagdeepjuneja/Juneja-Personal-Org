//https://trailhead.salesforce.com/content/learn/modules/platform-developer1-maintenance-spring19/work-with-new-apex-security-settings
@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {
    @HttpGet
    global static Contact doGet(){
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
        
        try{
            List<Contact> results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId WITH SECURITY_ENFORCED];
            if (!results.isEmpty()) {
                result = results[0];
            }
        }
        catch(System.QueryException e){
            
        }
        return result;
    }
    public class FunctionalException extends Exception{}
    public class SecurityException extends Exception{}
}