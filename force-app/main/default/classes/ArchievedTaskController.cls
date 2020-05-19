/*

Created By: Jagdeep Juneja
Created On: 04/14/2017
Purpose: Project- SPR Premium Feature.(This is controller class of archievedTask and archievedTask1 vf page that show all archieved task i.e.
         task created befor 1 year.)
--------------------------------------------------------------------------
*/
public class ArchievedTaskController {
  
  //This variable is used to store all tasks that will be queried.
  private List<Task> allTasks {get;set;}
  //This variable is used to store all tasks that will be displayed on page using pagination.
  public List<Task> taskListToShow {get;set;}
  //This variable is used to store the all tasks count that will be query.
  private Integer totalSize = 0;
  //This variable is used on which page user is currently have.
  private Integer counter = 0;
  //This variable is used to show number on task on each page.
  private Integer limitSize = 10;
  
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: This is constructor method of the controller.
   --------------------------------------------------------------------------
  */  
  public ArchievedTaskController(){
    allTasks = new List<Task>();
    taskListToShow = new List<Task>();
    allTasks = [SELECT Subject,AccountId, Description, Status, createdDate FROM TASK];
    totalSize = allTasks.size();
    
    first();
  }//END of public ArchievedTaskController(){ constructor.
  
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: When user click on first button, it will take user to first page.
   --------------------------------------------------------------------------
  */
  public void first(){
    taskListToShow.clear();
    counter=0;
    
    if((counter + limitSize) <= totalSize){
      for(Integer i=0;i<limitSize;i++){
        taskListToShow.add(allTasks.get(i));
      }//END of for(Integer i=0;i<limitSize;i++){ loop.   
    }//END of if((counter + limitSize) <= totalSize){ block.
    else{
      for(Integer i=0;i<totalSize;i++){
        taskListToShow.add(allTasks.get(i));
      }//END of for(Integer i=0;i<totalSize;i++){ loop.       
    }//END of else block.
  }//END of public void first(){ method.
  
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: When user click on next button, it will take user to next page.
   --------------------------------------------------------------------------
  */ 
  public void next(){
    taskListToShow.clear();
    counter=counter+limitSize;
   
    if((counter+limitSize) <= totalSize){
      for(Integer i=counter-1;i<(counter+limitSize);i++){
        taskListToShow.add(allTasks.get(i));
      }//END of for(Integer i=counter-1;i<(counter+limitSize);i++){ loop.
    }//END of if((counter+limitSize) <= totalSize){ block. 
    else{
      for(Integer i=counter;i<totalSize;i++){
        taskListToShow.add(allTasks.get(i));
      }//END of for(Integer i=counter;i<totalSize;i++){ loop.
    }//END of else block.
  }//END of public void next(){ method.
   
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: When user click on previous button, it will take user to previous page.
   --------------------------------------------------------------------------
  */ 
  public void previous(){
    taskListToShow.clear();
    counter=counter-limitSize;       
   
    for(Integer i=counter;i<(counter+limitSize); i++){
      taskListToShow.add(allTasks.get(i));
    }//END of for(Integer i=counter;i<(counter+limitSize); i++){ loop.
  }//END of public void previous(){ method.
  
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: When user click on last button, it will take user to last page.
   --------------------------------------------------------------------------
  */
  public void last (){
    taskListToShow.clear();
   
    if(math.mod(totalSize , limitSize) == 0){
      counter = limitSize * ((totalSize/limitSize)-1);
    }//END of if(math.mod(totalSize , limitSize) == 0){ block.
    else if (math.mod(totalSize , limitSize) != 0){
      counter = limitSize * ((totalSize/limitSize));
    }//END of else if (math.mod(totalSize , limitSize) != 0){ block.
   
    for(Integer i=counter-1;i<totalSize-1;i++){
      taskListToShow.add(allTasks.get(i));
    }//END of for(Integer i=counter-1;i<totalSize-1;i++){ loop.
  }//END of public void last (){ method.
  
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: When user is on the last page, it disable the next button.
   --------------------------------------------------------------------------
  */ 
  public Boolean getDisableNext(){
    if((counter + limitSize) >= totalSize ){
      return true ;
    }//END of if((counter + limitSize) >= totalSize ){ block.
    else{
      return false ;
    }//END of else block.
  }//END of public Boolean getDisableNext(){ method.
  
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: When user is on the first page, it disable the previous button.
   --------------------------------------------------------------------------
  */ 
  public Boolean getDisablePrevious(){
    if(counter == 0){
      return true ;
    }//END of if(counter == 0){ block.
    else{
      return false ;
    }//END of else block.
  }//END of public Boolean getDisablePrevious(){ method. 
  
  /*
   Created By: Jagdeep Juneja
   Created On: 04/14/2017
   Purpose: When user click on Export to Excel button, it will take user to archievedTask1 vf page and download the page in excel file.
   --------------------------------------------------------------------------
  */  
  public Pagereference exportAll(){
    return new Pagereference('/apex/archievedTask1');
  }//END of public Pagereference exportAll(){ method.
  
}//END of public class ArchievedTaskController { class.