public class AccountTriggerHandler {
    // method to set rating as 'Hot' if the industry is not null and equal to media.
    public static void setRating(List<Account> account){
       System.debug('Hi..') ;
        for(Account ac : account){
            if(ac.Industry != null && ac.Industry =='Media'){
                ac.Rating = 'Hot';
            }
        }
    }
    
    // create a related opportunity when an account is created with industry as energy and type as prospect
    
    public static void createOpp(List<Account> account){
        List<Opportunity> opp  = new List<Opportunity>();
        for(Account ac : account){
            if(ac.Industry =='Energy' && ac.Type =='Prospect'){
                opp.add(new Opportunity(Name = ac.Name+'Opp' , AccountId =ac.Id ,StageName='Prospecting' ,CloseDate=System.today()));
            }
        }
        if(!opp.isEmpty()){
            INSERT opp;
        }
        
    }
    //Write a trigger on the Account when the Account is updated check all opportunities related to the account.
    // Update all Opportunities Stage to close lost if an opportunity close date is less than 30 days from today
    // and stage not equal to close won.
    
    public static void updateOpportunity(List<Account> account){
        Set<Id> acId = new Set<Id>();
        for(Account ac : account){
            acId.add(ac.Id);
        }
        List<Opportunity> oppList = new List<Opportunity>();
        for(Opportunity opp :[SELECT Id, AccountId, StageName,CreatedDate,CloseDate FROM Opportunity WHERE AccountId IN :acId]){
            if(opp.CloseDate < Date.today()-30 && opp.StageName != 'Closed'){
                opp.StageName ='Closed Lost';
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty()){
            UPDATE oppList;
        }
    }
 
}