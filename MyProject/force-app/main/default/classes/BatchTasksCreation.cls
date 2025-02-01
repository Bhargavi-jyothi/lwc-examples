global class BatchTasksCreation implements Database.Batchable<sobject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, OwnerId, Owner.isActive FROM Opportunity';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        List<Task> newTasks = new List<Task>();
        User adminUser = [SELECT Id, Name FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];
        
        for (Opportunity opp : scope) {
            if (opp.Owner.isActive) {
                newTasks.add(new Task(WhatId = opp.Id, OwnerId = opp.OwnerId, Subject = 'Please review the related opportunity.'));
                System.debug('Task added through Owner: ' + newTasks);
            } else {
                newTasks.add(new Task(WhatId = opp.Id, OwnerId = adminUser.Id, Subject = 'Please review the related opportunity.'));
                System.debug('Task added through User: ' + newTasks);
            }
        }
        
       insert newTasks;
          
        }
    
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch process finished.');
    }
}