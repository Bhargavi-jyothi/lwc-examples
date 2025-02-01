public class ContactTriggerHandler {
    public static void updateNoOfContacts(List<Contact> contact , List<Contact>oldContact){
        Set<Id> acIds = new Set<Id>();
        for(Contact c : contact){
            if(c.AccountId != null){
                acIds.add(c.AccountId);
            }
        }
        if (oldContact != null) {
            for(Contact c : oldcontact){
                if(c.AccountId != null){
                    acIds.add(c.AccountId);
                }
            }
        }
        Map<Id, Integer> accConCount = new Map<Id, Integer>();
        for(AggregateResult ar : [SELECT AccountId, COUNT(Id) totalcount FROM Contact WHERE AccountId IN :acIds GROUP BY AccountId]){
            accConCount.put((Id)ar.get('AccountId'), (Integer)ar.get('totalcount'));
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        List<Account>oldAccountUpdate = new List<Account>();
        for(Id accId : accConCount.keySet()){
            Account acc = new Account();
            acc.Id = accId; 
            acc.Number_Of_Contacts_To_Be_Create__c = accConCount.get(accId);
            System.debug('Updating Account ID: ' + accId + ' with number_of_contacts__c: ' + accConCount.get(accId));
            accountsToUpdate.add(acc);
            oldAccountUpdate.add(acc);
        }
        
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
        if(!oldAccountUpdate.isEmpty()){
            update oldAccountUpdate ;
        }
 
        
    }
}