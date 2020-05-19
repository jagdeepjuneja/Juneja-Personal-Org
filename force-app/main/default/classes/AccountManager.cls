@RestResource(urlMapping='/Accounts/*/Contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accId = request.requestURI.substringBetween('Accounts/', '/contacts');

        Account result =  [SELECT id,name, (select id,name from contacts) from account where id=: accId];
        return result;
    }
    
}