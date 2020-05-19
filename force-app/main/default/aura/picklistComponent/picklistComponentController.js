({
    doInit: function(component, event, helper) {
        var action = component.get("c.getObjectMap");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var stringItems = response.getReturnValue();
                component.set("v.objectList", stringItems); 
            }
        });
        $A.enqueueAction(action);
    },
    onPicklistChange: function(component, event, helper) {
        // get the value of select option
        alert(event.getSource().get("v.value"));
        var action = component.get("c.showFieldTable");
        action.setParams({
            "selectedObjectApiName": event.getSource().get("v.value")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var stringItems = response.getReturnValue();
                component.set("v.fieldList", stringItems); 
            }
        });
        $A.enqueueAction(action);
    },
})