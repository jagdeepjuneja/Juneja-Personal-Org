public with Sharing class relatedContactsController {
    
    @auraEnabled
    public static List<Contact> relatedAccContacts(Id recordId, integer counter){
       counter = 10* integer.valueOf(counter);
        List<Contact> contactList = new List<Contact>();
        //string query = 'SELECT ID, Name, Email,Phone,AccountId FROM Contact WHERE AccountId =: recordId LIMIT 10 OFFSET count';
        String query = 'SELECT Name, Email, Account.Name FROM Contact WHERE account.id =\'' + recordId +'\' LIMIT 10 OFFSET '+counter;
        return database.query(query);
        }
}