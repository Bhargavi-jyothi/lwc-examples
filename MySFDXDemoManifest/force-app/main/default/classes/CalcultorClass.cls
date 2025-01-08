public with sharing class CalcultorClass {
    @AuraEnabled
    public static Integer sumOfNumbers(Integer firstNum,Integer secondNum){
        return firstNum+secondNum;
    }
}