({
    doInit : function(component, event, helper) {
        var columns = [
            {
                type: 'text',
                fieldName: 'Name',
                label: 'Account Name'
            },
            {
                type: 'number',
                fieldName: 'NumberOfEmployees',
                label: 'Employees'
            },
            {
                type: 'phone',
                fieldName: 'Phone',
                label: 'Phone Number'
            },
            {
                type: 'text',
                fieldName: 'FirstName',
                label: 'First Name'
            },
            {
                type: 'text',
                fieldName: 'LastName',
                label: 'Last Name'
            },
            {
                type: 'email',
                fieldName: 'Email',
                label: 'Email'
            },
           /* {
                type: 'text',
                fieldName: 'ParentId',
                label: 'Parent Account'
            }*/
        ];

        component.set('v.gridColumns', columns);
        var action = component.get("c.getAccountList");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS" ) {
            var mp = new Map();
                var resultData = response.getReturnValue();
                for (var i=0; i<resultData.length; i++ ) {
            //alert(JSON.stringify(resultData[i]));
            if(resultData[i].ParentId != null){
              //  alert('resultData[i].ParentId is: ' + resultData[i].ParentId);
                if(mp.get(resultData[i].ParentId) != null){
                    var c = mp.get(resultData[i].ParentId);
                    c.push(resultData[i]);
                   mp.set(resultData[i].ParentId,c);
                }
                else{
                    var arr = new Array();
                    arr.push(resultData[i]);
                    mp.set(resultData[i].ParentId,arr);
                }
            }
                  //  resultData[i]._children = resultData[i]['Contacts'];
                }
                for (var i=0; i<resultData.length; i++ ) {
    if(mp.get(resultData[i].Id) != null){
    //alert('mp is: ' + JSON.stringify(mp.get(resultData[i].Id)));

    resultData[i]._children = mp.get(resultData[i].Id);
}
                }
                component.set('v.gridData', resultData);
            }
        });
        $A.enqueueAction(action);
    }
})