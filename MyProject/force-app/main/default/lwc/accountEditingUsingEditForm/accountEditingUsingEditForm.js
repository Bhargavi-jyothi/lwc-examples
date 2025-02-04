import { LightningElement ,api} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';

export default class AccountEditingUsingEditForm extends NavigationMixin(LightningElement) {
    @api recordId ='001dL00000mhbYYQAY';
    handleSuccess(event){
        const evt = new ShowToastEvent({
            title:'success',
            message:'Record with Id '+this.recordId+' updated Successfully',
            variant:'success',
            mode:'dismissible'
        });
        this.dispatchEvent(evt);
        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                recordId : this.recordId,
                objectApiName:'Account',
               actionName: 'view'
            },
        
            
        });

    }
}