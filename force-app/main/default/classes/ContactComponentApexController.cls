public with sharing class ContactComponentApexController {
    public ApexPages.StandardController stdCntrlr {get; set;}
    private String url;
    
    public ContactComponentApexController(ApexPages.StandardController controller){
        stdCntrlr = controller;
    }
    
  	@AuraEnabled
    public static void sendEmailToContact1(String conId){
        System.debug('===============conId is '+conId);
        Contact con=[SELECT email FROM Contact where ID=:conId LIMIT 1];
        update con;
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        String[] toAddresses = new String[] {con.Email}; 
        mail.setToAddresses(toAddresses); 
        mail.setReplyTo('mejuneja@gmail.com');  
        mail.setSenderDisplayName('Jagdeep Juneja lightning');
        mail.setSubject('Lightning subject');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setPlainTextBody('Test body');
        mails.add(mail);
        Messaging.sendEmail(mails); 
    }
    public void testMethod123(){
        url= ApexPages.currentPage().getParameters().get('id');
        System.debug('url is '+url);
        sendEmailToContact1(url);
    }
}