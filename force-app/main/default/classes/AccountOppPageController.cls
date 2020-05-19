public class AccountOppPageController {
    
    public List<Account> listOfAccount {get;set;}
    public List<SelectOption> selectOptionList {get;set;}
    public String selectedAccount {get;set;}
    public Map<Id, List<Opportunity>> mapOfAccIdAndOppList {get;set;}
    public List<Opportunity> listOfOpportunities {get;set;}
    
    public AccountOppPageController(){
        listOfAccount = new List<Account>();
        listOfAccount = [select name,Phone from Account LIMIT 10]; 
        selectedAccount = '';
        listOfOpportunities = new List<Opportunity>();
        mapOfAccIdAndOppList = new Map<Id, List<Opportunity>>();
        selectOptionList = new List<SelectOption>();
        for(Account acc : listOfAccount) {
            selectOptionList.add(new SelectOption(acc.Id,acc.Name));
        }
        List<Account> tempContactList = [select id, name, (select Name, AccountId,Amount,CloseDate from Opportunities) from Account where ID IN:listOfAccount];
        for(Account acc : tempContactList) {
            mapOfAccIdAndOppList.put(acc.Id, acc.Opportunities);
        }
    }
    
    public void refreshOppList() {
      System.debug('selected account id is '+selectedAccount);
      listOfOpportunities = new List<Opportunity>();
      listOfOpportunities = mapOfAccIdAndOppList.get(selectedAccount);
      System.debug('listOfOpportunities is '+listOfOpportunities);
    }
    
}