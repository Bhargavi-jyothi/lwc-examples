public class ContactTriggerHandler {

    public static void preventContactDeletion(List<Contact> contacts){
        Set<Id> conIds = new Set<Id>();
        for(Contact c : contacts){
            conIds.add(c.Id);
        }
        List<AggregateResult> coOp = [SELECT ContactId,Count(OpportunityId) totalcount FROM OpportunityContactRole WHERE ContactId IN:conIds GROUP BY ContactID];
        Map<Id ,Integer> coOpcountMap = new Map<Id ,Integer>();
        for(AggregateResult ar : coOp){
            coOpcountMap.put((Id) ar.get('ContactId'),(Integer) ar.get('totalcount'));
        }
        
        for(Contact c : contacts){
            if( coOpCountMap!=null && coOpCountMap.get(c.Id)>0){
                c.addError('Cannot delete contact if it has any related opportunities');
            }
        }
    }
    
}