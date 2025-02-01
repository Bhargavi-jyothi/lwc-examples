trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    Set<Id> opId = new Set<Id>();
    List<Task> tasksToUpdate = new List<Task>();
    List<Task> tasksToInsert = new List<Task>();

    // Collect Opportunity IDs with StageName 'Closed Won'
    for (Opportunity op : Trigger.New) {
        if (op.StageName == 'Closed Won') {
            opId.add(op.Id);
        }
    }

    if (!opId.isEmpty()) {
        // Fetch existing tasks related to these Opportunities
        List<Task> existingTasks = [SELECT Id, WhatId, Subject FROM Task WHERE WhatId IN :opId];

        // Update existing tasks
        for (Task t : existingTasks) {
            t.Subject = 'Follow Up Test Task';
            tasksToUpdate.add(t);
        }

        // Insert new tasks if no existing tasks found
        if (existingTasks.isEmpty()) {
            for (Id id : opId) {
                Task newTask = new Task(
                    Subject = 'Follow Up Test Task',
                    WhatId = id
                );
                tasksToInsert.add(newTask);
            }
        }

        // Perform DML operations
        if (!tasksToUpdate.isEmpty()) {
            update tasksToUpdate;
        }
        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}