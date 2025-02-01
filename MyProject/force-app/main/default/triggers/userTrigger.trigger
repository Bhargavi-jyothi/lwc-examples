trigger userTrigger on User (after insert) {
UserTriggerHandler.userInsertion(Trigger.New);
}