public class fiboPageClass {
  public String fiboNumber {get;set;}
  public String result {get;set;}
  
  
  public fiboPageClass(){
    fiboNumber = '';
    result = '';
    fiboNumber = ApexPages.currentPage().getParameters().get('Number');
  }
  
  public void getSequence(){
    Integer j = Integer.valueOf(fiboNumber);
    Integer a = 1;
    Integer b = 1;
    Integer previous;
    result = '';
    for(Integer i=1; i< = j; i++){
      previous = a+b;   //2,3,5,10
      
      a = b;
      b = previous;
      result +=  b + ',';
    }
    System.debug('test result is'+result);
  }
  
}