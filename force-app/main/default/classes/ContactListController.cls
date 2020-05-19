public with sharing class ContactListController {

    @AuraEnabled
    public static List<Contact> findAll() {
        return [SELECT id, name, phone FROM Contact LIMIT 50];
    }

    @AuraEnabled
    public static List<Contact> findByName(String searchKey) {
        String name = '%' + searchKey + '%';
        return [SELECT id, name, phone FROM Contact WHERE name LIKE :name LIMIT 50];
    }

    @AuraEnabled
    public static Contact findById(String contactId) {
        return [SELECT id, name, title, phone, mobilephone, Account.Name
                    FROM Contact WHERE Id = :contactId];
    }
    
    @AuraEnabled
    public static List<Lead> getLeadContacts(String leadSource) {
      System.debug('jagdeep leadSource is '+leadSource);
        return [SELECT Name, Email FROM Lead WHERE leadSource = :leadSource];
    }
    
    @AuraEnabled
    public static List<String> getLeadSource(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Contact.leadSource.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }
        
        return options;
    }
    
    @AuraEnabled
    public static List<Contact> getLeadRecords(String leadSource){
        System.debug('jagdeep leadSource is '+leadSource);
        List<Contact> li = [SELECT Name, Email, Phone FROM Contact WHERE LeadSource =: leadSource];
        return li;
    }
            

}