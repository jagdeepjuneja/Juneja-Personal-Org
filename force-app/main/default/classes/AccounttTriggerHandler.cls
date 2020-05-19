public class AccounttTriggerHandler {
  
  public void afterInsert(List<Account> accList) {
    createContactOnAccountInsert(accList);
  }
  
  public void createContactOnAccountInsert(List<Account> accList){
    Map<Id, Attachment> mapOfAccIdAndAttachment = new Map<Id, Attachment>();
    List<Contact> conListToCreate = new List<Contact>();
    List<Attachment> attListToCreate = new List<Attachment>();
    Attachment att = new Attachment();
    
    for(Attachment atc : [SELECT ParentId,Name, Body FROM Attachment WHERE ParentID IN: accList]){
      mapOfAccIdAndAttachment.put(atc.ParentId, atc);
    }
    System.debug('test mapOfAccIdAndAttachment is '+mapOfAccIdAndAttachment);
    
    if(!mapOfAccIdAndAttachment.isEmpty()){
      Contact con;
      for(Account acc : accList){
        if(mapOfAccIdAndAttachment.containsKey(acc.Id)){
          con = new Contact();
          con.AccountId = acc.Id;
          con.LastName = acc.Name + 'Contact';
          conListToCreate.add(con);
        }
      }
      System.debug('test conListToCreate is '+conListToCreate);
      
      if(!conListToCreate.isEmpty()){
        insert conListToCreate;
        
        for(Contact conVar : conListToCreate){
          att = new Attachment();
          att.ParentId = conVar.AccountId;
          if(mapOfAccIdAndAttachment.containsKey(conVar.AccountId)){
            att.Name = mapOfAccIdAndAttachment.get(conVar.AccountId).Name;
            att.Body = mapOfAccIdAndAttachment.get(conVar.AccountId).Body;
          }
          attListToCreate.add(att);
        }
        
        System.debug('test attListToCreate is '+attListToCreate);
        
        if(!attListToCreate.isEmpty()){
          insert attListToCreate;
        }
        
      }
      
      
      
      
    }
    
  }
}