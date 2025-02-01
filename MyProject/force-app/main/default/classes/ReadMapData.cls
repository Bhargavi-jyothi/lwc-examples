public with sharing class ReadMapData {
    public ReadMapData() {

    }

    @AuraEnabled(cacheable=true)
    public static  Map<String,String> getMapData(){
       
        Map<String,String> mapData= new Map<String,String>();
        mapData.put('Item 1' ,'Laptop');
        mapData.put('Item 2','Phone');
        mapData.put('Item 3','Tablet');
        return mapData;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String,List<String>> getAccounts(){
        Map<String,List<String>> listMapData = new  Map<String,List<String>>();
        listMapData.put('Key 1',new List<String>{'Store 1',' Store 2'});
        listMapData.put('Key 2',new List<String>{'Store 3',' Store 4'});
        return listMapData;
    }
}