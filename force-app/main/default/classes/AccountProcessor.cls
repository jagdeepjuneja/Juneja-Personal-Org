public class AccountProcessor {
 //https://trailhead.salesforce.com/modules/asynchronous_apex/units/async_apex_future_methods
 	@Future
    public static void countContacts(List<Id> accIds){
        System.debug('test in countContacts future method');
        Map<Id, List<Contact>> mapOfAccIdAndConList = new Map<Id, List<Contact>>();
        List<Account>  accListToUpdate = new List<Account>();
        
        for(Contact con : [SELECT AccountID FROM Contact WHERE AccountID IN: accIds]){
          if(mapOfAccIdAndConList.containsKey(con.AccountId)){
          	mapOfAccIdAndConList.get(con.AccountId).add(con); 
           }
           else{
          	mapOfAccIdAndConList.put(con.AccountId, new List<Contact>{con});  
           }
        }
        
        for(Id id : mapOfAccIdAndConList.keySet()){
          accListToUpdate.add(new Account(Id = id , Number_of_Contacts__c = mapOfAccIdAndConList.get(Id).size()));
        }
        
        if(!accListToUpdate.isEmpty()){
          update accListToUpdate;
        }
    }   
}