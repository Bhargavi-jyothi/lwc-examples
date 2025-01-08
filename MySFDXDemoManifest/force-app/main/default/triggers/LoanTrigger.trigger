trigger LoanTrigger on Loan__c (before insert,before update) {
       
    if(Trigger.isInsert){
          LoanTriggerHandler.validateLoanRecord(Trigger.New);
    }
    else if(Trigger.isUpdate){
     
          LoanTriggerHandler.validateLoanRecord(Trigger.New);
    }
}