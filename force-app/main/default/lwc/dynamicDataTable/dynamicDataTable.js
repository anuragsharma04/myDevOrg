// dynamicDataTable.js
import { LightningElement, track, wire,api } from 'lwc';
import getDynamicData from '@salesforce/apex/FieldSetHelper.getDynamicData';

export default class DynamicDataTable extends LightningElement {
    @api parentObjectName;
    @api childObjectName;
    @api fieldNames;

    @track data = [];
    @track columns = [];

    handleParentObjectNameChange(event) {
        this.parentObjectName = event.target.value;
        this.retrieveDynamicData();
    }

    handleChildObjectNameChange(event) {
        this.childObjectName = event.target.value;
        this.retrieveDynamicData();
    }

    handleFieldNamesChange(event) {
        this.fieldNames = event.target.value;
        this.retrieveDynamicData();
    }

    retrieveDynamicData() {
        getDynamicData({ parentObjectName: this.parentObjectName, childObjectName: this.childObjectName, fieldNames: this.fieldNames })
            .then(result => {
                this.data = result.data;
                this.columns = result.columns;
            })
            .catch(error => {
                console.error('Error retrieving dynamic data: ', error);
            });
    }
}