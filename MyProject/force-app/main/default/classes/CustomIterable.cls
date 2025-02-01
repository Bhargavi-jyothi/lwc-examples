global class CustomIterable  implements Iterable<Account>{
     public Iterator<Account> iterator(){
         List<Account> acc = [SELECT Id,Name,NumberofLocations__c FROM Account LIMIT 10];
         return new CustomIterator(acc);
     }
}