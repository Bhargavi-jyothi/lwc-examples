public class Practice {
    public static List<Integer> evenNumbers(Integer n) {
    List<Integer> evenNumbers = new List<Integer>();
    Integer count=0;
    Integer i=1;
        while(count==n){
            if(Math.mod(i,2)==0){
                evenNumbers.add(i);
                
                count++;
            }
            i++;
        }
    System.debug(evenNumbers);
    return evenNumbers;
    }
}