/*
  Created By: Jagdeep Juneja
  Created On: 7/1/2018
  Purpose:    Controller of IMDBVfPage to view all movies.
  -------------------------------------------------------------------------- 
*/
public class IMDBController {
  public List<Movie__c> movieList {get;set;}
  public Movie__c movieVar{get;set;}
  public Boolean showMovieSection{get;set;}
  public Boolean showNewMovieButton {get;set;}
  public Boolean producerSection {get;set;}
  public Producer__c prod {get;set;}
  public Boolean showActorSection {get;set;}
  public Actor__c actor {get;set;}
  public string editMovieId{get;set;}
  public Boolean MovieEditSection {get;set;}
  public String selectedMovieId {get;set;}
  public Movie__c tempMovieVar {get;set;}
  private Map<String, Movie__c> mapOfMovieIdAndMovie {get;set;}
  
  public IMDBController(){
    movieList = new List<Movie__c>();
    movieList = [select Name, Year_of_Release__c, Producer__r.Name, Plot__c, (select Actor__c,Actor__r.Name from ActorMovies__r)
                  FROM Movie__c Order by createdDate desc];
                  
    movieVar = new Movie__c();   
    showMovieSection = false;
    producerSection = false;
    showNewMovieButton = true;
    prod = new Producer__c();
    actor = new Actor__c();
    showActorSection = false;
    editMovieId = '';
    MovieEditSection = false;
    selectedMovieId = '';
    tempMovieVar = new Movie__c();
    mapOfMovieIdAndMovie = new Map<String, Movie__c>();
    
    for(Movie__c mv: movieList){
      mapOfMovieIdAndMovie.put(mv.Id, mv);
    }//END for(Movie__c mv: movieList){
  }//END public IMDBController(){
  
  public void createNewMovieSection(){
    movieVar = new Movie__c();
    showMovieSection = true;
    showNewMovieButton = false;
  }//END public void createNewMovieSection(){
  
  public void insertMovie(){
    insert movieVar;
    movieList = [select Name, Year_of_Release__c, Producer__r.Name, Plot__c,(select Actor__c,Actor__r.Name from ActorMovies__r)
                  FROM Movie__c Order by createdDate desc];
    System.debug('movieList size is '+movieList.size());              
    
    showMovieSection = false;
    showNewMovieButton = true;
  }//END public void insertMovie(){
  
  public void cancel(){
    showMovieSection = false;
    showNewMovieButton = true;
    producerSection = false;
    showActorSection = false;
    MovieEditSection = false;
  }//END public void cancel(){
  
  public void createProducerSection(){
    showMovieSection = false;
    producerSection = true;
  }//END public void createProducerSection(){
  
  public void insertProducer(){
    insert prod;
    showMovieSection = false;
    producerSection = false;
    showNewMovieButton = true;
  }//END public void insertProducer(){
  
  public void createActorSection(){
    showMovieSection = false;
    showActorSection = true;
  }//END public void createActorSection(){
  
  public void insertActor(){
    insert actor;
    showMovieSection = false;
    showActorSection = false;
    showNewMovieButton = true;
  }//END public void insertActor(){
  
  public PageReference editMovie(){  
    System.debug('test editMovie id is '+editMovieId);
    pageReference pg = new pagereference('/'+editMovieId+'/e?retURL=%2F'+editMovieId+'&_CONFIRMATIONTOKEN=VmpFPSxNakF4T0Mwd055MHdORlF4T1Rvek1qb3dOUzR4TmpGYSxOdDdNVk1BZTRBV3N3RVR2eDdHSTIyLE9EQTBZMkUw&common.udd.actions.ActionsUtilORIG_URI=%2F'+editMovieId+'%2Fe');  
    return pg;  
  }//END public PageReference editMovie(){   
  
  public void openMovieEditSection(){
    MovieEditSection = true;
    System.debug('test selectedMovieId is '+selectedMovieId);
    tempMovieVar = mapOfMovieIdAndMovie.get(selectedMovieId);
  }//END public void openMovieEditSection(){
  
  public void updateMovie(){
    update tempMovieVar;
    movieList = [select Name, Year_of_Release__c, Producer__r.Name, Plot__c,(select Actor__c,Actor__r.Name from ActorMovies__r)
                  FROM Movie__c Order by createdDate desc];
    MovieEditSection = false;              
  }//END public void updateMovie(){
  
  
}