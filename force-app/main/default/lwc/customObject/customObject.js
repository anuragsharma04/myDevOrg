import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createObject from '@salesforce/apex/MetadataServiceController.createObject';
import createCustomField from '@salesforce/apex/MetadataServiceController.createCustomField';

export default class CreateCustomObject extends LightningElement {
    @track objectLabel;
    @track objectApiName;
    @track pluralLabel;
    @track showFields = false;
    @track fieldApiName;
    @track fieldLabel;
    @track fieldDescription;

    handleObjectLabelChange(event) {
        this.objectLabel = event.target.value;
    }

    handleObjectApiNameChange(event) {
        this.objectApiName = event.target.value;
    }

    handlePluralLabelChange(event) {
        this.pluralLabel = event.target.value;
    }

    handleCreateObject() {
        console.log('Object Label:', this.objectLabel);
        console.log('Object API Name:', this.objectApiName);
        console.log('Plural Label:', this.pluralLabel);

        createObject({
                objectName: this.objectLabel,
                objectAPI: this.objectApiName,
                objectPlural: this.pluralLabel
            })
            .then(result => {
                console.log('Custom object created successfully:', this.objectApiName);
                const toastEvent = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Custom object created successfully: ' + this.objectApiName,
                    variant: 'success'
                });
                this.dispatchEvent(toastEvent);
                
                this.showFields = true;
            })
            .catch(error => {
                console.error('Error creating custom object:', error);
                const toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: 'Failed to create custom object: ' + error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);
            });
    }

    handleFieldApiNameChange(event) {
        this.fieldApiName = event.target.value;
    }

    handleFieldLabelChange(event) {
        this.fieldLabel = event.target.value;
    }

    handleFieldDescriptionChange(event) {
        this.fieldDescription = event.target.value;
    }

    handleCreateField() {
        createCustomField({
                objectAPIName: this.objectApiName,
                fieldAPIName: this.fieldApiName,
                fieldLabel: this.fieldLabel,
                fieldDescription: this.fieldDescription
            })
            .then(result => {
                console.log('Custom field created successfully:', this.fieldApiName);
                const toastEvent = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Custom field created successfully: ' + this.fieldApiName,
                    variant: 'success'
                });
                this.dispatchEvent(toastEvent);
                this.fieldApiName = '';
                this.fieldLabel = '';
                this.fieldDescription = '';
            })
            .catch(error => {
                console.error('Error creating custom field:', error);
                const toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: 'Failed to create custom field: ' + error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);
            });
    }
}