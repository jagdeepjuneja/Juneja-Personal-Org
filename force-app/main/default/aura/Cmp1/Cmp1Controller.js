({
    "echo" : function(cmp) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        
        
        
        var action = cmp.get("c.serverEcho");
        action.setParams({ firstName : cmp.get("v.firstName") });
        
        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Alert the user with the value returned 
                // from the server
                alert("From server: " + response.getReturnValue());
                
                var delay=90000; //4 seconds
                setTimeout(function() {
                    console.log('Inside delay: ');
                    
                    var action2 = cmp.get("c.serverEcho2");
                    action2.setParams({ lastName : cmp.get("v.lastName") });
                    
                    // Create a callback that is executed after 
                    // the server-side action returns
                    action2.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state === "SUCCESS") {
                            console.log('first debug');
                            // Alert the user with the value returned 
                            // from the server
                            alert("From server: " + response.getReturnValue());
                            
                            // You would typically fire a event here to trigger 
                            // client-side notification that the server-side 
                            // action is complete
                        }
                        else if (state === "INCOMPLETE") {
                            // do something
                            console.log('second debug');
                        }
                            else if (state === "ERROR") {
                                console.log('third debug');
                                var errors = response.getError();
                                if (errors) {
                                    if (errors[0] && errors[0].message) {
                                        console.log("Error message: " + 
                                                    errors[0].message);
                                    }
                                } else {
                                    console.log("Unknown error");
                                }
                            }
                                else{
                                    console.log('fourth debug');
                                }
                    });
                    
                    // optionally set storable, abortable, background flag here
                    
                    // A client-side action could cause multiple events, 
                    // which could trigger other events and 
                    // other server-side action calls.
                    // $A.enqueueAction adds the server-side action to the queue.
                    $A.enqueueAction(action2);
                }, delay);
                
                // You would typically fire a event here to trigger 
                // client-side notification that the server-side 
                // action is complete
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        
        // optionally set storable, abortable, background flag here
        
        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
        
        
        
        
        
        
    },
    
    "echo2" : function(cmp) {
        alert('last');
    }
    
    
})