//Scheduled Apex 
public class DemoScheduler1 implements Schedulable{
    public void execute(SchedulableContext sc){
        system.debug('*******Going to call future method ');
        DemoAsynchronousTest.futureMethodCallFromScheduler();
    }
}