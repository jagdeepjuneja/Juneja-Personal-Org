({
	doInit : function(component, event, helper) {
        var action = component.get("c.getAccRecord");
        var fieldName = component.get("v.fieldName");
        action.setCallback(this, function(response) {
            var rec = response.getReturnValue();
            component.set("v.val", rec[1][fieldName]);
        });
        
        $A.enqueueAction(action);		
	}
})