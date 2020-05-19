public class DynamicCmpController {
  @AuraEnabled
  public static String getAppName(){
      UserAppInfo userAppInfo = [SELECT Id, AppDefinitionId FROM UserAppInfo WHERE UserId = :UserInfo.getUserId() LIMIT 1];
      AppDefinition appDefinition = [SELECT DurableId, Label FROM AppDefinition Where DurableId = :userAppInfo.AppDefinitionId LIMIT 1];
      System.debug(appDefinition.Label);
      return appDefinition.Label;
  }  
}