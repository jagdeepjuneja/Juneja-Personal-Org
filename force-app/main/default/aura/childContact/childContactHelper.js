({
	getNextPage : function(component) {
		var action = component.get("c.getChildContacts");
        var os = component.get("v.offset");
        os++;
        component.set("v.offset", os);
        action.setParams({
            "accId" : component.get("v.recordId"),
            "os"    : os
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var arr = component.get("v.contacts");
                for(var i=0; i<response.getReturnValue().length;i++){
                  arr.push(response.getReturnValue()[i]); 
                }
                 
                component.set("v.contacts", arr);
            }
        }); 
        $A.enqueueAction(action);
	}
})