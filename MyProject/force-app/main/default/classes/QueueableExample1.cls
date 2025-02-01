public class QueueableExample1 implements Queueable {
    Set<Id> acId = new Set<Id> ();
    public QueueableExample1(Set<Id> acId){
        this.acId = acId;
    }
    
    public void execute(QueueableContext qc){
        Map<Id,String> acMap = new Map<Id,String>();
        List<Contact> contact = new List<Contact>();
        for(Contact con :[SELECT Id,Description,AccountId FROM Contact WHERE AccountID IN:acId])  {
            con.Description = 'This is updated by Queueable 1';
            contact.add(con);
            acMap.put(con.AccountId,con.Description);
        }
        if(!contact.isEmpty()){
            UPDATE contact;
        }
         System.enqueueJob(new QueueableExample2(acMap));
        
    }

}