public class OpportunityContactRoleTriggerHandler {

    
    public static void assignContactToCampaign(List<OpportunityContactRole> opc){
        Id CampaignId = '701dL00000SBa4EQAT';
        Set<Id> oppIds = new Set<Id>();
        for(OpportunityContactRole op : opc){
            oppIds.add(op.OpportunityId);
        }
       
        Map<Id ,Opportunity> opMap = new Map <Id,Opportunity>([SELECT ID,Probability FROM Opportunity WHERE ID IN : oppIds]);
        List<CampaignMember> cm = new List<CampaignMember>();
        for(OpportunityContactRole op : opc){
            if(opMap.containsKey(op.OpportunityId)){
                Opportunity o = opMap.get(op.OpportunityID);
                if(o.Probability >60){
                    cm.add(new CampaignMember(CampaignId = CampaignId, ContactId = op.ContactId, Status = 'Sent'));
                }
            }
        }
        if(!cm.isEmpty()){
            INSERT cm;
        }
    }
}