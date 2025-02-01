@IsTest
public class LeadProcessorTest {

    @testSetup
    static void setup() {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 1; i <= 200; i++) {
            leadList.add(new Lead(LastName = 'lead ' + i, Company = 'Farmers Coop. of Florida', Status = 'Open - Not Contacted'));
        }
        insert leadList;        
    }

    @IsTest
    static void test() {
        List<Lead> leadList = [SELECT Id FROM Lead WHERE Status = 'Open - Not Contacted'];
        Test.startTest();
        Database.executeBatch(new LeadProcessor(leadList));
        Test.stopTest();
    }
}