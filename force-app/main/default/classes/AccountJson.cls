public with sharing class AccountJson {

    @AuraEnabled
    public static List<Account> getAccountList() {
        List<Account> accList = new List<Account>();
        accList = [SELECT Id, Name, NumberOfEmployees, Phone,ParentId FROM Account Order By Name LIMIT 20];
        return accList;
    }
}