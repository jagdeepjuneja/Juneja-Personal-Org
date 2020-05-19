({
    onSearch : function(component, event, helper) {
        /*helper.callServer(component, "c.getBoats",
                          function(response){
                              if(response.length > 0){
                                  component.set("v.boats" , response);
                                  component.set("v.boatFound", true);
                              }
                              else{
                                  component.set("v.boatFound", false);
                              }
                          },{
                              boatTypeId : component.get("v.boatTypeIdComponent")
                          }
                         );
    }*/

    console.log('here1'+component.get("v.boatTypeIdComponent"));
      var x=component.get("v.boatTypeIdComponent")
        //var action = component.get("c.getBoats");
        //if(x=='All Types'){
        //    x='';
        //}
      var action = component.get("c.getBoats");
          action.setParams({
            "boatTypeId":x
          });
        action.setCallback(this, function(response) {
               
                var state = response.getState();
                if (component.isValid() && state === "SUCCESS") {
                    console.log('in success');
                    component.set("v.boats" , response.getReturnValue());
                    component.set("v.boatFound", true);
                }
                else {
                    console.log("Failed with state1: " + state);
                }
          });
        $A.enqueueAction(action);
  }
})