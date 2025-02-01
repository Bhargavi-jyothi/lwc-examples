global class BatchUserDeactivation implements Database.Batchable<sobject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        Date thirtyDaysAgo = Date.today().addDays(-30);

         String query ='SELECT Id,Name,LastLoginDate FROM User WHERE LastLoginDate <:thirtyDaysAgo AND isActive =true';
         return Database.getQueryLocator(query);
                             

    }
    global void execute(Database.BatchableContext bc,List<User> scope){
        for(User users : scope){
            users.isActive =False;
            System.debug('User updated '+ users);
        }
        update scope;
        
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Execution finished');
    }

}