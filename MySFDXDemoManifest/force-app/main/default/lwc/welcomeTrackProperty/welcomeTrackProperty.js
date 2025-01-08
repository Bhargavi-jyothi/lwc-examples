import { LightningElement,track } from 'lwc';

export default class WelcomeTrackProperty extends LightningElement {
    @track greetings;
    handleGreetingsChange(event){
        this.greetings = event.target.value;
    }
}