import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountSearchCls.getAccounts';

export default class SearchAccount extends LightningElement {
    @track accountName = '';
    @track accountList = [];

    @wire(getAccounts, { actName: '$accountName' })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountList = data;
        } else if (error) {
            console.error('Error:', error);
        }
    }

    handleKeyChange(event) {
        this.accountName = event.target.value;
    }
}
