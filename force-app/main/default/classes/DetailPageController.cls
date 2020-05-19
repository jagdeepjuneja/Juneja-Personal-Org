public class DetailPageController {
    
  public List<SelectOption> options {get;set;}
  public List<SelectOption> options2 {get;set;}
  public String selectedOption {get;set;}
  private Map<String, String> tempMapOfLabelAndPrefix;
  private Set<String> allKeyPrefix;
  
  public String selectedRadio {get;set;}
  public Boolean showLabel {get;set;}
  public Boolean showApi {get;set;}
  
  public DetailPageController(){
      selectedRadio = 'By Label';
      options = new List<SelectOption>();
      options2 = new List<SelectOption>();
      tempMapOfLabelAndPrefix = new Map<String, String>();
      selectedOption = '';
      allKeyPrefix = new Set<String>();
      showLabel = true;
      showApi = false;
      
      for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
        
          Schema.SObjectType objInfo = Schema.getGlobalDescribe().get(String.valueOf(obj.getDescribe().getName()));
          Schema.DescribeSobjectResult objResult = objInfo.getDescribe();
          if(objResult.isCreateable()){
            
              if(obj.getDescribe().getKeyPrefix() !=null && obj.getDescribe().isAccessible() && obj.getDescribe().isCreateable()){
               
                  allKeyPrefix.add(String.valueOf(obj.getDescribe().getName()));
                  tempMapOfLabelAndPrefix.put(String.valueOf(obj.getDescribe().getName()),String.valueOf(obj.getDescribe().getKeyPrefix()));
                  options.add(new SelectOption(String.valueOf(obj.getDescribe().getKeyPrefix()), String.valueOf(obj.getDescribe().getLabel())));
                  options2.add(new SelectOption(String.valueOf(obj.getDescribe().getKeyPrefix()),String.valueOf(obj.getDescribe().getName())));
                  System.debug('test options2 is '+options2);
              }//END if(obj.getDescribe().getKeyPrefix() !=null && obj.getDescribe().isAccessible() && obj.getDescribe().isCreateable())
            
          }//END if(objResult.isCreateable())
        
      }//END for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() )
     
  }//END public getDetailPageController()
  
  
  public void onPicklistValueChange(){
  }
  
  public PageReference recHomePage(){
      return new Pagereference('/'+selectedOption);  
  }//END public PageReference recHomePage()
  
  public PageReference recNewPage(){
      return new Pagereference('/'+selectedOption+'/'+'e?retURL=%2F'+selectedOption+'%2Fo');
  }//END public PageReference recNewPage()
  
  public void radioButtonChanged(){
    if(selectedRadio.equals('By Label')){
        showLabel = true;
        showApi = false;
    }//END if(selectedRadio.equals('By Label'))
    else {
      showLabel = false;
      showApi = true;
    }//END else 
  }//END public void radioButtonChanged()
  
}//END public class getDetailPageController