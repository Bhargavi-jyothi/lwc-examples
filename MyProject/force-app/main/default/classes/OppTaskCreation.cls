public class OppTaskCreation implements Schedulable {
    
    public void execute (SchedulableContext sc) {
        List<Opportunity> oppList = [SELECT Id, Name, StageName, OwnerId FROM Opportunity WHERE StageName != 'Closed Won' AND StageName = 'Closed Lost'];
        List<Task> newTasks = new List<Task>();
        
        for(Opportunity opp : oppList) {
            newTasks.add(new Task(
                OwnerId = opp.OwnerId,
                WhatId = opp.Id,
                Subject = 'Other', 
                ActivityDate = System.today() + 5,
                Description = 'Review the Opportunity'
            ));
        }
        if(!newTasks.isEmpty()){
            insert newTasks;
        }
    }
}