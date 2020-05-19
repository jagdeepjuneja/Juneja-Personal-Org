({
	addLogic : function(component, event, helper) {
		var parameters = event.getParam('arguments');
        return (parameters.x + parameters.y);
	}
})