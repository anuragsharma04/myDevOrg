import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createObject from '@salesforce/apex/MetadataServiceController.createObject';
import createCustomField from '@salesforce/apex/MetadataServiceController.createCustomField';

export default class CreateCustomObject extends LightningElement {
    @track objectLabel;
    @track objectApiName;
    @track pluralLabel;
    @track showFields = false;
    @track fieldRows = [];

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
        createObject({
                objectName: this.objectLabel,
                objectAPI: this.objectApiName,
                objectPlural: this.pluralLabel
            })
            .then(result => {
                const toastEvent = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Custom object created successfully: ' + this.objectApiName,
                    variant: 'success'
                });
                this.dispatchEvent(toastEvent);
                this.showFields = true;
            })
            .catch(error => {
                const toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: 'Failed to create custom object: ' + error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);
            });
    }

    handleAddField() {
        this.fieldRows.push({
            key: Date.now(),
            fieldApiName: '',
            fieldLabel: '',
            fieldDescription: ''
        });
    }

    handleFieldInputChange(event) {
        const { index, field } = event.target.dataset;
        this.fieldRows[index][field] = event.target.value;
    }

    handleCreateField() {
        const promises = this.fieldRows.map(field => {
            return createCustomField({
                objectAPIName: this.objectApiName,
                fieldAPIName: field.fieldApiName,
                fieldLabel: field.fieldLabel,
                fieldDescription: field.fieldDescription
            });
        });

        Promise.all(promises)
            .then(results => {
                const toastEvent = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Custom fields created successfully',
                    variant: 'success'
                });
                this.dispatchEvent(toastEvent);
                this.fieldRows = [];
            })
            .catch(error => {
                const toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: 'Failed to create custom fields: ' + error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);
            });
    }
}