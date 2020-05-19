//https://www.salesforcetutorial.com/dynamic-approval-process-salesforce/
public class OpportunityApprovalMatrix{
  
    public static void ApprovalMatrixMatch(Set<Id> OpportunitySet){
      
        List<Opportunity> updatedOpptyList = new List<Opportunity>();
        List<Id> OpptyIds = new List<Id>();
        
        for(Opportunity opptyRec :[SELECT Id,Name,Approver1__c FROM Opportunity where Id IN:OpportunitySet]){
            opptyRec.Approver1__c = UserInfo.getUserId();
            updatedOpptyList.add(opptyRec);
            OpptyIds.add(opptyRec.Id);
        }
        
        update updatedOpptyList;
        
        list<Approval.ProcessSubmitRequest> submitRequestList = new list<Approval.ProcessSubmitRequest>();
        for(Id oppId: OpptyIds){
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitting request for approval.');
            req.setObjectId(oppId);
            submitRequestList.add(req);
        }
        Approval.process(submitRequestList);
    }
}