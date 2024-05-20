import { LightningElement, track, api } from 'lwc';
import saveContact from '@salesforce/apex/ContactController.saveContact';

export default class primaryContact extends LightningElement {
    @track firstName;
    @track lastName;
    @track isPrimary = false;

    @api recordId; 

    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    handleCheckboxChange(event) {
        this.isPrimary = event.target.checked;
    }

    handleSave() {
        saveContact({
            firstName: this.firstName,
            lastName: this.lastName,
            isPrimary: this.isPrimary,
            accountId: this.recordId
        })
        .then(result => {
           this.newContact= result;
            console.log('Contact saved successfully');
        })
        .catch(error => {
           
            console.error('Error saving contact:', error.body.message);
        });
    }
}