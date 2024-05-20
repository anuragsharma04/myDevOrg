import { LightningElement,wire,track } from 'lwc';
import getCase from '@salesforce/apex/CaseController.getCase';
const columns = [
     { label: 'Case Number', fieldName: 'CaseNumber' },
    { label: 'Contact Name', fieldName: 'ContactId', type: 'Lookup(Contact)' },
    { label: 'Subject', fieldName: 'Subject', type: 'phone' },
    { label: '	Status', fieldName: 'Status', type: 'Picklist' },
    { label: '	Priority', fieldName: 'Priority', type: 'Picklist' }];
export default class CaseLwc extends LightningElement {
    case1;
    error;
    columns = columns;
       @track searchString;
       @track data;
        @track initialRecords;
    @wire(getCase)
    wiredAccounts({ error, data }) {
        if (data) {
          this.data = data;
            this.initialRecords = data;
            this.error = undefined;
        } else if (error) {
            console.log('OUTPUT : '+ JSON.stringify(error));
            this.error = error;
            this.case1 = undefined;
        }
    }
handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
 
        if (searchKey) {
            this.data = this.initialRecords;
 
            if (this.data) {
                let searchRecords = [];
 
                for (let record of this.data) {
                    let valuesArray = Object.values(record);
 
                    for (let val of valuesArray) {
                        console.log('val is ' + val);
                        let strVal = String(val);
 
                        if (strVal) {
 
                            if (strVal.toLowerCase().includes(searchKey)) {
                                searchRecords.push(record);
                                break;
                            }
                        }
                    }
                }
 
                console.log('Matched Case are ' + JSON.stringify(searchRecords));
                this.data = searchRecords;
            }
        } else {
            this.data = this.initialRecords;
        }
    }
}