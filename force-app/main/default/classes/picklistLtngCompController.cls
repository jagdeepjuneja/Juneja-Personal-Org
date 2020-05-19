/*
    Created By  : Appirio - Jagdeep Juneja
    Created On  : 5/1/2017
    Purpose     : Controller class for dropDownPage.
    --------------------------------------------------------------------------
*/
public class picklistLtngCompController {
    
    public static List<SelectOption> objectList {get;set;}
    public static String selectedObjectApiName {get;set;}
    public static List<FieldTableWrapper> fieldTableWrapperList {get; set;}
    public static String query;
    public static List<sObject> recordList {get;set;}
    public static List<String> selectedFields {get;set;}
    public static Boolean atleastOneFieldSelected;
    public static Map<String, String> mapOfObjApiNameAndLabel;
    public static List<String> objectApiNameList;
    public static List<String> fieldList;
    
    @auraEnabled
    public static List<String> getObjectMap(){
        objectList = new List<SelectOption>();
        objectList.add(new SelectOption('None', 'None')); 
        
        mapOfObjApiNameAndLabel = new Map<String, String>();
        objectApiNameList = new List<String>();
        objectApiNameList.add('None');
        
        for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
        
            Schema.SObjectType objInfo = Schema.getGlobalDescribe().get(String.valueOf(obj.getDescribe().getName()));
            Schema.DescribeSobjectResult objResult = objInfo.getDescribe();
            
            if(obj.getDescribe().getKeyPrefix() !=null){
                objectList.add(new SelectOption(String.valueOf(obj.getDescribe().getName()),String.valueOf(obj.getDescribe().getLabel())));    
                mapOfObjApiNameAndLabel.put(String.valueOf(obj.getDescribe().getName()),String.valueOf(obj.getDescribe().getLabel()));
                objectApiNameList.add(String.valueOf(obj.getDescribe().getName()));
            }    
        }
        return objectApiNameList;
    }
    
    @auraEnabled
    public static List<String> showFieldTable(String selectedObjectApiName){
        fieldList = new List<String>();
        fieldTableWrapperList = new List<FieldTableWrapper>();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType accountSegSchema = Schema.getGlobalDescribe().get(selectedObjectApiName.toLowerCase());
         Map<String, Schema.SObjectField> fieldMap = accountSegSchema.getDescribe().fields.getMap();
        for (String fieldName: fieldMap.keySet()) {
    		Schema.DisplayType fieldDataType = fieldMap.get(fieldName).getDescribe().getType();
    		fieldTableWrapperList.add(new FieldTableWrapper(fieldName, String.valueOf(fieldDataType)));
    		fieldList.add(fieldName);
        }
        return fieldList;
    }
    
    
    public PageReference showFieldTable(){
        if(selectedObjectApiName == 'None'){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select object first');
            ApexPages.addMessage(myMsg);
            return null;
        }
        
        fieldTableWrapperList = new List<FieldTableWrapper>();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType accountSegSchema = Schema.getGlobalDescribe().get(selectedObjectApiName.toLowerCase());
         Map<String, Schema.SObjectField> fieldMap = accountSegSchema.getDescribe().fields.getMap();
        for (String fieldName: fieldMap.keySet()) {
    		Schema.DisplayType fieldDataType = fieldMap.get(fieldName).getDescribe().getType();
    		fieldTableWrapperList.add(new FieldTableWrapper(fieldName, String.valueOf(fieldDataType)));  
        }
        return null;
    }
    
    public PageReference queryRecords(){
        recordList = new List<sObject>();
        selectedFields = new List<String>();
        query = 'SELECT ';
        atleastOneFieldSelected = false;
        
        if(selectedObjectApiName == 'None'){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select object first');
            ApexPages.addMessage(myMsg);
            return null;
        }
        
        for(FieldTableWrapper wrapobj : fieldTableWrapperList) {
            if(wrapobj.selected == true) {
                query += wrapobj.fieldName+', ';
                selectedFields.add(wrapobj.fieldName);
                atleastOneFieldSelected = true;
            }
        }
        query = query.substring(0, query.length()-2);
        query += ' FROM '+ selectedObjectApiName;
        System.debug('test query is' +query);
        System.debug('test selectedFields is' +selectedFields);
        
        if(atleastOneFieldSelected){
            recordList = Database.query(query);    
        }
        else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select at least one field');
            ApexPages.addMessage(myMsg);
            return null;
        }
        System.debug('test tempRecordList is '+recordList);
        return null;
    }
    
    public class FieldTableWrapper {
        public String fieldName {get;set;}
        public String fieldDataType {get;set;}
        public Boolean selected {get;set;}

        public FieldTableWrapper(String fieldName, String fieldDataType){
            this.fieldName = fieldName;
            this.fieldDataType = fieldDataType;
            selected = false;
        }
    }
  
}