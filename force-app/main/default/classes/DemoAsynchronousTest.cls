//apex class containing future method
public class DemoAsynchronousTest{
    @future
    public static void futureMethodCallFromScheduler(){
        system.debug('******futureMethodCallFromScheduler get called');
    }
    
}