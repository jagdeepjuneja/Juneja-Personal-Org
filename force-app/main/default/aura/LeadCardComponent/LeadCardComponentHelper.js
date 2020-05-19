({
    getMessage: function(component, event, helper) {
        //alert('in helper');
        var toastEvent = $A.get("e.force:showToast");
        //alert('in helper toastEvent '+toastEvent);
        toastEvent.setParams({
            "title": "Success! ",
            "message": 'Contact loaded'
        });
        toastEvent.fire();
        //$A.enqueueAction(action);
    }
})