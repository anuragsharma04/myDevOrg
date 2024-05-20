import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
export default class CreateAccountWithLDS extends LightningElement {
    strName;
    strAccountNumber;
    strPhone;

 
    // These Change handlers to handle the input values on UI
    nameChangedHandler(event){
        this.strName = event.target.value;
    }
    numberChangedHandler(event){
        this.strAccountNumber = event.target.value;
    }
    phoneChangedHandler(event){
        this.strPhone = event.target.value;
    }
 
    // Insert Account record.
    createAccountRecord(){
        // Creating mapping of fields of Account with values
        var fields = {'Name' : this.strName, 'AccountNumber' : this.strAccountNumber, 'Phone' : this.strPhone};
 
        // Record details to pass to create method with api name of Object.
        var objectRecordInput = {'apiName' : 'Account', fields};
 
        // LDS method to create record.
        createRecord(objectRecordInput).then(response => {
            alert('Account Record created with Id: ' +response.id);
        }).catch(error => {
            alert('Error: ' +JSON.stringify(error));
        });
    }
}