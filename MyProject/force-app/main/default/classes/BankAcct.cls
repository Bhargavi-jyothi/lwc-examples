public class BankAcct {

    private Integer balance =0;
    public  String acctName;
    public String acctType;
    
    public void makeDeposit(integer deposit){
        balance += deposit;
    }
    
    public integer getBalance(){
        return balance;
    }
}