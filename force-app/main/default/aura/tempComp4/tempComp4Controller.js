({
    doInit : function(component) {
      //component.set("v.cmpName", '<c:tempComp5 />');
      var body = component.get("v.body");
      var abc = 'hello'
      body.push(abc);
      component.set("v.body", body);

      
    },
    
    doHandleClick : function(component, event, helper) {
        //helper.onHandleClick(component, event, helper);
        $A.createComponent(
            "c:ContactList",
            {},
            function(msgBox){                
                if (component.isValid()) {
                    var targetCmp = component.find('ModalDialogPlaceholder');
                    var body = targetCmp.get("v.body");
                    body.push(msgBox);
                    targetCmp.set("v.body", body); 
                }
            }
        );  
    }
})