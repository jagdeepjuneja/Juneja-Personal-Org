({
    doInit : function (component, event,helper) {
        var action = component.get("c.getParentAccountDetail");
        action.setParams({
            "accId": component.get("v.recordId"),
        });
        action.setCallback(this,function(response) {
            var createRecordEvent = $A.get("e.force:createRecord");
            createRecordEvent.setParams({
                "entityApiName": "Contact",
                "defaultFieldValues": {
                    'Phone' : response.getReturnValue().Phone,
                    'AccountId' : component.get("v.recordId")
                }
            });
            createRecordEvent.fire();
            var dismissActionPanel = $A.get("e.force:closeQuickAction");
            dismissActionPanel.fire();
        });
        $A.enqueueAction(action);
    }
})