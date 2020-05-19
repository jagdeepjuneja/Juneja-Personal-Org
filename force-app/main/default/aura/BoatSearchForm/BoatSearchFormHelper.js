({
	getBoatType : function(component, event, helper) {
		/*var action  = component.get("c.getCarTypes");
        action.setCallback(this, function(data){
            var state = data.getState();
            if(state === "SUCCESS"){
                component.set("v.carTypes", data.getReturnValue());
            }
            else{
                alert('Unknown error');
            }
        });
        $A.enqueueAction(action);
        //commented bcoz we are using inheritance to call server method from base component like below.
        */
        helper.callServer(component, "c.getBoatTypes", 
                          function(response){
                              component.set("v.boatTypes", response);
                          });
	}
})