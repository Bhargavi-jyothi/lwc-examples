trigger AccountTrigger on Account (before insert, after insert , after update) {
    
    if (Trigger.isBefore){
        
        if(Trigger.isInsert) {
            System.debug('Before Insert Trigger executed');
            AccountTriggerHandler.setRating(Trigger.New);
        }
    }
    
    else if (Trigger.isAfter){
        
        if(Trigger.isInsert) {
            System.debug('After Insert Trigger executed');
            AccountTriggerHandler.createOpp(Trigger.New);
        }
        else if(Trigger.isUpdate){
            System.debug('After Update Trigger executed');
            AccountTriggerHandler.updateOpportunity(Trigger.New);
        }
    }
    
}