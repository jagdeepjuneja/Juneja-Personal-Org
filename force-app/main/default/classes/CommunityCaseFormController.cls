public class CommunityCaseFormController {

    @AuraEnabled
    public static ResponseWrapper createCase() {
      Case c = new Case();
        try {
            insert c;
            return new ResponseWrapper(true, null);
        } catch (DMLException dmle) {
            //return new ResponseWrapper(false, dmle.getDmlMessage());
            String message = dmle.getDmlMessage(0);
            return new ResponseWrapper(false, message);
            
        }
        

    }
    
    public class ResponseWrapper{
      @AuraEnabled
      public Boolean status;
      public String message;
      
      public ResponseWrapper(Boolean status, String message){
        this.status = status;
        this.message = message;
      }
    }
}