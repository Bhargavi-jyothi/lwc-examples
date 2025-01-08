import { LightningElement } from 'lwc';
import Name from '@salesforce/schema/Account.Name';
import Type from '@salesforce/schema/Account.Type';
import Industry from '@salesforce/schema/Account.Industry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountCreationSample extends NavigationMixin(LightningElement) {
    objectApiName = 'Account';
    fieldList = [Name, Type, Industry];

    handleAccountCreation(event) {
        const evt = new ShowToastEvent({
            title: "Account Create",
            message: "Record ID: " + event.detail.id,
            variant: "success",
        });
        this.dispatchEvent(evt);
        console.log(event.detail.id);
        try {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.id,
                    objectApiName: 'Account',
                    actionName: 'view',
                },
            });
        } catch (error) {
            console.error('Navigation error:', error);
        }
    }
}
