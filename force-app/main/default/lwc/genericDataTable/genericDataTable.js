import { LightningElement, api } from 'lwc';
import getData from '@salesforce/apex/GenericDataTable.getData';

export default class GenericDataTable extends LightningElement {
    @api title;
    @api objectAPIName;
    @api customLimit;
    @api filterFieldName;
    @api columnsStringData;
    @api fieldAPINames;
    @api relationFieldAPIName; 
    @api recordId;
    @api whereCondition; 

    columns = [];
    data = [];
    filteredData = [];
    searchKeyword = '';

    connectedCallback() {
        if (this.columnsStringData) {
            this.columns = this.columnsStringData.split(',').map(column => {
                const [label, fieldName] = column.trim().split(':');
                return { label, fieldName };
            });
        }
        this.loadData();
    }

    loadData() {
        let parentId = null;
        let parentFieldName = null;
        
        if (this.relationFieldAPIName && this.recordId) {
            parentId = this.recordId;
            parentFieldName = this.relationFieldAPIName;
        }

        getData({ 
                parentFieldName: parentFieldName, 
                parentId: parentId, 
                objectAPIName: this.objectAPIName, 
                fieldAPINames: this.fieldAPINames, 
                customLimit: this.customLimit,
                whereCondition: this.whereCondition 
            })
            .then(result => {
                if (result && result.length > 0) {
                    this.data = result;
                    this.filteredData = this.data;
                    this.filterData();
                } else {
                    console.error('No data returned from Apex method.');
                }
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }
}