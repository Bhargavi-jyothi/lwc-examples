import { LightningElement } from 'lwc';

export default class LifeCycleChildHooks extends LightningElement {

    constructor(){
        super();
        console.log('Constructor called from child');
    }
    connectedCallback(){
        console.log('call received from child');
    }
    renderedCallback(){
        console.log('call received from child rendered');
    }
    disconnectedCallback(){
        console.log('call received from disconnected call back');
    }
}