trigger CaseTrigger on Case (before update, after update) {
    
    System.debug('Trigger called');
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
           CaseTriggerHandler.preventStatusChange(Trigger.New , Trigger.OldMap);
        }
    }
    else if(Trigger.isAfter){
        if(Trigger.isUpdate){
            CaseTriggerHandler.updateParentStatuses(Trigger.New);
            
        }
    }
     
}