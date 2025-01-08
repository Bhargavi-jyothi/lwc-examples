import { LightningElement,track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.accountsData';
export default class DataDisplayImperative extends LightningElement {
    @track data;
    @track errors;
    @track columns =[
        {label:'Name',fieldName:'Name',type:'text'},
        {label:'Phone',fieldName:'Phone',type:'phone'},
        {label:'Industry',fieldName:'Industry',type:'text'}
    ];
    connectedCallback(){
        getAccounts()
            .then(result=>{
                this.data=result;
            })
            .catch(error=>{
                 this.errors = error;
            });
        }
    }
