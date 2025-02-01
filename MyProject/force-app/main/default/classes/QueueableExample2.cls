public class QueueableExample2 implements Queueable {
    Map<Id,String> acMap = new Map<Id,String>();
    
    public QueueableExample2(Map<Id,String> acMap){
        this.acMap = acMap;
    }
     public void execute(QueueableContext qc){
         List<Opportunity> opp = new List<Opportunity>();
         for(Opportunity o:[SELECT Id, Description, AccountId FROM Opportunity WHERE AccountID IN : acMAp.keySet()]){
             o.Description =acMap.get(o.AccountId);
             opp.add(o);
         }
         if(!opp.isEmpty()){
             UPDATE opp;
         }
     }

}