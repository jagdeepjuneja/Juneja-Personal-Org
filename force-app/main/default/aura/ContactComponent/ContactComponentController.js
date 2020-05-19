({
	sendEmailToContact : function(component, event, helper) {
        var conId = component.get("v.conId");
        console.log('conId is '+conId);
        //if (!$A.util.isEmpty(conId) && (conIdValue.length==15 || conIdValue.length==18)){
            console.log('inside if block');
            var action = component.get("c.sendEmailToContact1");
            action.setParams({ "conId" : conId });
            action.setCallback(this,function(res) { 
            var stt = res.getState();
            if (stt === "SUCCESS") {
               console.log('=======debug ====');   
            }
       });
       
     	//}
        $A.enqueueAction(action);      
    }
})