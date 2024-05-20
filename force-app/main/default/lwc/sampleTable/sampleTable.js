// LWC JavaScript
import { LightningElement, api, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import getData from '@salesforce/apex/sampleTable.getData';

export default class SampleTable extends LightningElement {
    @api title;
    @api objectAPIName;
    @api customLimit;
    @api filterFieldName;
    @api columnsStringData;
    @api fieldAPINames;

    columns = [];
    data = [];
    filteredData = [];
    searchKeyword = '';

    @wire(getObjectInfo, { objectApiName: '$objectAPIName' })
    objectInfo;

    async connectedCallback() {
        if (this.columnsStringData) {
            try {
                this.columns = JSON.parse(this.columnsStringData);
            } catch (error) {
                console.error('Error parsing columnsStringData:', error);
            }
        }
        await this.loadData();
    }

    async loadData() {
        try {
            if (this.objectInfo.data) {
                const fields = Object.keys(this.objectInfo.data.fields).filter(fieldName => this.objectInfo.data.fields[fieldName].dataType !== 'Reference');
                const fieldAPINames = [...this.fieldAPINames, ...fields];
                const result = await getData({ objectAPIName: this.objectAPIName, fieldAPINames, customLimit: this.customLimit });
                if (result && result.length > 0) {
                    this.data = result;
                    this.filteredData = this.data;
                    this.filterData();
                } else {
                    console.error('No data returned from Apex method.');
                }
            }
        } catch (error) {
            console.error('Error fetching data:', error);
        }
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