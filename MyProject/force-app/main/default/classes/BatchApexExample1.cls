global class BatchApexExample1 implements Database.Batchable<sobject> {
    
    Set<Id> acIds = new Set<Id>();
    
    public  BatchApexExample1 (Set<Id> acIds){
        this.acIds = acIds;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){

        String query ='SELECT Id,Description FROM Contact WHERE AccountId IN:acIds';

        return Database.getQueryLocator(query);
    }
    
    global void execute (Database.BatchableContext bc , List<Contact> scope){

        for(Contact con : scope){

            con.Description ='Updated using Batch apex job class';
           
        }
        UPDATE scope;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Execution finished');
    }
    

}