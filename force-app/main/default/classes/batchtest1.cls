public class batchtest1 {
    public batch[] batches {get;set;}

    public batchtest1() {
        batches = new list<batch>();
        string batchString = 'implements Database.batchable<sObject>';
        for (ApexClass ac : [SELECT id, Name, Body FROM ApexClass]) {
            if (ac.Body.containsIgnoreCase(batchString)) {
                batches.add(new batch(ac));
            }
        }
    }

    public class batch {
        public ApexClass batch {get;set;}
        public string batchSize {get;set;}
        public id jobId {get;set;}
        public AsyncApexJob job {get;set;}
        public boolean pollingActive {get;set;}

        public batch(ApexClass xbatch) {
            batch = xbatch;
        }

        // Runs when user presses "Submit" on a batch 
        public void submitBatch() {
            pollingActive = true;
            if (batchSize == null) {
                batchSize = '200';
            }
            // I want to dynamically execute a batch based on the class name (ApexClass.Name) or class id (ApexClass.id)
            // Example of how I normally do it when the class name is known:
            //      myClass b = new myClass();
            //      jobId = Database.executeBatch(b, integer.valueOf(batchSize)
            // In this case I usually know the class name (myClass), however I want this to be dynamic based off what classes come back in the query
        }

        // Called from the action poller to update job info
        public void updateBatch() {
            job = [SELECT id, ApexClassId, CreatedDate, CompletedDate, ExtendedStatus, JobItemsProcessed, NumberOfErrors, Status, TotalJobItems
                   FROM AsyncApexJob 
                   WHERE id = : jobId LIMIT 1];
            if (job != null) {
                if (job.CompletedDate != null) {
                    pollingActive = false;
                }
            }
        }

    }
}