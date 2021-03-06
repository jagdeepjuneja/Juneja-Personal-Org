({
    fetchAccounts : function(component, event) {
        console.log("something is working");
        var action = component.get("c.getAccountList");
        action.setCallback(this, function(res) {
            var state = res.getState(); 
            if (state === "SUCCESS") {
                console.log('wrapper list is ',res.getReturnValue());
                
                component.set("v.accountList", res.getReturnValue().accList);
                
                //Assing value of Account type picklist value.
                var accTypeField = component.find("InputAccountType");
                var accTypeArray = [];
                accTypeArray.push({class: "optionClass",label: "--- None ---",value: ""
                                  });
                for(var i=0;i< res.getReturnValue().accTypes.length;i++){
                    accTypeArray.push({"class": "optionClass", label: res.getReturnValue().accTypes[i], value: res.getReturnValue().accTypes[i]});
                }
                accTypeField.set("v.options", accTypeArray);
                component.set("v.typeArray", accTypeArray);
                
                //Assign valeu of Industry picklist value
                var inputIndustry = component.find("InputIndustryType");
                var industryArray=[];
                industryArray.push({class: "optionClass",label: "--- None ---",value: ""
                                   });
                for(var i=0;i< res.getReturnValue().accIndustries.length;i++){
                    industryArray.push({"class": "optionClass", label: res.getReturnValue().accIndustries[i], value: res.getReturnValue().accIndustries[i]});
                }
                if(inputIndustry !== undefined){
                    inputIndustry.set("v.options", industryArray);    
                }
                
                component.set("v.showIndustry", "false"); 
                component.set("v.industryArray", industryArray);
                
                //Assign value of Account source picklist value
                var accountSource = component.find("InputSourceType");
                var accSourceArray=[];
                accSourceArray.push({class: "optionClass",label: "--- None ---",value: ""
                                    });
                for(var i=0;i< res.getReturnValue().accSources.length;i++){
                    accSourceArray.push({"class": "optionClass", label: res.getReturnValue().accSources[i], value: res.getReturnValue().accSources[i]});
                }
                if(accountSource !== undefined){
                    accountSource.set("v.options", accSourceArray);    
                }
                
                component.set("v.showSource", "false");
                component.set("v.sourceArray", accSourceArray);
                
                //Assign value of Account that are not allowed to update.
                var inactiveAccountsList = res.getReturnValue().inactiveAccounts;
                var inactiveAccMap = [];
                for(var key in inactiveAccountsList){
                    inactiveAccMap.push({key:key, value:inactiveAccountsList[key]});
                }
                console.log('test inactiveAccMap is ', inactiveAccMap);
                component.set("v.inactiveAccMap", inactiveAccMap);
                
                component.set("v.spinner", false);
            }
        });
        $A.enqueueAction(action);   
        console.log('test debug 1');
    },
    
    activateAccounts: function(component, event, selectedAccounts) {
        var action = component.get("c.updateRecords");
        // pass the all selected record's Id's to apex method 
        action.setParams({
            "lstRecordId": selectedAccounts
        });
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(state);
                if (response.getReturnValue() != '') {
                    // if getting any error while updating the records , then display a alert msg/
                    alert('The following error has occurred. while Delete record-->' + response.getReturnValue());
                } else {
                    console.log('check it--> delete successful');
                }
                component.set("v.spinner", false);
                this.showToast(component, event, "success", "Success!",  'Account activated successfully');
                this.fetchAccounts(component, event);
            }
        });
        $A.enqueueAction(action);
    },
    
    filterAccounts : function(component, event, helper) {
        var type,industry = null,source = null;
        
        var typeComp = component.find("InputAccountType");
        type = typeComp.get("v.value");
        if(component.get("v.showIndustry") === "true"){
            var industryComp = component.find("InputIndustryType");
            industry = industryComp.get("v.value");    
        }
        if(component.get("v.showSource") === "true"){
            var sourceComp = component.find("InputSourceType");
            source = sourceComp.get("v.value");    
        }
        
        var action = component.get("c.filterAccountList");
        action.setParams({"type" : type, "industry" : industry, "source" :source});
        action.setCallback(this, function(res) {
            var state = res.getState(); 
            if (state === "SUCCESS") {
                component.set("v.accountList", res.getReturnValue());
            }
        });
        $A.enqueueAction(action);   
    },
    
    showToast : function(component, event, mode, title, message){
        var toastEvent = $A.get("e.force:showToast");
        if(toastEvent){
            toastEvent.setParams({
                "type": mode,
                "title": title,
                "message": message
            });
            
            toastEvent.fire();    
        }
        else{
            alert(message);            
        }
        
    }
    
})