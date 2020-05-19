public class SoqlInjectionPageController {
    public String name {
        get { return name;}
        set { name = value;}
    } 
    public List<Contact> conList {get;set;}
    public PageReference query() {
        String qryString = 'SELECT Id, Name FROM Contact WHERE ' +
            '( Name like \'%' + name + '%\')';
        conList = Database.query(qryString);
        System.debug(conList);
        System.debug(conList.size());
        return null;
    }
}