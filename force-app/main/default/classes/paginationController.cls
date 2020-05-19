public class paginationController {
  public List<Opportunity> oppList {get;set;}
  //public ApexPages.StandardSetController setCon {get;set;}
  public Integer pageSize {get;set;}
  public Integer noOfRecords {get;set;}
  public List<SelectOption> paginationSizeOption {get;set;}
  
  public paginationController(){
    pageSize = 10;
    paginationSizeOption = new List<SelectOption>();
    paginationSizeOption.add(new SelectOption('5','5'));
    paginationSizeOption.add(new SelectOption('10','10'));
    paginationSizeOption.add(new SelectOption('20','20'));
    paginationSizeOption.add(new SelectOption('50','50'));
    paginationSizeOption.add(new SelectOption('100','100'));
    
    oppList = [SELECT AccountId,Name FROM Opportunity LIMIT 500];
  }
  
  public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {                
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [SELECT Name, AccountId FROM Opportunity]));
                setCon.setPageSize(pageSize);  
                noOfRecords = setCon.getResultSize();
            }            
            return setCon;
        }
        set;
    }
  
  public void refreshPageSize(){
    setCon.setPageSize(pageSize);
    noOfRecords = setCon.getResultSize();
  }
  
  public List<Opportunity> getOpportunities() {
         return (List<Opportunity>) setCon.getRecords();
    }
  
}