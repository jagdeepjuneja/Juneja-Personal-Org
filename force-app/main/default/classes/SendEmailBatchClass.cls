global class SendEmailBatchClass implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'select id from account limit 1';
        return Database.getQueryLocator(query);    
    }
    global void execute(Database.BatchableContext BC, list<sObject> scope){
      System.debug('batch class debug');  
      EmailTemplate template = [Select id,BrandTemplateId,Subject,HtmlValue,Body from EmailTemplate where name= 'Test Vf email template'];
      List<Messaging.SingleEmailMessage> EmailsToBeSent = new List<Messaging.SingleEmailMessage>();
      
      Messaging.SingleEmailMessage singleMessage = new Messaging.SingleEmailMessage();
      //template id,contact/user/lead id or pass 	null,recordid
      singleMessage = Messaging.renderStoredEmailTemplate(template.Id, null, 'a036F00000qVVxL');
      singleMessage.setToAddresses(new List<String>{'mejuneja@gmail.com'});
      EmailsToBeSent.add(singleMessage);  
      
      if (EmailsToBeSent.size() > 0) {
      	Messaging.sendEmail(EmailsToBeSent);
      }
          
    }
    global void finish(Database.BatchableContext BC) {
        system.debug('finish Method Calling');
        
    }
}