({
	handleClick : function(component, event, helper) {
		var childComp = component.find("childCompId");
        var result = childComp.add(3,4);
        console.log('test result is '+result);
	}
})