import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccounts from '@salesforce/apex/AccountListHelper.getAccounts';
import deleteAccounts from '@salesforce/apex/AccountListHelper.deleteAccounts';
const columns = [
     { label: 'Id', fieldName: 'Id' },
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Industry', fieldName: '	Industry', type: 'Picklist' }
];
//TEST GITHUB WITH GEARSET
export default class AccountListView extends NavigationMixin(LightningElement) {
    accounts;
    check1= true;
    filteredAccounts;
    error;
    columns = columns;
    searchTerm = '';
    check=false;
   cardData;
   
    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            //this.filterAccounts();
            this.error = undefined;
        } else if (error) {
            console.log('OUTPUT : '+ JSON.stringify(error));
            this.error = error;
            this.accounts = undefined;
        }
    }
    handleClick(){
       // console.log('OUTPUT : '+JSON.stringify(this.accounts));
        this.check = true;
        this.check1 = false;
         var result=  this.template.querySelector('lightning-datatable').getSelectedRows();
         this.cardData=result;
         console.log('res'+JSON.stringify(result));

    }
navigate(event){
    const recordId = event.currentTarget.dataset.id;
     this[NavigationMixin.Navigate]({
           type: 'standard__recordPage',
           attributes: {
                recordId: recordId,
                actionName: 'view'           },
       });
}


handleDelete(event){
//console.log('hello'+event.target.value);
  
    deleteAccounts({
        acId : event.target.value
    })
    .then(result => {
        console.log(result);
    })
    .catch(error => {
        console.log(error);    

  
});
 this.cardData= this.cardData.filter((val)=>{
                return val.Id != event.target.value;
        })
}
     
  
   
}
