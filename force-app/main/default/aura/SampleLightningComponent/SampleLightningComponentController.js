({
	handleClick : function(component, event, helper) {
		var compEvent = component.getEvent("simpleEvent");
        console.log('compEvent>>>>' + compEvent);
        compEvent.setParams({ 'message': 'Clicked!'});
        compEvent.fire();
	},
    handleSimpleEvent : function(component, event, helper) {
        console.log('next debug');
		component.set("v.someMessage", "New value set is "+event.getParams('message'));
	},
})