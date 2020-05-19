public class ContactListController2 {
    
    public Contact con {get;set;}
    public List<Contact> conList {get;set;}
    public string editContactId{get;set;}  
    public string deleteContactId{get;set;}  
    private Map<Id, Contact> mapOfConIdAndContact;
    
    public ContactListController2(){
        con = new Contact();
        conList = new List<Contact>();
        editContactId = '';
        deleteContactId = '';
        mapOfConIdAndContact = new Map<Id, Contact>();
    }//END public ContactListController2(){
    
    public void getContacts(){
        System.debug('test account id is '+con.AccountId);
        if(con.AccountId != NULL){
          conList = [select Name, Email FROM Contact WHERE AccountId =: con.AccountId];
        
            for(Contact con: conList){
                mapOfConIdAndContact.put(con.Id, con);
            }//END for(Contact con: conList){
            System.debug('test conList  is '+conList);    
        }//END if(con.AccountId != NULL){
    }//END public void getContacts(){
    
    public PageReference editContact(){  
        System.debug('test editContactId is '+editContactId);
        pageReference pg = new pagereference('/'+editContactId+'/e?retURL=%2F'+con.AccountId);  
        return pg;  
    } 
    public PageReference deleteContact() {  
        System.debug('test deleteContactId is '+deleteContactId);
        if(mapOfConIdAndContact.containsKey(deleteContactId)){
            delete mapOfConIdAndContact.get(deleteContactId);
        }
        pagereference pg= new pagereference('/'+con.AccountId);  
        return pg;  
   }  

}