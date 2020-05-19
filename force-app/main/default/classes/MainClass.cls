public class MainClass {
   public static void main(){
       wrapperClass obj =  new wrapperClass();
       String json_instance = Json.serialize(obj);
       Map<String, Object> untyped_instance;
       untyped_instance= (Map<String, Object>)JSON.deserializeUntyped(json_instance);
       System.debug('test untyped_instance is '+untyped_instance);         
       System.debug('test key set is '+untyped_instance.keySet());
       
   }
   
   public class wrapperClass{
        String field1{get;set;}
        String field2{get;set;} 
        // public wrapperClass(String field1, String field2){
        //     this.field1= field1;
        //     this.field2 = field2;
        // }
   }
}