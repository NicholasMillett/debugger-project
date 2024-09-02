import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactCreator extends LightningElement {
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Contact Created',
            message: 'Contact ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
    }
}
