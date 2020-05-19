({
    onBoatClick : function(component, event, helper) {
        //below event is to notify to BoatSearchResult component.
        var boat = component.get("v.boat");
        var evt = component.getEvent("onBoatSelect");
        evt.setParams({"boatId" : boat.Id});
        evt.fire();
        
        
        //below event is to notify to BoatDetails component.
        var appEvt = $A.get("e.c:BoatSelected");
        if(appEvt){
            //alert('app event fired');
            //console.log('boat is '+JSON.stringify(boat));
            appEvt.setParams({
                "boat" : boat
            });
            appEvt.fire();
        }
        else{
            alert('event not supported');
        }
        
        var plotEvent = $A.get("e.c:PlotMapMarker");
          
        plotEvent.setParams({
            "lat": boat.Geolocation__Latitude__s,
            "sObjectId": boat.Id,
            "long": boat.Geolocation__Longitude__s,
            "label":boat.Name
        });
        plotEvent.fire(); 
    }
})