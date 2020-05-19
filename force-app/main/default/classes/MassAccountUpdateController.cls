public class MassAccountUpdateController {
    
    @AuraEnabled
    public static wrapperClass getAccountList() {
        wrapperClass returnwrapperClass = new  wrapperClass ();
        returnwrapperClass.accList = [Select Name, AnnualRevenue, Active__c, Website, Type, Industry, AccountSource from Account];
        returnwrapperClass.accTypes = getAccountTypes();
        returnwrapperClass.accIndustries = getAccountIndustries();
        returnwrapperClass.accSources = getAccountSource();
        returnwrapperClass.inactiveAccounts = getInactiveAccount();
        return returnwrapperClass;
    }
    
    @AuraEnabled
    public static List<Account> filterAccountList(String type, String industry, String source) {
        System.debug(type + ' *** '+industry + ' *** '+source);
        String query = 'Select Name, AnnualRevenue, Active__c, Website, Type, Industry, AccountSource from Account where Type =:type';
        if(industry <> NULL && !String.isEmpty(industry)){
            query += ' AND Industry =:Industry';
        }
        else if(source <> NULL && !String.isEmpty(source)){
            query += ' AND AccountSource =:source';
        }
        System.debug('test query is '+query);
        List<Account> accList = Database.query(query);
        System.debug('test accList is '+accList);
        return Database.query(query);
    }
    
    @AuraEnabled
    public static List<String> updateRecords(List<String> lstRecordId) {
        List<String> oErrorMsg = new List<String>();
        List<Error_Handling__c> errorListToInsert = new List<Error_Handling__c>();
        List<Account> accListToUpdate = new List<Account>();
        
        for(String accId : lstRecordId){
            accListToUpdate.add(new Account(Id = accId, Active__c = 'Yes'));
        }
        Database.SaveResult[] DR_Dels = Database.update(accListToUpdate, false);
        for (Database.SaveResult dr: DR_Dels) {
            if (dr.isSuccess()) {
                system.debug('successful delete contact');
                // Operation was successful
            } else {
                // Operation failed, so get all errors   
                oErrorMsg.add('');
                for (Database.Error err: dr.getErrors()) {
                    // add Error message to oErrorMsg list and return the list
                    oErrorMsg.add(err.getStatusCode() + ': ' + err.getMessage());
                    errorListToInsert.add(new Error_Handling__c(Status__c = String.valueOf(err.getStatusCode()), Error_Messagge__c = err.getMessage()));
                }
            }
        }
        if(!errorListToInsert.isEmpty()){
            update errorListToInsert;
        }
        return oErrorMsg;
    }
    
    public static List<String> getAccountTypes(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
    
    public static List<String> getAccountIndustries(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
    
    public static List<String> getAccountSource(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Account.AccountSource.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
    
    public static Map<String, String> getInactiveAccount(){
        Map<String, String> AccIdAndNameMap = new Map<String, String>();
        for(Activate_Account_Alert__mdt mdt : [SELECt Account_id__c, MasterLabel FROM Activate_Account_Alert__mdt]){
            AccIdAndNameMap.put(mdt.Account_id__c, mdt.MasterLabel);
        }
        return AccIdAndNameMap;
    }
    
    public class wrapperClass{
        @AuraEnabled public List<Account> accList{get;set;}
        @AuraEnabled public List<String> accTypes{get;set;}
        @AuraEnabled public List<String> accIndustries{get;set;}
        @AuraEnabled public List<String> accSources{get;set;}
        @AuraEnabled public Map<String, String> inactiveAccounts{get;set;}
    }
    
    
}