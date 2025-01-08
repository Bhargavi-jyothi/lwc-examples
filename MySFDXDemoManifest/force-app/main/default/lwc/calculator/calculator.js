import { LightningElement,track} from 'lwc';
import calres from'@salesforce/apex/CalcultorClass.sumOfNumbers';
export default class Calculator extends LightningElement {
    @track fnum;
    @track snum;
    @track sum;
    @track errors;
handleClick(){
        calres({firstNum:this.fnum , secondNum:this.snum})
            .then(result=> {
                 this.sum =result;
            })  
            .catch(error=>{
                this.errors =error;
            });
        
    }
 
    handleChange(event){
        if(event.target.name==='fnum'){
            this.fnum =event.target.value;
        }
        if(event.target.name==='snum'){
            this.snum =event.target.value;
        }
    }
}