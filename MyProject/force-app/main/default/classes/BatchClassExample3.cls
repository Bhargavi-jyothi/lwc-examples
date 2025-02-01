global class BatchClassExample3 implements Database.Batchable<sobject> {
    Set<Id> acId = new Set<Id>();
    
    
    public BatchClassExample3(Set<Id> acId){
        this.acId = acId;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query ='SELECT Id,AnnualRevenue FROM Account WHERE Id IN:acId';
        return Database.getQueryLocator(query);
    }
    
    global void execute (Database.BatchableContext bc,List<Account> scope){
        for(Account ac : scope){
            if(ac.AnnualRevenue == null){
                ac.AnnualRevenue = 50;
            }
            else{
                ac.AnnualRevenue += 50;
            }
        }
        update scope;
        System.debug('Updated accounts '+scope);
        
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Execution finsihed');
    }
}