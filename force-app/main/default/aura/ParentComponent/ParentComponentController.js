({
	onButtonClick : function(component, event, helper) {
		component.set("v.show", true);
	},
    
    PassToChildMethod : function(component, event, helper) {
		component.set("v.displayMessage" , event.getParamm("passval"));
	}
})