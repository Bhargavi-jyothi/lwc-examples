import { LightningElement } from 'lwc';

export default class LifeCycleChildHooks extends LightningElement {
    constructor(){
       // super();
        console.log('constructor called from child');
    }
    connectedCallback(){
        console.log('Call received from child');
    }
    renderedCallback(){
        console.log('call received from child rendered');
    }
    disconnectedCallback(){
        console.log('Call received from disconnected call back');
    }
}