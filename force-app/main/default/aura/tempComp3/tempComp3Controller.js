/*createComponentController.js*/
({
    doInit : function(cmp) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id": "findableAuraId",
                "label": "Show dynamic component",
                "onclick": cmp.getReference("c.handlePress")
            },
            function(newButton, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = cmp.get("v.body");
                    body.push(newButton);
                    cmp.set("v.body", body);
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
    
    handlePress : function(cmp) {
        // Find the button by the aura:id value
        console.log("button: " + cmp.find("findableAuraId"));
        console.log("button pressed");
        $A.createComponent(
            "c:ContactList",
            {},
            function(msgBox){                
                if (cmp.isValid()) {
                    var targetCmp = cmp.find('ModalDialogPlaceholder');
                    var body = targetCmp.get("v.body");
                    
                    body.push(msgBox);
                    targetCmp.set("v.body", body); 
                }
            }
        );
    }
})