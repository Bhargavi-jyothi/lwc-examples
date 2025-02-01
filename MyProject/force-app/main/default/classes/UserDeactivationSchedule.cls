public class UserDeactivationSchedule implements Schedulable {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new UserDeactivateBatch());
    }
}