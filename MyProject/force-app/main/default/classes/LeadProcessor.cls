global class LeadProcessor implements Database.Batchable<sobject> {
    public Integer recordsProcessed = 0;
    
    List<Lead> leadList = new List<Lead>();
    public LeadProcessor(List<Lead> leadList){
        this.leadList = leadList;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT ID,Name,LeadSource FROM Lead';
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead l : scope){
            l.LeadSource = 'Dreamforce';
        }
        update scope;
        recordsProcessed = recordsProcessed+1;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Records Processed = ' +recordsProcessed);
        AsyncApexJob job = [SELECT Id,Status,NumberOfErrors FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        System.debug('Execution finished');
    }
}