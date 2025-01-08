import { LightningElement,api } from 'lwc';
import Salutation from '@salesforce/schema/Contact.Salutation';
import lastName from '@salesforce/schema/Contact.LastName';
import firstName from '@salesforce/schema/Contact.FirstName';
import Email from '@salesforce/schema/Contact.Email';
import accountId from '@salesforce/schema/Contact.AccountId';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactUpdate extends LightningElement {
    @api objectApiName;
    @api fieldList=[Salutation,firstName,lastName,Email,accountId];
    @api recordId;
    handleSuccess(event){
         try{
           const eve = new ShowToastEvent({  
           title: "Contact Update",
           message: "Contact Record is : "+event.detail.fields.LastName.value+" successfully Updated",
           variant: "success",
       });
       this.dispatchEvent(eve);
    }
    catch(error) {
        console.log('Error Message '+error);
    }       
   }


           
    }
