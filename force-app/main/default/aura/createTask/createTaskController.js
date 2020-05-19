({
	createTask : function(component, event, helper) {
		
        var subjectValue = component.find("subject").get("v.value");
        var priorityValue = component.find("priority").get("v.value");
        var typeValue = component.find("type").get("v.value");
        var descriptionValue = component.find("description").get("v.value");
        console.log('subjectValue-'+subjectValue);
        console.log('priorityValue-'+priorityValue);
        console.log('typeValue-'+typeValue);
        console.log('descriptionValue-'+descriptionValue);
        var action = component.get("c.createNewTask");
        action.setParams({
            "subject" : subjectValue,
            "priority" : priorityValue,
            "type" : typeValue,
            "description" : descriptionValue,
        });
        action.setCallback(this, function(action){
            component.find("subject").set("v.value","");
            component.find("priority").set("v.value","Low");
            component.find("type").set("v.value","Email");
            component.find("description").set("v.value","");
            
        });
        $A.enqueueAction(action);
	}
})