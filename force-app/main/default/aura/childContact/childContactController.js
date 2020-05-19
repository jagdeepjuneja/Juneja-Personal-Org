({
	doInit : function(component, event, helper) {
        console.log('in init method');
		var action = component.get("c.getChildContacts");
        action.setParams({
            "accId" : component.get("v.recordId"),
            "os"    : component.get("v.offset")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contacts", response.getReturnValue());
            }
        }); 
        $A.enqueueAction(action);
                
	}
})