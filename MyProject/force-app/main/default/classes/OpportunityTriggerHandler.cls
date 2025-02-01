public class OpportunityTriggerHandler {
    
    public static void opportunityUpdate(List<Opportunity> oppList, Map<Id,Opportunity> oppMap){
        Set<Id> oppIds = new Set<Id>();
        for(Opportunity opp: oppList){
            if(opp.AccountId!=null && opp.StageName=='Closed Won' && opp.StageName!=oppMap.get(opp.Id).StageName){
                oppIds.add(opp.Id);
            }
        }
        sendEmailsMethod(oppIds);
        
    }
    @Future
    public static void sendEmailsMethod(Set<Id> oppId){
        List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
        for(Opportunity opp :[SELECT Id,Name,StageName,Account.Owner.Name,Account.Email__c,Account.Name FROM Opportunity  WHERE ID IN:oppId]){
            if(opp.Account.Email__c !=null){
              List<String> toAddress = new List<String>();
              toAddress.add(opp.Account.Email__c);
              Messaging.SingleEmailMessage  email = new Messaging.SingleEmailMessage();
              email.setToAddresses(toAddress);
              email.setSubject('Opportunity update');
              email.setPlainTextBody('Dear '+opp.Account.Owner.Name+ ',An Opportunity with Name '+ opp.Name + ' which is linked to the Account  '+opp.Account.Name +' is closed');
              allMails.add(email);
            }
        }
        if(!allMails.isEmpty()){
           Messaging.sendEmail(allMails);
        }
    }
    
    public static void updateTaskAndAssignPermissionSet(List<Opportunity> oppList ,Map<Id,Opportunity> oldMap){
        List<Task> tasks = new List<Task>();
        List<Id> userIds = new List<Id>();
        for(Opportunity opp: oppList){
            if(opp.StageName =='Closed Won' && opp.StageName != oldMap.get(opp.Id).StageName){
               tasks.add(new Task(Subject='Follow up task', WhatId=opp.Id,OwnerId= opp.OwnerId));
               userIds.add(opp.OwnerId);
            }
        }
        
        insert tasks;
        permissionSetAssignment(userIds);
       
    }
@Future
    public static void permissionSetAssignment(List<Id> userIds){
        List<PermissionSetAssignment> permissionSets = new List<PermissionSetAssignment>();
        PermissionSet ps =[SELECT ID FROM PermissionSet WHERE NAME ='CMM_PermissionSet'];
        for(Id userId: userIds){
        permissionSets.add(new PermissionSetAssignment(AssigneeId =userId, PermissionSetId = ps.Id));
         }
         insert permissionSets;  
    
}
    
}