public class fileUploadController2 {
    public Account obj {get;set;}
    
    public fileUploadController2(){
        System.debug('first');
        obj = new Account();
        obj = [select id from Account where id = '0016F000033pp5m'];
    }
    
    
    public void createDemoObjectRecord(){
        System.debug('second');
        //insert obj;
    }
}