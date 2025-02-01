@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void setup() {
    List<Account> account1 = new List<Account>();
    for(Integer i = 0; i < 50; i++){
        Account acc = new Account(Name ='Account '+ i,BillingState ='CA');
        account1.add(acc);
    }
        insert account1;
        List<Account> account2 = new List<Account>();
    for(Integer i = 0; i < 50; i++){
        Account acc = new Account(Name ='Account '+ i,BillingState ='NY');
        account2.add(acc);
    }
        insert account2;
        
        
    }
    @isTest
    static void testPrimaryAccount(){
        Contact con = new Contact(FirstName ='Test',LastName='Contact',Email='test@gmail.com');
         Test.startTest();
        System.enqueueJob(new AddPrimaryContact(con,'CA'));
        Test.stopTest();
        List<Contact> contacts = [SELECT Id,AccountId FROM Contact WHERE Account.BillingState='CA'];
        System.assertEquals(50,contacts.size(),'50 Contact records should be inserted for CA Accounts');
    }
}