import { LightningElement } from 'lwc';

export default class LifeCycleHooks extends LightningElement {
     isVisible;
    constructor(){
        super();
        console.log('constructor called from parent');
    }
    connectedCallback(){
        console.log('Call received from parent');
    }
    renderedCallback(){
        console.log('call received from parent rendered');
    }

    errorCallback(){
        console.log('Call revied from error calling');
    }
    
    handleChange(){
        if(this.isVisible ==true){
            this.isVisible =false;
        }
        else{
            this.isVisible =true;
        }
    }
 }
