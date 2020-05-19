({
    doInit : function(component, event, helper) {
        var action = component.get("c.getContacts");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.debug(response.getReturnValue().length);
                component.set("v.contacts", response.getReturnValue());
            } else {
                console.debug(response.error[0].message);
            }
        });
        $A.enqueueAction(action);
        
    }
})