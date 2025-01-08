trigger ContactTrigger on Contact (before delete) {
ContactTriggerHandler.preventContactDeletion(Trigger.Old);
}