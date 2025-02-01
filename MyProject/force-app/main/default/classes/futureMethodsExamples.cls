public class futureMethodsExamples {

    public static void insertingAccount(){
        Account ac = new Account(Name='Sample Account');
        insert ac;
        System.debug('Calling user');
        insertUser();
    }
@Future
    public static void insertUser(){
        User user = new User(FirstName='john' ,LastName='jode',Email='jj@gmail.com',UserName='jodeh1467john12337@john.com',
                            Alias='jjohn', TimeZoneSidKey='Asia/Kolkata',LocaleSidKey='en_US',EmailEncodingKey='UTF-8',
                            ProfileId =[SELECT Id FROM Profile WHERE Name='Chatter Free User' LIMIT 1].Id,LanguageLocaleKey='en_US');
      
        insert user;
       
        
    }
    @Future
    public static void deleteGroups(){
        Group groupToDelete =[SELECT Id FROM Group WHERE Name='SFDC'];
        delete  groupToDelete;
        
    }
    public static void insertOpportunity(){
        Opportunity opp =new Opportunity(Name='Opp1',StageName='ClosedWon',CloseDate=Date.today()+30);
        insert opp;
        deleteGroups();
       
    }
    
    @Future
    public static void updateUser(Id userId){
        User userToUpdate =[SELECT Id,Title FROM User WHERE Id =:userId];
        userToUpdate.Title ='SFDC Developer';
        update userToUpdate;
     
    }
    public static void deleteCase(Id userId ,Id caseId){
        Case caseToDelete =[SELECT Id FROM Case WHERE Id =:caseId];
        delete caseToDelete;
        updateUser(userId);
    }
    
   @Future
    public static void insertingRoles(){
        UserRole newRole = new UserRole(Name ='CEO');
        insert newRole;
       
    }
    public static void updateAccount(Id AccountId){
        Account accToUpdate = [SELECT Id ,Name FROM Account WHERE Id=:AccountId];
        accToUpdate.Name='SFDC';
        update accToUpdate;
        insertingRoles();    
     }
    
    @Future(callout = true)
    
public static void externalCode(String apiUrl) {
    
    try {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiUrl); 
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            String responseBody = response.getBody();
            System.debug('Response from external service: ' + responseBody);
            
        } else {
            System.debug('Error ' + response.getStatusCode() + '.....' + response.getStatus());
        }
        
    } catch (Exception e) {
        
        System.debug('Exception: ' + e.getMessage());
    }
  
}
    
    @Future(callout=true)
public static void externalPostCode(String apiUrl, String jsonPayLoad) {
    try {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint(apiUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(jsonPayLoad);
        
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 201 || response.getStatusCode() == 200) {
            String responseBody = response.getBody();
            System.debug('Response from external service ====> ' + responseBody);
        } else {
            System.debug('Errors ===> ' + response.getStatusCode() + ' ===> ' + response.getStatus());
        }
    } catch (Exception e) {
        System.debug('Exception =====> ' + e.getMessage());
    }
}


}