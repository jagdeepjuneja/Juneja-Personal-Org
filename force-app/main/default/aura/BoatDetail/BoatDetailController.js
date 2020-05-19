({
    doInit : function(component, event, helper) {
        var createBoatRecord = $A.get("e.force:navigateToSObject");
        if(createBoatRecord){
            component.set("v.showCardAction" , true);
        }
    },
    
    onFullDetails : function(component, event, helper) {
        //alert('hello');
        alert(component.get("v.boat"));
        //alert(component.get("v.boat").Id);
        var navEvt = $A.get("e.force:navigateToSObject");
        if(navEvt){
            navEvt.setParams({
                "recordId" : component.get("v.boat").Id,
                "slideDevName" : "detail"
            });
        }else{
            alert('hello');
            console.log('event not supported');
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Info Message',
                message: 'Event not supported or record id is null',
            });
            toastEvent.fire();
        }
        navEvt.fire();
    }
})