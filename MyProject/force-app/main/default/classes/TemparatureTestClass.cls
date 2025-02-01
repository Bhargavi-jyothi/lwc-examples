@isTest
public class TemparatureTestClass {
  @isTest
    private static void warmTempTest(){
        Decimal res = Temparature.tempChange(70);
        System.assertEquals(21.11,res);
    }
}