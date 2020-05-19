({
    onRecordUpdated : function(component, event, helper) {
        
    },
    
    onBoatSelected : function(component, event, helper) {
        component.set("v.Id", event.getParam("boat").Id);
        console.log("boat id is "+event.getParam("boat").Id);
        component.find("service").reloadRecord();
    },
    
    onBoatReviewAdded : function(component, event, helper) {
        //component.find("boatdetailtab").set("v.tabId", "boatexp");  
        //component.find("boatexpId").refresh();
        component.find("details").set("v.selectedTabId", 'boatreviewtab');
        var BRcmp = component.find("BRcmp");
        console.log(BRcmp);
        var auraMethodResult = BRcmp.refresh();	
    }
})