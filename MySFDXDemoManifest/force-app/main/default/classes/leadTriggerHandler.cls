//Generated for Decodeforce programming test
public class leadTriggerHandler{

	public static void beforeInsert(){

		List<Lead> newLeads = Trigger.new;
         List<Lead> leadList = new List<Lead>();
		/* Write your logic below */
        for(Lead leads : newLeads){
            if(leads.company == null){
                 leads.company='TBA';
                 leadList.add (leads);
            }
        }
        if(!leadList.isEmpty()){
            insert  leadList;
        }
	
	}
}