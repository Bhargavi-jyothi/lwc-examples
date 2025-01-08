public with sharing class CreateAccountController {
    public CreateAccountController() {

    }
    @AuraEnabled

    public static Account createAccount(Account accountRecObj){
        try{
            insert accountRecObj;
            return accountRecObj;
        }
        catch(Exception ex){
            throw new AuraHandledException('Error creating account: ' + ex.getMessage());

        }
    }
    @AuraEnabled
    public static List<Account> createAccount(List<Account> accountList){
        insert accountList;
        return accountList;
    }
}