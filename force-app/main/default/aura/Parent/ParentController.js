({
    doInit : function(component, event, helper) {
        component.set("v.spinner", true);
        helper.fetchAccounts(component, event);
    },
    
    handleSelectAllAccounts: function(component, event, helper) {
        var getID = component.get("v.accountList");
        var checkvalue = component.find("selectAll").get("v.value");        
        var checkAccount = component.find("checkAccount"); 
        if(checkvalue == true){
            for(var i=0; i<checkAccount.length; i++){
                checkAccount[i].set("v.value",true);
            }
        }
        else{ 
            for(var i=0; i<checkAccount.length; i++){
                checkAccount[i].set("v.value",false);
            }
        }
    },
    //Process the selected contacts
    activateAccounts: function(component, event, helper) {
        var selectedAccounts = [];
        var checkvalue = component.find("checkAccount");
        var theMap = component.get("v.theMap");
        var activateAccount = true;
        
        if(!Array.isArray(checkvalue)){
            if (checkvalue.get("v.value") == true) {
                Object.keys(theMap).forEach(function(key) {
                    if(theMap[key].key === checkvalue.get("v.text")){
                        //alert('You can not update '+theMap[key].value);
                        //alert('first');
                        helper.showToast(component, event, "error", "Error!", 'You can not update '+ theMap[key].value);
                        activateAccount = false;
                    }
                });
                
                selectedAccounts.push(checkvalue.get("v.text"));
            }
        }else{
            for (var i = 0; i < checkvalue.length; i++) {
                if (checkvalue[i].get("v.value") == true) {
                    Object.keys(theMap).forEach(function(key) {
                        if(theMap[key].key === checkvalue[i].get("v.text")){
                            //alert('You can not update '+theMap[key].value);
                            //alert('second');
                            helper.showToast(component, event, "error", "Error!", 'You can not update '+ theMap[key].value);
                            activateAccount = false;
                        }
                    });
                    selectedAccounts.push(checkvalue[i].get("v.text"));
                }
            }
        }
        console.log('selectedAccounts-' + selectedAccounts);
        if(selectedAccounts.length ===0){
            helper.showToast(component, event, "error", "Error!", 'Please select atleast one account');
        }
        
        if(activateAccount && selectedAccounts.length !==0){
            component.set("v.spinner", true);
            helper.activateAccounts(component, event, selectedAccounts);
        }
    },
    
    onAccTypePicklistChange: function(component, event, helper) {
        //get the value of select option
        var selectedType = component.find("InputAccountType");
        //alert(selectedType.get("v.value"));
        if(selectedType.get("v.value") === 'Customer - Direct'){
            component.set("v.showIndustry", "true");
            component.set("v.showSource", "false");
            
            var inputIndustry = component.find("InputIndustryType");
            inputIndustry.set("v.options", component.get("v.industryArray"));
        }
        else if(selectedType.get("v.value") !== 'Customer - Direct' && selectedType.get("v.value") !== ''){
            component.set("v.showIndustry", "false");
            component.set("v.showSource", "true");
            
            var sourceType = component.find("InputSourceType");
            sourceType.set("v.options", component.get("v.sourceArray"));
        }
            else if(selectedType.get("v.value") === ''){
                component.set("v.showIndustry", "false");
                component.set("v.showSource", "false");
                component.set("v.showResetButton", "false");
                component.set("v.showFilterButton", "false");
            }
    },
    
    onIndustryPicklistChange: function(component, event, helper) {
        //get the value of select option
        var selectedIndustry = component.find("InputIndustryType");
        //alert(selectedIndustry.get("v.value"));
        if(selectedIndustry.get("v.value") !== ''){
            component.set("v.showFilterButton", "true");
            component.set("v.showResetButton", "true");
        }
        else{
            component.set("v.showFilterButton", "false");
            var selectedType = component.find("InputAccountType");
            if(selectedType.get("v.value") === ''){
                component.set("v.showResetButton", "false");
            }
            
        }
    },
    
    onSourcePicklistChange: function(component, event, helper) {
        //get the value of select option
        var selectedSource = component.find("InputSourceType");
        //alert(selectedSource.get("v.value"));
        if(selectedSource.get("v.value") !== ''){
            component.set("v.showFilterButton", "true");
            component.set("v.showResetButton", "true");
        }
        else{
            component.set("v.showFilterButton", "false");
            var selectedType = component.find("InputAccountType");
            if(selectedType.get("v.value") === ''){
                component.set("v.showResetButton", "false");
            }
        }
    },
    
    filterAccounts : function(component, event, helper) {
        helper.filterAccounts(component, event, helper);
    },
    
    resetFilters : function(component, event, helper) {
        var selectedType = component.find("InputAccountType");
        selectedType.set("v.value", '');
        
        
        component.set("v.showResetButton", "false");
        component.set("v.showFilterButton", "false");
        
        
        if(component.get("v.showIndustry") === "true"){
            var InputIndustryType = component.find("InputIndustryType");
            InputIndustryType.set("v.value", '');
            //component.set("v.showIndustry", "false");
        }
        
        
        if(component.get("v.showSource") === "true"){
            var InputSourceType = component.find("InputSourceType");
            InputSourceType.set("v.value", '');
            //component.set("v.showSource", "false");
        }
        helper.fetchAccounts(component, event);
    },
    
})