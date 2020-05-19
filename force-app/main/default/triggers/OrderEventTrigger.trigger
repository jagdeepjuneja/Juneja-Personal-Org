trigger OrderEventTrigger on Order_Event__e (after insert) {
    // List to hold all tasks to be created.
    List<Task> taskList = new List<Task>();
    
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create Case to dispatch new team.
            Task t = new Task();
            t.Priority = 'Medium';
            t.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            t.OwnerId = event.CreatedById;
            taskList.add(t);
        }
    }
    
    // Insert all tasks corresponding to events received.
    insert taskList;
}