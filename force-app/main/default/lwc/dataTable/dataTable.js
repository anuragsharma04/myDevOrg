import { LightningElement, api, wire } from 'lwc';
import getData from '@salesforce/apex/dataTable.getData';

export default class DynamicTable extends LightningElement {
    @api title;
    @api objectAPIName;
    @api customLimit;
    @api filterFieldName;
    @api columnsStringData;
    @api fieldAPINames;
    @api relationshipFieldNames; // Add this line

    columns = [];
    data = [];
    filteredData = [];
    searchKeyword = '';

    connectedCallback() {
        if (this.columnsStringData) {
            try {
                this.columns = JSON.parse(this.columnsStringData);
            } catch (error) {
                console.error('Error parsing columnsStringData:', error);
            }
        }
        this.loadData();
    }

    loadData() {
        getData({ objectAPIName: this.objectAPIName, fieldAPINames: this.fieldAPINames, relationshipFieldNames: this.relationshipFieldNames, customLimit: this.customLimit })
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

    handleSearch(event) {
        this.searchKeyword = event.target.value.toLowerCase();
        this.filterData();
    }

    filterData() {
        if (!this.searchKeyword) {
            this.filteredData = this.data;
            return;
        }
        this.filteredData = this.data.filter(record => {
            return record[this.filterFieldName] && record[this.filterFieldName].toLowerCase().includes(this.searchKeyword);
        });
    }
}