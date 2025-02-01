import { LightningElement ,track} from 'lwc';

export default class AdditionOfNumbers extends LightningElement {
    num1 =0;
    num2=0;
    @track result =0;

    handleChange(event){
        if(event.target.name==='num1'){
              this.num1= event.target.value;
              
        }
        if(event.target.name==='num2'){
            this.num2 = event.target.value;
           
        }
       this.result = parseInt(this.num1)+parseInt(this.num2);
       console.log(this.result);
              
    }
}