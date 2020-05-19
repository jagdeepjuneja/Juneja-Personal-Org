public class InvocalbeApexClass {
    
  @InvocableMethod(label='Get Account Names' description='Returns the list of account names corresponding to the specified account IDs.')
  public static void InvocableApexMethod(List<ID> ids) {
      
      System.debug('jagdeep ids are '+ids);
  }
  
  
}