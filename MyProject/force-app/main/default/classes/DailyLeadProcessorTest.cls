@isTest
public class DailyLeadProcessorTest {
    
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'Test' + i, Company = 'TestCompany' + i, LeadSource = null));
        }
        insert leads;
    }
    
    @isTest
    static void testDailyLeadProcessor() {
        // Delete any existing scheduled jobs with the same name
        List<CronTrigger> cronTriggers = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name LIKE 'Test_DailyLeadProcessor%'];
        for (CronTrigger ct : cronTriggers) {
            System.abortJob(ct.Id);
        }
        
        // Use a unique job name to avoid conflicts
        String uniqueJobName = 'Test_DailyLeadProcessor_' + System.currentTimeMillis();
        
        // Schedule the DailyLeadProcessor to run
        String cronExp = '0 0 0 * * ?';
        String jobId = System.schedule(uniqueJobName, cronExp, new DailyLeadProcessor());
        
        // Execute the scheduled job
        Test.startTest();
        System.schedule(uniqueJobName, cronExp, new DailyLeadProcessor());
        Test.stopTest();
        
        // Verify that all Lead records were updated correctly
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'All 200 leads should be updated to Dreamforce');
    }
}