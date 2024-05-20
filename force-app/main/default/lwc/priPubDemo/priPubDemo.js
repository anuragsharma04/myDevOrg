import { LightningElement, api } from 'lwc';

export default class PriPubDemo extends LightningElement {
    message='Public Property'; //this messsage is still pvt. property bcz we're not using @api
   @api recordId;
}