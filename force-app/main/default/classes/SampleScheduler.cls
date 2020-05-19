global class SampleScheduler implements Schedulable{
    global void execute(SchedulableContext sc){
        SampleBatch sbVar = new SampleBatch();
        Id batchId = Database.executeBatch(sbVar, 200);
    }
}