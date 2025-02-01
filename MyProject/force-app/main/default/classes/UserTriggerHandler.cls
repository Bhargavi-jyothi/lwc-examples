public class UserTriggerHandler {
    public static void userInsertion(List<User> users){
        Set<Id> userIds = new Set<Id>();
        Profile salesProfile = [SELECT ID FROM Profile WHERE Name ='Custom: Sales Profile'];
        for(User usr : users){
            if(usr.ProfileId == salesProfile.Id){
                userIds.add(usr.Id);
            }
        }
        if(!userIds.isEmpty()){
            permissionSetAssignment(userIds);
        }
    }
    
    @Future
    
    public static void permissionSetAssignment(Set<Id> userIds){
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name='Sales_User_Permissions'];
        List<PermissionSetAssignment> psa = new List<PermissionSetAssignment>();
        if(ps != null){
            for(Id userId : userIds){
                psa.add(new PermissionSetAssignment(PermissionSetId = ps.Id , AssigneeId = userId));
            }
        }
        if(!psa.isEmpty()){
            insert psa;
        }
    }

}