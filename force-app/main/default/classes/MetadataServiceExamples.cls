public class MetadataServiceExamples {
    
    public static String SOAP_M_URI = 'http://soap.sforce.com/2006/04/metadata';
    public String endpoint_x = URL.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/m/42.0';
    
    public static void cloneAllCmp(String prefix, String fromComponentPrefix){
        List<Component_List__mdt> allComponents = [Select Type__c,MasterLabel from Component_List__mdt limit 10];
        System.debug('allComponents '+allComponents);
        
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        MetadataService.Metadata[] listAuraBundle = new MetadataService.Metadata[]{};
        MetadataService.AuraDefinitionBundle auraBundle = new MetadataService.AuraDefinitionBundle();
        
        Map<String,Component_List__mdt> cmpNameList = new Map<String,Component_List__mdt>();
        Map<Id,AuraDefinitionBundle> auraIdsToAuraDefBundle = new Map<Id,AuraDefinitionBundle>();
        if(allComponents != null){
            for(Component_List__mdt cl : allComponents){
                
                if(fromComponentPrefix != '' && fromComponentPrefix != null){
                    cmpNameList.put(fromComponentPrefix+'_'+cl.MasterLabel,cl);
                }else{
                    cmpNameList.put(cl.MasterLabel,cl);
                }   
            }
            List<AuraDefinitionBundle> listAuraDefinitionBundle = [Select Id, DeveloperName, ApiVersion From AuraDefinitionBundle Where DeveloperName =: cmpNameList.keySet()];
            if(listAuraDefinitionBundle != null && listAuraDefinitionBundle.size() > 0){    
                for(AuraDefinitionBundle ab : listAuraDefinitionBundle){
                    auraIdsToAuraDefBundle.put(ab.Id,ab);
                }
            }
            if(auraIdsToAuraDefBundle != null){
                System.debug('auraIdsToAuraDefBundle '+auraIdsToAuraDefBundle);
                System.debug('cmpNameList '+cmpNameList);
                
                List<AuraDefinition> listAuraDefinition = [SELECT AuraDefinitionBundleId,DefType,Source FROM AuraDefinition WHERE AuraDefinitionBundleId =: auraIdsToAuraDefBundle.keySet()];
                if(listAuraDefinition != null && listAuraDefinition.size() > 0){
                    for(AuraDefinition auradef : listAuraDefinition){
                        System.debug('auraIdsToAuraDefBundle.get(auradef.AuraDefinitionBundleId) '+auraIdsToAuraDefBundle.get(auradef.AuraDefinitionBundleId));
                        System.debug('cmpNameList.get(auraIdsToAuraDefBundle.get(auradef.AuraDefinitionBundleId).DeveloperName) '+cmpNameList.get(auraIdsToAuraDefBundle.get(auradef.AuraDefinitionBundleId).DeveloperName));
                        auraBundle.apiVersion = auraIdsToAuraDefBundle.get(auradef.AuraDefinitionBundleId).ApiVersion;
                        auraBundle.fullName = prefix+'_'+cmpNameList.get(auraIdsToAuraDefBundle.get(auradef.AuraDefinitionBundleId).DeveloperName).MasterLabel;
                        auraBundle.type_x = cmpNameList.get(auraIdsToAuraDefBundle.get(auradef.AuraDefinitionBundleId).DeveloperName).Type__c;
                        if(auraDef.DefType =='COMPONENT'){
                                auraBundle.markup = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                                
                        }else if(auraDef.DefType =='CONTROLLER'){
                            auraBundle.controllerContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='HELPER'){
                            auraBundle.helperContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='STYLE'){
                            auraBundle.styleContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='DESIGN'){
                            auraBundle.designContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='RENDERER'){
                            auraBundle.rendererContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='DOCUMENTATION'){
                            auraBundle.documentationContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='SVG'){
                            auraBundle.SVGContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                        }
                        
                        listAuraBundle.add(auraBundle);
                    }
                    
                    system.debug(listAuraBundle);
                    if(listAuraBundle != null){
                        List<MetadataService.UpsertResult> results = service.upsertMetadata(listAuraBundle);
                        system.debug(results);
                    }
                }
            }
        }
        
    }
    
    public static void cloneLightningComponent(String prefix, String fromComponent, List<String> componentNameList){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        MetadataService.Metadata[] listAuraBundle = new MetadataService.Metadata[]{};
        
        if(componentNameList != null){
            List<AuraDefinitionBundle> listAuraDefinitionBundle = [Select Id, DeveloperName, ApiVersion From AuraDefinitionBundle Where DeveloperName =: componentNameList];
        }
    }
    
    public static void cloneAllBaseLightningComponent(String prefix, String fromComponentPrefix){
        //Map<Id,String> apexClassIdWithName = new Map<Id,String>(); 
        
        List<Component_List__mdt> allComponents = [Select Type__c,MasterLabel from Component_List__mdt limit 10];
        System.debug('allComponents '+allComponents);
        // List<ApexClass> apexClasses = [SELECT Name FROM ApexClass];
        // for(ApexClass ac : apexClasses){
        //     String apexId15Digit = String.valueOf(ac.Id).substring(0, 15);
        //     apexClassIdWithName.put(apexId15Digit,ac.Name);
        // }
        
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        MetadataService.Metadata[] listAuraBundle = new MetadataService.Metadata[]{};
        
    
        if(allComponents != null){
            for(Component_List__mdt cl : allComponents){
                
                String cmpName = '';
                if(fromComponentPrefix != '' && fromComponentPrefix != null){
                    cmpName = fromComponentPrefix+'_'+cl.MasterLabel;
                }else{
                    cmpName = cl.MasterLabel;
                }
                System.debug(cl.MasterLabel);
                List<AuraDefinitionBundle> listAuraDefinitionBundle = [Select Id, DeveloperName, ApiVersion From AuraDefinitionBundle Where DeveloperName =: cmpName];
                List<AuraDefinition> listAuraDefinition = [SELECT AuraDefinitionBundleId,DefType,Source FROM AuraDefinition WHERE AuraDefinitionBundleId =: listAuraDefinitionBundle[0].Id];
                if(listAuraDefinition.size() != 0){
                    MetadataService.AuraDefinitionBundle auraBundle = new MetadataService.AuraDefinitionBundle();
                    auraBundle.apiVersion = listAuraDefinitionBundle[0].ApiVersion;
                    auraBundle.fullName = prefix+'_'+cl.MasterLabel;
                    auraBundle.type_x = cl.Type__c;
                    
                    for(AuraDefinition auraDef : listAuraDefinition){
                        
                        if(auraDef.DefType =='COMPONENT'){
                            auraBundle.markup = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='CONTROLLER'){
                            auraBundle.controllerContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='HELPER'){
                            auraBundle.helperContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='STYLE'){
                            auraBundle.styleContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='DESIGN'){
                            auraBundle.designContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='RENDERER'){
                            auraBundle.rendererContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='DOCUMENTATION'){
                            auraBundle.documentationContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                            
                        }else if(auraDef.DefType =='SVG'){
                            auraBundle.SVGContent = EncodingUtil.base64Encode(Blob.valueof(auraDef.Source));
                        }
                    }
                    
                    listAuraBundle.add(auraBundle);
                }
                
            }
            system.debug(listAuraBundle);
            if(listAuraBundle != null){
                List<MetadataService.UpsertResult> results = service.upsertMetadata(listAuraBundle);
                system.debug(results);
            }
            
        }
    }
    
    public static void cloneLightningComponent(String prefix, String fromComponentPrefix, String componentName){
        
    }
    
    public static void readAndCreateLightningComponent(){
        MetadataService.MetadataPort service = createService();
        MetadataService.AuraDefinitionBundle auraBundle =
            (MetadataService.AuraDefinitionBundle) service.readMetadata('AuraDefinitionBundle',
                new String[] { 'PricingTaskConfiguration' }).getRecords()[0];
                
            String markup = EncodingUtil.base64Decode(auraBundle.markup).toString();
            String apexId15Digit = markup.substringBetween('{!ID:@@@sfdc=','=sfdc@@@}');
            //String apexId15Digit = String.valueOf(apexClassId18Digit).substring(0, 15);
            
            List<ApexClass> apexClasses = [SELECT Name FROM ApexClass WHERE Id =:apexId15Digit];
            
            markup = markup.replace('{!ID:@@@sfdc='+apexId15Digit+'=sfdc@@@}', apexClasses[0].Name);
            auraBundle.markup = EncodingUtil.base64Encode(Blob.valueof(markup));
            
          System.debug(EncodingUtil.base64Decode(auraBundle.markup).toString());
            auraBundle.fullName = 'B2B_TestCloneExample1';
            List<MetadataService.SaveResult> results =
                        service.createMetadata(
                            new MetadataService.Metadata[] { auraBundle });
        
        
    }


    
    
  public static void readLightningComponent(){
        MetadataService.MetadataPort service = createService();
        MetadataService.AuraDefinitionBundle auraBundle =
            (MetadataService.AuraDefinitionBundle) service.readMetadata('AuraDefinitionBundle',
                new String[] { 'B2B_TestCloneComponentSuccess' }).getRecords()[0];
        System.debug(EncodingUtil.base64Decode(auraBundle.markup).toString());
        
        
    }

//     public static void createLightningComponent(){
//         MetadataService.MetadataPort service = createService();
//         MetadataService.AuraDefinitionBundle auraBundle = new MetadataService.AuraDefinitionBundle();
//         auraBundle.fullName = 'TestCloneComponent1';
//         auraBundle.type_x = 'Component';
//         auraBundle.markup = EncodingUtil.base64Encode(Blob.valueOf(
//             '<aura:component>' +
//                 '<aura:attribute name="val1" type="String" default="Value"/>' +
//                 '<aura:attribute name="val2" type="String" />' +
//                 '<aura:handler name="init" value="{!this}" action="{!c.myAction}"/>' +
//                 '<ui:outputText value="Hello world!"/>' +
//                 '<ui:outputText value="{!v.val1}"/>' +
//                 '<ui:outputText value="{!v.val2}"/>' +
//             '</aura:component>'));
//         auraBundle.controllerContent = EncodingUtil.base64Encode(Blob.valueOf(
//             '({' +
//                 'myAction : function(component) {' +
//                     'component.set(\'v.val1\',\'Value1\');' +
//                     'component.set(\'v.val2\',\'Value2\');' +
//                 '}' +
//             '})'));
//         List<MetadataService.SaveResult> results =
//             service.createMetadata(
//                 new MetadataService.Metadata[] { auraBundle });
//         handleSaveResults(results[0]);
//     }
    
//     public class createMetadataResponse_element {
//         public MetadataService.SaveResult[] result;
//         private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'0','-1','false'};
//         private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
//         private String[] field_order_type_info = new String[]{'result'};
//     }
    
//     public class updateMetadataResponse_element {
//         public MetadataService.SaveResult[] result;
//         private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'0','-1','false'};
//         private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
//         private String[] field_order_type_info = new String[]{'result'};
//     }
    
//     // public MetadataService.SaveResult[] updateMetadata(MetadataService.Metadata[] metadata) {
//     //         MetadataService.updateMetadata_element request_x = new MetadataService.updateMetadata_element();
//     //         request_x.metadata = metadata;
//     //         MetadataService.updateMetadataResponse_element response_x;
//     //         Map<String, MetadataService.updateMetadataResponse_element> response_map_x = new Map<String, MetadataService.updateMetadataResponse_element>();
//     //         response_map_x.put('response_x', response_x);
//     //         WebServiceCallout.invoke(
//     //           this,
//     //           request_x,
//     //           response_map_x,
//     //           new String[]{endpoint_x,
//     //           '',
//     //           SOAP_M_URI,
//     //           'updateMetadata',
//     //           SOAP_M_URI,
//     //           'updateMetadataResponse',
//     //           'MetadataService.updateMetadataResponse_element'}
//     //         );
//     //         response_x = response_map_x.get('response_x');
//     //         return response_x.result;
//     //     }
        
    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
//     public static void handleSaveResults(MetadataService.SaveResult saveResult)
//     {
//         // Nothing to see?
//         if(saveResult==null || saveResult.success)
//             return;
//         // Construct error message and throw an exception
//         if(saveResult.errors!=null)
//         {
//             List<String> messages = new List<String>();
//             messages.add(
//                 (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
//                     'occured processing component ' + saveResult.fullName + '.');
//             for(MetadataService.Error error : saveResult.errors)
//                 messages.add(
//                     error.message + ' (' + error.statusCode + ').' +
//                     ( error.fields!=null && error.fields.size()>0 ?
//                         ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
//             if(messages.size()>0)
//                 throw new MetadataServiceExamplesException(String.join(messages, ' '));
//         }
//         if(!saveResult.success)
//             throw new MetadataServiceExamplesException('Request failed with no specified error.');
//     }
    
//     public class MetadataServiceExamplesException extends Exception { }
}