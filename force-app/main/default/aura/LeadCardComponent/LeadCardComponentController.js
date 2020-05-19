({
    doInit : function(component, event, helper) {
        var action = component.get("c.getLeadSource");
        var inputsel = component.find("leadSourceField");
        var opts=[];
        opts.push({"class": "optionClass", label: 'Select a lead source', value: 'Select a lead source'});
        opts.push({"class": "optionClass", label: 'None', value: ''});
        action.setCallback(this, function(a) {
            for(var i=0;i< a.getReturnValue().length;i++){
                opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
            }
            inputsel.set("v.options", opts);
        });
        $A.enqueueAction(action); 
        helper.getMessage(component, event, helper);
    },
    picklistChange : function(component, event, helper) {
        alert(component.find("leadSourceField").get("v.value"));
        if(component.find("leadSourceField").get("v.value") !== 'Select a lead source'){
            var action = component.get("c.getLeadRecords");
            action.setParams({
                "leadSource": component.find("leadSourceField").get("v.value")
            });
            action.setCallback(this, function(a) {
                component.set("v.contacts", a.getReturnValue());
            });
            $A.enqueueAction(action);
            //helper.getMessage(component);
        }
    }
})