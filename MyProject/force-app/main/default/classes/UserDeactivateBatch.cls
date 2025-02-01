global class UserDeactivateBatch  implements Database.Batchable<sobject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query ='SELECT Name,LastLoginDate FROM USER WHERE LastLoginDate< LAST_N_MONTHS:3 AND IsActive =True';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc ,List<User> scope){
        List<User> users = new List<User>();
        for(User u : scope){
            u.IsActive =False;
            users.add(u);
        }
        update users;
        System.debug('Users deactivated' +users);
    }
    
    global void finish(Database.BatchableContext bc){
        
        List<User> deactivatedUsers =[SELECT Name,Email,LastLoginDate FROM User WHERE LastLoginDate<LAST_N_MONTHS:3 AND IsActive =False];
        
        for(User u : deactivatedUsers){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {u.Email});
            email.setSubject('Your account has been deactivated');
            email.setPlainTextBody('Dear '+u.Name+' , \n\n Your account has been deactivated due to inactivity in last 3 months.Please contact your admin to activate it \n\n Best Regards ,\n\n Birlasoft ');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
  
        }
        
    }

}