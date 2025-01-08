import { LightningElement } from 'lwc';

export default class ColorPicker extends LightningElement {
    handleColorChange(event) {
        const colorVal = event.target.value;
        // Dispatch a custom event with the selected color value
        const colorCodeEvent = new CustomEvent('colorchange', {
            detail: { colorVal },
        });
        this.dispatchEvent(colorCodeEvent);
    }
}