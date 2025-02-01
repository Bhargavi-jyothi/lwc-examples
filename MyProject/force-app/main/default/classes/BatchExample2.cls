global class BatchExample2  implements Database.Batchable<sobject>{
    
    List<Account> accList = new List<Account>();
    public BatchExample2 (List<Account> accList){
        this.accList = accList;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, Name, Industry, Type FROM Account WHERE Industry = \'Engineering\'';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc ,List<Account> scope){
        
        for(Account acc : scope){
            acc.Type ='Technology partner';
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Execution finished');
    }
}