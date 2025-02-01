global class BirthdayMailBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, FirstName, LastName, Birthdate, Email FROM Contact WHERE Birthdate = TODAY';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> scope) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for (Contact c : scope) {
            if (c.Email != null) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setTargetObjectId(c.Id);
                email.setTemplateId('00XdL000007e7I5');
                email.setSaveAsActivity(false); // Note: 'false' should be lowercase
                emails.add(email);
            }
        }
        
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Emails sent');
    }
}