trigger OpportunityTrigger on Opportunity (after update) {
   
OpportunityTriggerHandler.opportunityUpdate(Trigger.New,Trigger.OldMap);
OpportunityTriggerHandler.updateTaskAndAssignPermissionSet(Trigger.New,Trigger.OldMap);
}