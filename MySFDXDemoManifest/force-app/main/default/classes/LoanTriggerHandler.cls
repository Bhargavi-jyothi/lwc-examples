public class LoanTriggerHandler {
    public static void validateLoanRecord(List<Loan__c> loanList) {
        Set<Id> customerIds = new Set<Id>();
        
        for (Loan__c loan : loanList) {
            if (loan.Bank_Customer__c != null) {
                customerIds.add(loan.Bank_Customer__c);
            }
        }
        
        if (!customerIds.isEmpty()) {
            Map<Id, Loan__c> existingLoans = new Map<Id, Loan__c>();
            for (Loan__c l : [SELECT Bank_Customer__c FROM Loan__c WHERE Bank_Customer__c IN :customerIds AND Loan_Status__c = 'Pending Approval']) {
                existingLoans.put(l.Bank_Customer__c, l);
            }
            
            for (Loan__c loan : loanList) {
                if (existingLoans.containsKey(loan.Bank_Customer__c) && loan.Loan_Status__c == 'Pending Approval') {
                    System.debug('Validation Error: Customer already has a loan with Pending Approval');
                    loan.addError('This customer already has a loan with Pending Approval');
                }
            }
        }
    }
   
    
}