import { LightningElement ,track} from 'lwc';

export default class UpdatingList extends LightningElement {
    @track listItems =[{ id: 1, name: 'Item 1' },
    { id: 2, name: 'Item 2' },
    { id: 3, name: 'Item 3' }];
    
    nextId = 4;
    addItems(){
        const newItem = {
            id: this.nextId, // Unique ID
            name: `Item ${this.nextId}`
        };
        this.listItems = [...this.listItems, newItem];
        this.nextId++;
    }
}