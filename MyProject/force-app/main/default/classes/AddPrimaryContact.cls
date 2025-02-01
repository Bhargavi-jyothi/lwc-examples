public class AddPrimaryContact  implements Queueable{
    public Contact con;
    public String state;
    public AddPrimaryContact (Contact con,String state){
        this.con = con;
        this.state= state;
        
    }
    public void execute (QueueableContext qc){
        List<Contact>contacts = new List<Contact>();
        for(Account ac :[SELECT ID,BillingState FROM Account WHERE BillingState=:state LIMIT 200]){
           Contact newContact = con.clone(false,false,false,false) ;
           newContact.AccountId = ac.Id;
           contacts.add(newContact);
        }
        if(!contacts.isEmpty()){
            INSERT contacts;
        }
        
    }

}


/*Preserve Id: The first false indicates that the Id of the original contact should not be copied to the new Contact object.
IsDeepClone: The second false means that the clone operation should not be a deep clone. A deep clone would copy all related records as well.
PreserveReadonlyTimestamps: The third false specifies that the system fields like CreatedDate and LastModifiedDate should not be copied to the new Contact.
PreserveAutonumber: The fourth false indicates that any auto-number fields should not be copied to the new Contact.*/