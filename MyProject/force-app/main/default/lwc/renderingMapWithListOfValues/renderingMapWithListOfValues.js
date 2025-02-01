import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/ReadMapData.getAccounts';

export default class RenderingMapWithListOfValues extends LightningElement {
    @track mapData = {};

    @wire(getAccounts)
    wiredData({ data, error }) {
        if (data) {
            this.mapData = data;
        } else if (error) {
            console.error('Error fetching account data:', error);
        }
    }

    // Convert mapData into an array of key-value pairs
    get mapEntries() {
        return Object.keys(this.mapData).map(key => ({
            key,
            values: this.mapData[key]
        }));
    }
}
