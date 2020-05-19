({
    onClick: function (component, event, helper) {
        var navService = component.find("navService");
        // Sets the route to /lightning/o/Account/home
        var pageReference = {
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'home'
            }
        };
        event.preventDefault();
        navService.navigate(pageReference);
    }
    
    
})