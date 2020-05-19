({
	onFormSubmit : function(component, event, helper) {
		//var boatTypeId = event.getParam('boatTypeId');
		var formData = event.getParam("formData");
        var boatTypeId = formData.boatTypeId;
        console.log('boatTypeId is '+boatTypeId);
        
        var boatSearchResultComp = component.find("boatSearchResult");
        console.log("boatSearchCompResult is "+boatSearchCompResult);
        var boatSearchCompResult = boatSearchResultComp.searchBoats(boatTypeId);
        console.log("boatSearchCompResult is "+boatSearchCompResult);
	}
})