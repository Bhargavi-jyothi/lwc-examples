import { LightningElement, wire, track } from 'lwc';
import getData from '@salesforce/apex/ReadMapData.getMapData';

export default class RenderingMap extends LightningElement {
    @track mapData = [];
   

    @wire(getData)
    wiredAccounts(result) {
        if (result.data) {
            

            for (let key in result.data) {
                if (result.data) { // Ensure it's a direct property
                    this.mapData.push({ key: key, value: result.data[key] });
                }
            }

            
        } else if (result.error) {
            
            console.error('Error:' + result.error); // Log error details
        }
    }
}
