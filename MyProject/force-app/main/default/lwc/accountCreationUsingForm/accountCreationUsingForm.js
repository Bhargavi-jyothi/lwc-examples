import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountCreationUsingForm extends NavigationMixin(LightningElement) {
    @api objectApiName = "Account";

    handleSuccess(event) {
        // Show Toast Message
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Record Successfully Created',
            variant: 'success',
            mode: 'dismissible'
        });
        this.dispatchEvent(evt);

        // Navigate to the Record Page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Account',
                actionName: 'view'
            },
        });
    }
}
