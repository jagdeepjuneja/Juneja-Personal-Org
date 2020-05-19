public class SimpleServerSideController{

@AuraEnabled
public static String serverEcho(String firstName){
  return 'hi';
}

@AuraEnabled
public static String serverEcho2(String lastName){
  return 'hello';
}

}