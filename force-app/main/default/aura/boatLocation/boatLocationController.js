({
	jsLoaded : function(component, event, helper) {
        component.set("v.jsLoaded", true);
    },
    
    loadMap : function(component, event, helper) {
        var boat = event.getParam("boat");
        var latitude = '37.785143'; //boat.geolocation__Latitude__s;
        var longitude = '37.785143';// boat.geolocation__Longitude__s;
        component.set("v.location", {'latitude' : latitude, 'longitude' : longitude});

    }
})