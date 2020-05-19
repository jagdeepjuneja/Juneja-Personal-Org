({
    doInit : function(component, event, helper) {
        helper.onSearch(component, event, helper);	
    },
    doSearch :function(component, event, helper) {
        var params = event.getParam("arguments");
        if(params){
            component.set("v.boatTypeIdComponent", params.boatTypeId);
            helper.onSearch(component, event, helper);
        }
    },
    onBoatSelect : function(component, event, helper) {
        component.set("v.selectedBoatId", event.getParam("boatId"));
    }
    
})