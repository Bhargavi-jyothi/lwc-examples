trigger OpportunityContactRoleTrigger on OpportunityContactRole (before insert , before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            OpportunityContactRoleTriggerHandler.assignContactToCampaign(Trigger.New);
        }
    }
}