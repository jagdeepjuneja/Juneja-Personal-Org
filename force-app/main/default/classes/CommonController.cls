public class CommonController {
    public Account acc{get;set;}
    public Integer count {get;set;}
    public CommonController(){
        acc = new Account();
        count = 0;
    }
    public Pagereference moveToPageTwo(){
        count++;
    	return new Pagereference('/apex/page2');
    }
    public Pagereference moveToPageOne(){
    	return new Pagereference('/apex/page1');
    }
    public Pagereference tempMethod(){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
        ApexPages.addMessage(myMsg);
        return null;
    }
}