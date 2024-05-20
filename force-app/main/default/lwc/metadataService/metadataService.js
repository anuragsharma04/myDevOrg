import { LightningElement, api } from 'lwc';
import { createMetadataObject } from 'lightning/uiObjectInfoApi';

export default class MetadataService extends LightningElement {
    @api objectLabel;
    @api objectApiName;
    @api pluralLabel;
    @api fields;

    async createCustomObject() {
        const customObject = {
            fullName: this.objectApiName,
            label: this.objectLabel,
            pluralLabel: this.pluralLabel,
            deploymentStatus: 'Deployed',
            sharingModel: 'ReadWrite',
            nameField: {
                type: 'Text',
                label: 'Name'
            },
            enableReports: true,
            enableActivities: true,
            fields: this.fields
        };

        try {
            await createMetadataObject({ metadata: customObject });
            console.log('Custom object created successfully:', this.objectApiName);
        } catch (error) {
            console.error('Error creating custom object:', error);
        }
    }
}