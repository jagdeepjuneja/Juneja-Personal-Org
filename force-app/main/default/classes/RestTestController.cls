@RestResource(urlMapping='/test/test_rest_api/*')
global class RestTestController {
    @HttpPost
    global static void getTestAccount() {
 
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        String accountName = req.params.get('account_name');
 
// No account_name parameter was found; return status 400
        if(accountName == null) {
            res.statusCode = 400;
            jsonResponse = '{"response": {"status": "Failure", "message": "MissingRequiredQueryParameter account_name"}}';
            res.responseBody = blob.valueOf(jsonResponse);
            return;
        }
 
// Get the list of accounts that match the account_name sent in the request.
        List<Account> accounts = [SELECT Id, Name, Phone, Fax, Website
                                  FROM Account
                                  WHERE Name =: accountName];
 
// No accounts with matching account_name
        if( accounts.isEmpty()) {
            res.statusCode = 400;
            jsonResponse = '{"response": {"status": "Failure", "message": "No account matching account_name was found"}}';
            res.responseBody = blob.valueOf(jsonResponse);
            return;
        }
 
// At least 1 account was found, JSON serialize it and send it back.
        try {
            res.statusCode = 200;
            jsonResponse = Json.serialize(accounts[0]);
            res.responseBody = blob.valueOf(jsonResponse);
            return;
        } catch ( Exception ex ) {
            res.statusCode = 500;
            jsonResponse = '{"response": {"status": "Failure", "message": "' + ex + '"}}';
            res.responseBody = blob.valueOf(jsonResponse);
            return;
        }
    }
}