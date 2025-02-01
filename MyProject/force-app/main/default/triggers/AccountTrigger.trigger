trigger AccountTrigger on Account (before insert,before update , before delete,after insert,after update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
           // AccountTriggerHandler.setOwnerName(Trigger.New);
           // AccountTriggerHandler.preventDupicate(Trigger.New);
           Database.executeBatch( new BatchExample2(Trigger.New));

        }
        else if(Trigger.isUpdate){
            //AccountTriggerHandler.setTotalOppAmount(Trigger.New);
        }
        else if(Trigger.isDelete){
            //AccountTriggerHandler.preventDeletion(Trigger.Old);
        }
        
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            //AccountTriggerHandler.createContact(Trigger.New);
            //AccountTriggerHandler.sendAccEmail(Trigger.New);
            // AccountTriggerHandler.sendEmail(Trigger.New);
            //AccountTriggerHandler.clientContact(Trigger.New);
           // AccountTriggerHandler.updateContacts(Trigger.NewMap.keySet());
        }
        if(Trigger.isUpdate){
             //System.enqueueJob(new QueueableExample1(Trigger.NewMap.KeySet()));
                 //Database.executeBatch( new BatchApexExample1(Trigger.NewMap.keySet()));

        }
        
    }
}