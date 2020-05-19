({
    callServer : function(component, method, callback, params) {
        var action = component.get(method);
        if(params){
            action.setParams(params);
        }
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                callback.call(this, response.getReturnValue());
            }else if(state === "ERROR"){
                var errors = response.getError();
                if(errors){
                    console.log("Errors "+errors);
                    if(errors[0] && errors[0].message){
                        throw new Error("Error "+ errors[0].message);
                    }
                    else{
                        throw new Error("unknown error");
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    showToast : function(component, event, helper, params) {
        var toastEvent = $A.get("e.force:showToast");
        if(toastEvent){
            if(!params){
                toastEvent.setParams({
                    "title": "Toast error!",
                    "type" : "error",
                    "message": "Toast param not defined"
                });
                toastEvent.fire();        
            } else{
                toastEvent.setParams(params);
                toastEvent.fire();
            }
        }else{
            alert(params.message);
        }
    }
    
})