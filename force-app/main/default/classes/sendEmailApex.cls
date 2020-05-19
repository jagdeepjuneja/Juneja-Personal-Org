public class sendEmailApex {
    @AuraEnabled
    public static void sendEmailToContactOwner(String conId) {
        System.debug('jagdeep conId is'+conId);
        String ownerEmail = [SELECT Email FROM Contact where ID=: conId].Email;
        EmailTemplate template = [Select id,Subject,HtmlValue,Body from EmailTemplate where name='Approve Opportunity Discount'];
        List<Messaging.SingleEmailMessage> EmailsToBeSent = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage singleMessage1 = new Messaging.SingleEmailMessage();
        singleMessage1.setSaveAsActivity(false);
        singleMessage1.setTemplateId(template.Id);
        singleMessage1.setWhatId('a096F000027Vxzr');  //pass record id.
        singleMessage1.setTargetObjectId('0036F00002Du7Vs'); //pass sample contact id.
        singleMessage1.setTreatTargetObjectAsRecipient(false);
        singleMessage1.setToAddresses(new List<String>{ownerEmail});
        EmailsToBeSent.add(singleMessage1);
        if (EmailsToBeSent.size() > 0) {
            Messaging.sendEmail(EmailsToBeSent);
        }
    }
    
    @AuraEnabled
    public static List<Account> getAccountRecords() {
      return [SELECT Name, Phone FROM Account LIMIT 10];
    }
    
    @AuraEnabled
    public static Account getParentAccountDetail(String accId) {
      System.debug('jagdeep conId is'+accId);
     Account acc = [SELECT ID,Phone FROM Account WHERE Id =: accId LIMIT 1];
     if(acc != null){
         return acc;
     }
     else{
       return new Account(); 
     }
   }  
}