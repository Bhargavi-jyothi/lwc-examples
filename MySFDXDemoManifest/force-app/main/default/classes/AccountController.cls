public with sharing class AccountController {
    
    public AccountController() {}

    @AuraEnabled(cacheable=true)
    public static List<Account> accountsData() {
        // Query the Account records
        return [SELECT Id, Name, Industry FROM Account LIMIT 10];
    }
}
