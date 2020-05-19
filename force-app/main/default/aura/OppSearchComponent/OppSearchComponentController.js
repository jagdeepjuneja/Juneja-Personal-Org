({
    
    navigateToRecord : function(component, event, helper){
        var navEvt = $A.get("e.force:navigateToSObject");
        var recId = component.get("v.opp.Id");
        var selectedItem = event.currentTarget;
        var Name = selectedItem.dataset.record;
        console.log('jagdeep Name is '+Name);   
        navEvt.setParams({
            "recordId": Name,
            "slideDevName": "related"
        });
        navEvt.fire();
        
    },   
    getOpps: function(cmp){       
        cmp.set("v.showtbl","true");
        var action = cmp.get("c.getOpportunities");
        //action.setParams({ OppStage : cmp.find("nameopp").get("v.value") , Oppamount : cmp.find("amntopp").get("v.value")});       
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('jagdeep response.getReturnValue() is '+response.getReturnValue());
                cmp.set("v.opportunities", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})