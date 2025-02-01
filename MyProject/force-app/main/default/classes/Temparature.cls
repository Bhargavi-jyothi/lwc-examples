public class Temparature {
    public static Decimal tempChange(Decimal fh){
        Decimal result = (fh-32)*5/9;
        return result.setScale(2);
    }

}