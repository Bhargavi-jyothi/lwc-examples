trigger ContactTrigger on Contact (after insert , after delete , after undelete ,after update){
    if (Trigger.isAfter) {
        
        if(Trigger.isInsert){
            System.debug('Insert executed');
           // ContactTriggerHandler.insertAccounts(Trigger.New);
        }
        
        if(Trigger.isInsert ||Trigger.isUndelete){
            System.debug('Insert executed / Undelete executed');
          //  ContactTriggerHandler.updateNoOfContacts(Trigger.New,null);
        }
        
        if(Trigger.isUpdate){
            System.debug('Update executed');
            //ContactTriggerHandler.updateNoOfContacts(Trigger.New,Trigger.Old);
        }
        
        
        if (Trigger.isDelete) {
            System.debug('Delete executed');
           // ContactTriggerHandler.updateNoOfContacts(Trigger.Old,null);
        }
        
    }
    
}