import { LightningElement,track} from 'lwc';

export default class CalTest extends LightningElement {
     firstNumber =0;
     secondNumber=0;
     @track result =0; // we have to track and render changes in this property
     handleChange(event){
        if(event.target.name==='fnum'){
            this.firstNumber = event.target.value;
        }
        if(event.target.name==='snum'){
            this.secondNumber = event.target.value;
        }
        this.result =parseInt(this.firstNumber)+parseInt(this.secondNumber);
     }
}