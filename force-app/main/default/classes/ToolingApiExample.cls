global class ToolingApiExample {
    
    webservice static String createBundle(String sbundleName)
    {
        JSONGenerator body = JSON.createGenerator(false);
        body.writeStartObject();
        body.writeStringField('DeveloperName', sBundleName);
        body.writeStringField('Description', 'Code Generated Bundle');
        body.writeStringField('ApiVersion', '41');
        body.writeStringField('MasterLabel', sbundleName);
        body.writeEndObject();
        
        
        // Http ht = new Http();
        // HttpRequest request = new HttpRequest();
        // request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/tooling/sobjects/AuraDefinitionBundle');
        // request.setMethod('GET');
        // HttpResponse response = ht.send(request);
        // System.debug(response);
        
        
        Http h = new Http();
        HttpRequest createReq = new HttpRequest();
        createReq.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/tooling/sobjects/AuraDefinitionBundle');
        createReq.setBody( body.getAsString() );
        System.debug('JSON BODY : ' +  body.getAsString());
        createReq.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        createReq.setHeader('Content-Type', 'application/json');
        createReq.setMethod('POST');
        createReq.setTimeout(30000);
        HttpResponse createRes = h.send(createReq);
        System.debug(createRes.getXmlStreamReader().toString());
        String returnId = createRes.getXmlStreamReader().toString().substringAfter('id":"').substringBefore('",');
        return returnId;
    }
    
    
    webservice static void createComponent(String sBundleId){
        JSONGenerator body = JSON.createGenerator(false);
        body.writeStartObject();
        body.writeStringField('AuraDefinitionBundleId', sBundleId);
        body.writeStringField('DefType', 'COMPONENT');
        body.writeStringField('Source','<aura:component implements="flexipage:availableForAllPageTypes,force:hasRecordId,force:lightningQuickAction" controller="CampaignUIController">MY COMPONENT</aura:component>');
        body.writeEndObject();
        HttpRequest createReq = new HttpRequest();
        createReq.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/tooling/sobjects/AuraDefinition');
        createReq.setBody( body.getAsString() );
        System.debug('JSON BODY : ' +  body.getAsString());
        createReq.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        createReq.setHeader('Content-Type', 'application/json');
        createReq.setMethod('POST');
        createReq.setTimeout(30000);
        Http h = new Http();   
        HttpResponse createRes = h.send(createReq);
    }
}