public class CaseTriggerHandler {
    
    // send email
    public static void sendCaseEmail(List<Case> cases) {
        Set<Id> accountIds = new Set<Id>();
        for (Case c : cases) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
        
        System.debug('Account IDs: ' + accountIds);
        List<Account> accounts = [SELECT Id, Email__c FROM Account WHERE Id IN :accountIds];
        Map<Id, String> accountEmailMap = new Map<Id, String>();
        for (Account acc : accounts) {
            accountEmailMap.put(acc.Id, acc.Email__c);
        }
        System.debug('Email addresses: ' + accountEmailMap);
        for (Case c : cases) {
            if (c.AccountId != null && accountEmailMap.containsKey(c.AccountId)) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { accountEmailMap.get(c.AccountId) });
                email.setSubject('New Case Created');
                email.setPlainTextBody('A new case has been created for your account: ' + c.CaseNumber);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                System.debug('Email sent to: ' + accountEmailMap.get(c.AccountId));
            } else {
                System.debug('No email address found for Account ID: ' + c.AccountId);
            }
        }
    }
    
    // prevent parent case status to be changed to closed if it has any open child cases
    
    public static void preventStatusChange(List<Case> cases , Map<Id,Case> oldCaseMap){
        Set<Id> parentIds = new Set<Id>();
        for(Case c : cases){
            if(c.Status != oldCaseMap.get(c.Id).Status && c.Status == 'Closed'){
                parentIds.add(c.Id);
            }
        }  
        System.debug('parentId ' +parentIds);
        
        List<AggregateResult> openChildCases = [SELECT  ParentId , Count(Status) totalcount FROM CASE WHERE ParentID IN :parentIds  AND Status !='Closed' GROUP BY  ParentId];
        System.debug('open child cases ' +openChildCases);
        Map<Id, Integer> casesCountMap = new Map<Id, Integer>();
        for (AggregateResult ar : openChildCases) {
            casesCountMap.put((Id)ar.get('ParentId'), (Integer)ar.get('totalcount'));
        }
        System.debug('open cases count ' +casesCountMap);
        for (Case c : cases) {
            if (casesCountMap.containsKey(c.Id) &&casesCountMap.get(c.Id) > 0) {
                c.addError('Parent Case status cannot be changed to close if it has any open child cases');
            }
        }
        
    }
    
    // automatically update the parent case status to closed if all of its child case status are updated to closed
    
    public static void updateParentStatus(List<Case> cases,Map<Id,Case> caseOldMap){
        Set<Id> parentId = new Set<Id>();
        for(Case childCase : cases){
            if(childCase.ParentId != null && childCase.Status != caseOldMap.get(childCase.Id).Status ){
                parentId.add(childCase.parentId);
            }
        }
        Map<Id, List<Case>> parentChildMap = new  Map<Id, List<Case>> ();
        List<Case>parentCases = [SELECT ID ,(SELECT ID ,Status FROM CASES) FROM CASE WHERE ID IN :parentID];
        for(Case c: parentCases){
            parentChildMap.put(c.Id ,c.Cases);
        }
        List<Case> caseToUpdate = new List<Case>();
        for(Id parentIds :parentChildMap.keySet()){
            Boolean allClosed = true;
            List<Case>childCases = parentChildMap.get(parentIds);
            for(Case child : childCases){
                if(child.status !='Closed'){
                    allClosed = false;
                    break;
                }
            }
            
            if(allClosed){
                caseToUpdate.add(new Case(Id =parentIds ,Status ='Closed'));
            }
        }
        if(!caseToUpdate.isEmpty()){
            UPDATE caseToUpdate;
        }
    }
    
    public static void updateParentStatuses(List<Case> cases){
        Set<Id> parentIdSet = new Set<Id>();
        for(Case childCase : cases){
            if(childCase.ParentId != null ){
                parentIdSet.add(childCase.parentId);
            }
        }
        // Map to store the total number of child cases for each parent case
        Map<Id, Integer> totalChildCasesMap = new Map<Id, Integer>();
        // Map to store the number of closed child cases for each parent case
        Map<Id, Integer> closedChildCasesMap = new Map<Id, Integer>();
        
        // Query child cases for the collected parent case IDs
        for (Case childCase : [SELECT Id, Status, ParentId FROM Case WHERE ParentId IN :parentIdSet]) {
            if (!totalChildCasesMap.containsKey(childCase.ParentId)) {
                totalChildCasesMap.put(childCase.ParentId, 0);
                closedChildCasesMap.put(childCase.ParentId, 0);
            }
            totalChildCasesMap.put(childCase.ParentId, totalChildCasesMap.get(childCase.ParentId) + 1);
            if (childCase.Status == 'Closed') {
                closedChildCasesMap.put(childCase.ParentId, closedChildCasesMap.get(childCase.ParentId) + 1);
            }
        }
        
        // List to store parent cases that need to be updated
        List<Case> casesToUpdate = new List<Case>();
        
        // Check if all child cases are closed
        for (Id parentId : parentIdSet) {
            if (totalChildCasesMap.get(parentId) == closedChildCasesMap.get(parentId)) {
                Case parentCase = new Case(Id = parentId, Status = 'Closed');
                casesToUpdate.add(parentCase);
            }
        }
        
        // Update parent cases
        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }
    
        
        
        
}