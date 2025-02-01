import { LightningElement,track } from 'lwc';

export default class LifeCycleParentHooks extends LightningElement {
   @track isVisible;
    constructor(){
        super();
        console.log('Constructor called from parent');
    }
    connectedCallback(){
        console.log('call received from parent');
    }
    renderedCallback(){
        console.log('call received from parent rendered');
    }
    
    errorCallback(){
        console.log('call received from error call back');
    }

    handleClick(){
        if(this.isVisible==true){
            this.isVisible =false;
        }
        else{
            this.isVisible =true;
        }
    }
}