global class BatchClass implements Database.Batchable<Account> {
    
    global Iterable<Account> start(Database.BatchableContext bc){
        return new CustomIterable();
    }
    
    global void execute(Database.BatchableContext bc ,List<Account> scope){
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : scope){
            acc.NumberofLocations__c=2;
            accountsToUpdate.add(acc);
        }
        update scope;
        System.debug('Updated accounts : '+scope);
    }
    global void finish(Database.BatchableContext bc){
        
    }
}