global class CountUpdatedRecordsBatch implements Database.Batchable<sobject>,Database.Stateful {
    Integer pcount =0;
    Integer ncount=0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query ='SELECT Id,FirstName,LastName,Email FROM Contact WHERE Email!=null';
        return Database.getQUeryLocator(query);
    }
    global void execute(Database.BatchableContext bc ,List<Contact> scope){
        for(Contact con : scope){
            try{
            con.Email ='updated'+con.Email;
            update con;
            pcount++;
            }
            catch(Exception e){
                ncount++;
            }
       
        
    }
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Total records processed '+pcount+' Total records not processed '+ncount);
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String []{'jyothigarapati55@gmail.com'});
        email.setSubject('Batch process completed ');
        email.setPlainTextBody('Total records processed ' +pcount+' Total records not processed '+ncount);
        Messaging.sendEmail(new Messaging.singleEmailMessage[]{email});
    }

}