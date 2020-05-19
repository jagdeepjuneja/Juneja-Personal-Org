public class AccountListApexController {
    @AuraEnabled
    public static List<Account> getAccounts(){
        List<Account> accList = [SELECT name FROM Account LIMIT 100];
        return accList;
    }
}