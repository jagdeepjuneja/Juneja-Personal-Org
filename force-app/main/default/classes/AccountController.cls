public class AccountController {

    @AuraEnabled
    public static List<Account> getAccRecord() {
        return [SELECT Id, Name, Phone FROM Account LIMIT 5];
    }

    @AuraEnabled
    public static List <Account> fetchAccounts() {
        //Qyery 10 accounts
        List<Account> accList = [SELECT Id, Name, BillingState, 
                                    Website, Phone, Industry, Type from Account LIMIT 10];
        //return list of accounts
        return accList;
    }
}