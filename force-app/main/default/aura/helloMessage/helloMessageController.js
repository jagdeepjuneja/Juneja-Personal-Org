({
	handleClick : function(component, event, helper) {
		var btnClk = event.getSource();
        var btnClkLabel = btnClk.get("v.label");
        console.log('message is '+btnClkLabel);
        S
        component.set("v.message", btnClkLabel);
	}
})