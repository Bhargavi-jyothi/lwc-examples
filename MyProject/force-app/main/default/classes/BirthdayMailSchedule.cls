public class BirthdayMailSchedule implements Schedulable {
    
    public void execute(SchedulableContext sc){
        Database.executeBatch(new BirthdayMailBatch());
    }

}