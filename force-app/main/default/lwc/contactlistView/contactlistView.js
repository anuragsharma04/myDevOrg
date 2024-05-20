import { LightningElement,wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactListHelper.getContacts';
const ACTIONS =[{label:'Delete',name:'delete'}]
const COLS=[{label: 'Name', fieldName: 'link', type:'url', typeAttributes:{label:{fieldName:'FullName'}}},
{label:'Email', fieldName:'Email'},
{label:'Account',fieldName:'accountLink', type:'url',typeofAttributes:{label:{fieldName:'Account Name'}}},
{label:'Mailing Address',fieldName:'MailingAddress'},
{fieldName:"actions",type:'action', typeofAttributes:{rowActions:ACTIONS}}]
export default class ContactlistView extends LightningElement {
    cols=COLS;
    contacts;
    wiredCons;
    @wire(getContacts)
    contactsWire(result){
      this.wiredCons = result;
      if(result.data){
       this.contacts = result.data.map((row) =>{
        return this.mapContacts(row)
       });
      }
      if(result.error){
        console.error(result.error);
      }
    }
    mapContacts(row){
        console.log(row);
        return{...row,
        FullName:`${row.firstName} ${row.lastName}`,
    link: '/{row.Id}'};
    }
}