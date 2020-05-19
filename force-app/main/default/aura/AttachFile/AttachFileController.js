({
    handleSave: function(component, event, helper) {
        //alert(component.find("fuploader").get("v.files").length);
        helper.uploadHelper(component, event);
    },
    
    addFile : function(component, event, helper) {
        var counter = component.get("v.counter");
        counter = counter +1;
        component.set("v.counter" , counter);
        $A.createComponent(
            "lightning:input",
            {
                "type" : "file",
                "aura:id": "fuploader"+counter
            },
            function(newComp, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComp);
                    component.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }
        );
        
    },
    
})