({
    doInit : function(component, event, helper) {
        console.log('in init of addBoatExp cmp');
        helper.onInit(component, event, helper);
        
    },
    
    onSave : function(component, event, helper) {
        component.set("v.boatExperience.Boat__c", component.get("v.boat").Id);
        component.find("service").saveRecord($A.getCallback(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                var toastEvent = $A.get("e.force:showToast");
                if(toastEvent){
                    toastEvent.setParams({
                        "title": "Save!",
                        "message": "Boat Exeprience added"
                    });
                    toastEvent.fire(); 
                    
                }else{
                    alert("Boat Exeprience added");
                }
                helper.onInit(component, event, helper);
                
                var evt = component.getEvent("BoatReviewAdded");
                evt.fire();
                
                
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
                helper.showToast(component, event, helper,  {
                    "title" : "ERROR!",
                    "type" : "error",
                    "message" : "Device doesn't support draft"
                });
                
                
            } else if (saveResult.state === "ERROR") {
                console.log('Problem saving record, error: ' + JSON.stringify(saveResult.error));
                helper.showToast(component, event, helper,  {
                    "title" : "ERROR!",
                    "type" : "error",
                    "message" : "Problem Saving record"
                });
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                helper.showToast(component, event, helper,  {
                    "title" : "ERROR!",
                    "type" : "error",
                    "message" : "Unknown Error"
                });
            }
        }));
    },
    
    onRecordUpdated : function(component, event, helper) {
        var eventParams = event.getParams();
        
        if (eventParams.changeType === "CHANGED") { 
            var changedFields = eventParams.changedFields;
            console.log('fields that are changed '+JSON.stringify(changedFields)); 
            helper.showToast(component, event, helper,  {
                "title" : "Saved!",
                "type" : "error",
                "message" : "The record was upated"
            });
        }else if (eventParams.changeType === "LOADED") {
            
        }else if (eventParams.changeType === "REMOVED") {
            
        }else if (eventParams.changeType === "ERROR") {
            
        }
        
    }
    
})