public class displayApiNamesController {
    public String labelReceived{get;set;}
    public list<String> apinames {get;set;}
    public Boolean displayApiNames{get;set;}
    public displayApiNamesController(){    
        displayApiNames = false;
    }
    
    public void getApiNames(){
        displayApiNames = true;
        List<String> finalList = new List<string>();
        apinames = new list<string>();
        
        for(String s:labelReceived.split(',')){
            finalList.add(s);
        }
        
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();         
        for(integer i=0;i<gd.size();i++){  
            for(String s: finalList){
                if(gd[i].getdescribe().getLabel()==s){
                    apinames.add(gd[i].getDescribe().getName());
                }
            }
        }
    }
    public void clearBox(){
        displayApiNames =false;
        labelReceived = '';
        apinames.clear();
    }
}