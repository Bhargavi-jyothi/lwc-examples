public class AccountTriggerHandler {
    
    // method to set owner name as sanjay When an account is inserted has a industry has a value Education
    

    
    public static void setOwnerName(List<Account> account){
        
        for(Account acc : account){
            if(acc.Industry == 'Education'){
                acc.OwnerId = [SELECT ID FROM User WHERE Name ='Sanjay Swami' LIMIT 1].ID;
            }
        }
        
    }
    
    // method to prevent duplicate names to be inserted into an account
    public static void preventDupicate(List<Account> account){
        Set<String> acName = new Set<String>();
        for(Account acc : account){
            acName.add(acc.Name.trim().toLowerCase());
        }
        Map<String,Account> oldAc = new Map<String, Account>();
        for (Account oldacc : [SELECT Id, Name FROM Account WHERE Name IN :acName]) {
            oldAc.put(oldacc.Name.trim().toLowerCase(), oldacc);
        }
        for(Account ac :  account){ 
            if(oldAc.containsKey(ac.Name.trim().toLowerCase())){
                ac.addError('An account with this name already exists');
                
            } 
        }     
    }
    
    // method to create a contact associated with account when ever a new account is inserted with the industry value as
    // Energy
    
    public static void createContact(List<Account> account){
        
        List<Contact> con = new List<Contact>();
        for(Account a: account){
            if(a.Industry == 'Energy'){
                con.add(new Contact(LastName ='Sanjay',AccountId=a.Id,Phone=a.Phone));
            }
        }
        if(!con.isEmpty()){
            INSERT con;
        }   
        
    }
    
    // method to prevent the deletion of accounts if the accounts have related contacts
    public static void preventDeletion(List<Account> acList){
        Set<Id> acIds = new Set<Id>();
        for(Account ac: acList){
            acIds.add(ac.Id);
        }
        Map<Id ,Contact> conMap = new Map<Id ,Contact>();
        for(Contact c: [SELECT Id ,AccountId FROM Contact WHERE AccountId IN:acIds]){
            conMap.put(c.AccountId,c);
        }
        for(Account a: acList){
            if(conMap.containsKey(a.Id)){
                a.addError('This account cannot be deleted as it has contacts associated with it');
            }
        }
    }
    
    // method to send an email when account is created if their email address is not null
    
    public static void sendAccEmail(List<Account> acc){
        for(Account a : acc){
            
            if(a.Email__c != null){        
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] {a.Email__c}) ;
                email.setSubject('New Account Crreated');
                email.setPlainTextBody('Dear user, \n\n An account with id '+ a.Id + '\n\n It is created by id  '+a.CreatedById +'\n\n Account is created with name ' +a.Name);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                
                
                
            }
        }
    }
    
    //Once an Account is inserted an email should go to the System Admin user with specified text below.
    //An account has been created and the name is “Account Name”. 
    
    public static void sendEmail(List<Account> acc){
        User userobj = [SELECT ID , Email FROM User WHERE Profile.Name ='System Administrator'];
        for(Account a : acc){
            if(userobj.Email != null){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSenderDisplayName('Salesforce');
                email.setToAddresses(new String[] {userobj.Email}) ;
                email.setSubject('A new account created');
                email.setPlainTextBody('An account has been created and the name is '+a.Name);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                
            }
        }
    }
    
    //Once an Account will update then that Account will update with the total amount from All its Opportunities on the Account Level. 
    //The account field name would be ” Total Opportunity Amount.
    
    public static void setTotalOppAmount(List<Account> account){
        Set<Id> acId = new Set<Id>();
        for(Account ac : account){
            ac.Total_Opportunity_Amount__c = 0;
            acId.add(ac.Id);
        }
        
        List<AggregateResult> opp = [SELECT AccountId,Sum(Amount) totalamount FROM Opportunity WHERE AccountID IN:acId GROUP BY AccountId];
        Map<Id,Decimal> acOpMap = new Map<Id,Decimal>();
        if(!opp.isEmpty()){
            for(AggregateResult ar : opp){
                acOpMap.put((Id) ar.get('AccountId'),(Decimal) ar.get('totalamount'));
            }
        }
        if(!acOpMap.isEmpty()){
            for(Account ac : account){
                if(acOpMap.containsKey(ac.Id)){
                    ac.Total_Opportunity_Amount__c = acOpMap.get(ac.Id);
                }
            }
        }
        
    }
    //Create a field on Account Named (Client Contact lookup to Contact). 
    //Once an Account is inserted a Contact will create with the name of the Account and that
    // Contact will be the Client Contact on the Account.
    
    public static void clientContact(List<Account> account){
        
        Set<Id> acId = new Set<Id>();
        List<Contact> conList = new List<Contact>();
        for(Account ac : account){
            Contact con = new Contact();
            con.LastName = ac.Name;
            con.AccountId = ac.Id;
            conList.add(con);
            acId.add(con.AccountId);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
        System.debug('Account Id with related contacts '+acId);
        Map<Id,Account> acMap = new Map<Id,Account>();
        for(Account a :[SELECT Id ,Client_Contact__c FROM Account WHERE Id IN :acId]){
            acMap.put(a.Id,a);
        }
        List<Account> acList = new List<Account>();
        for(Contact c : conList){
            if(acMap.containsKey(c.AccountId)){
                Account a = acMap.get(c.AccountId);
                a.Client_Contact__c = c.Id;
                acList.add(a);
            }
        }
        if(!acList.isEmpty()){
            UPDATE acList;
        }
        
        
        
    }
    
    @Future
    public static void updateContacts(Set<Id> accountId){
        List<User> userList = new List<User>();
        for(User usr :[SELECT ID,Email,Title FROM User WHERE Id =:UserInfo.getUserId()]){
            usr.Title ='SFDC';
            userList.add(usr);
        }
        if(!userList.isEmpty()){
            UPDATE userList;
        }
    }
}