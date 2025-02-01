global class CustomIterator implements Iterator<Account> {
    
  List<Account> acc = new List<Account>();
  Integer index = 0;
    
    public CustomIterator(List<Account> acc){
        this.acc = acc;
        index = 0;
    }
    public boolean hasNext(){
        return index < acc.size();
        
    }
    
    public Account next(){
        if(hasNext()){
            return acc[index++];
        }
        else{
            throw new NoSuchElementException('Iterator has no more elements.');
        }
        
    }

}