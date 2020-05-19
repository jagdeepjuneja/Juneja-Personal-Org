public class BookSearchController {
    public String author {get;set;}
    public String title {get;set;}
    public String isbnCode {get;set;}
    public List<bookRecordsWrapper> bookRecordsWrapperList {get; set;}
    public List<SelectOption> readingList {get;set;}
    public String selectedReadingListName {get;set;}
    
    public BookSearchController(){
        author = '';
        title = '';
        isbnCode = '';
        bookRecordsWrapperList = new List<bookRecordsWrapper>();
        selectedReadingListName= '';
        readingList = new List<SelectOption>();
        readingList.add(new SelectOption('None', 'None'));
        for(Reading_List__c obj : [SELECT Name FROM Reading_List__c]){
            readingList.add(new SelectOption(obj.Name, obj.Name));
        }
    }
    
    public void bookSearch(){
        System.debug('test selectedReadingListName is '+selectedReadingListName);
        bookRecordsWrapperList = new List<bookRecordsWrapper>();
        
        String testString = '';
        if(author != '' && !String.isBlank(author)){
            testString = author.replace(' ','&');
        }
        
        HttpRequest req = new HttpRequest();      
        req.setEndpoint('https://www.googleapis.com/books/v1/volumes?q='+testString);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse response;
        response = http.send(req);
        //System.debug('test response is '+response);
        System.debug('test response '+response.getBody());
        
        // Parse JSON response to get all the totalPrice field values.
        JSONParser parser = JSON.createParser(response.getBody());
        Double grandTotal = 0.0;
        Integer i = 0;
        while (parser.nextToken() != null) {
           
            Boolean entered = false;
            bookRecordsWrapper wrapObj = new bookRecordsWrapper('','', '');
            String title = '';
            String author = '';
            String publisher = '';
            
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'title')) {
                    parser.nextToken();
                   // entered = true;
                   i++;
                    title = parser.getText();
            }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'authors')) {
                    parser.nextToken();
                    parser.nextToken();
                   // entered = true;
                 i++;

                    author = parser.getText();
            }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'publisher')) {
                    parser.nextToken();
                  //  entered = true;
                 i++;

                    publisher = parser.getText();
            }
            if(math.mod(i,3) == 0){
                //if(title != '' && author != '' && publisher != '')
                bookRecordsWrapperList.add(new bookRecordsWrapper(title, author, publisher));
                
            }
        }
        System.debug('test bookRecordsWrapperList is '+bookRecordsWrapperList);
        bookRecordsWrapperList.add(new bookRecordsWrapper('helkdaf','dfsda','dsf'));
       /* Integer j = 0;
        while (j < bookRecordsWrapperList.size())
        {
          if(bookRecordsWrapperList.get(j).title == '' || bookRecordsWrapperList.get(j).author == ''|| bookRecordsWrapperList.get(j).publisher == '' )
          {
            bookRecordsWrapperList.remove(j);
          }else
          {
            j++;
          }
        }*/
        
        
    }
    
    public class bookRecordsWrapper{
        public String title {get;set;}
        public String author {get;set;}
        public String publisher {get;set;}
        public Boolean selected {get;set;}
        
        public bookRecordsWrapper(String title, String author, String publisher){
            this.title = title;
            this.author = author;
            this.publisher = publisher;
            selected = false;
        }
    }
    
    
    
}