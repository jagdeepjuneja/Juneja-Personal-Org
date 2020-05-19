({
    doInit : function(component, event) {
    },
    handleClick: function(component, event) {
        alert('button clickec');
        alert(component.get("v.recordId"));
        var action = component.get("c.sendEmailToContactOwner");
        action.setParams({
            conId: component.get("v.recordId")
        });
        $A.enqueueAction(action);
    }
})