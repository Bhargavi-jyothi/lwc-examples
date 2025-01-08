import { LightningElement ,api} from 'lwc';

export default class DesignPropertiesEx extends LightningElement {
    @api firstName ='James';
    @api title ='Welcome';
    @api isVisible=false;
    @api imgUrl='';
}