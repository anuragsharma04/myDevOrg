import { LightningElement } from 'lwc';
    
export default class BranchesToCustomer extends LightningElement {
    value;
    checkCombo=true;
    buttonSub=false;
    fields=['AccountNumber__c','IFSC_Code__c','Name__c','Regional_Manager__c','Branch__c','PAN_Number__c','	Email__c'];
    get options() {
        return [
            { label: 'Saving Account', value: 'saving account' },
            { label: 'Current Account', value: 'current account' },
            { label: 'Credit Card', value: 'credit card' }
        ];
    }
    handleChange(event) {
        this.value = event.detail.value;
    }
    handleNext(event){
        this.checkCombo=false;
        this.buttonSub=true;
        
    }
}