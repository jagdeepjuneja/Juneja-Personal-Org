global class JSONTOLIST
{
    public List<SFInstance> sfInstances{get;set;}
    public JSONTOLIST()
    {
        String inputData = '9781436113311';
        HttpRequest req = new HttpRequest();      
        req.setEndpoint('https://www.googleapis.com/books/v1/volumes?q=inputData');
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse res;
        res = http.send(req);
        System.debug('test res '+res);
        System.debug('test body is  '+res.getBody());
        JSONParser parser = JSON.createParser(res.getBody());
        System.debug('test parser is '+parser);
    }
    
    global class SFInstance implements Comparable
    {
        public String country{get;set;}
        // public String authors{get;set;}
        // public String title{get;set;}
        
        public Integer compareTo(Object ObjToCompare)
        {
            return country.CompareTo(((SFInstance)ObjToCompare).country);
        }
    }
    
}