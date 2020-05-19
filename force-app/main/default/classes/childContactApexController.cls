public class childContactApexController {

    @AuraEnabled
    public static List<Contact> getChildContacts(String accId, Integer os){
      System.debug('accId is '+accId);  
      System.debug('os is '+os);    
      os = 5*Integer.valueOf(os);  
      List<Contact> conList =[SELECT Name FROM Contact WHERE AccountId =:accId LIMIT: 5  OFFSET:os ]; 
      return conList;  
    }
}