import { LightningElement, track } from 'lwc';
import getAllObjectList from '@salesforce/apex/displayObjectsFields.getAllObjectList';
import getAllFieldList from '@salesforce/apex/displayObjectsFields.getAllFieldList';
export default class DisplayObjectsFields extends LightningElement {
@track objectList= [];
@track allObjectList= [];
@track customObjectList= [];
@track standardObjectList= [];
@track fieldList=[];
objectName='';
@track objectTypeList=[
    {label:'All', value:'All'},
    {label:'Custom', value:'Custom'},
    {label:'Standard', value:'Standard'}
];
connectedCallback(){
    getAllObjectList()
    .then((result) =>{
        if(result){
            for(let key in result){
                if(key.endsWith('__c')){
                    this.customObjectList.push({label:key,value:key});
                } else if(!key.endsWith('__c')){
                    this.standardObjectList.push({label:key,value:key});
                } else{
                   this.allObjectList.push({label:key,value:key});
                }
                
            }

        } else{
            console.log('Objects are not found');
        }
    }
    ).catch((error) =>{
        console.log('Objects are not found');

    }
    )
}
handleObjectType(event){
    if(event.detail.value=='All'){
        this.objectList=this.getAllObjectList;
    }
    else if(event.detail.value=='Custom'){
        this.objectList=this.customObjectList;
    } else if(event.detail.value=='Standard'){
       this.objectList=this.standardObjectList;
    }

}
handleSelectedObject(event){
    this.objectName= event.detail.value;
    this.fieldList=[];
    getAllFieldList({strObjectName: this.objectName})
    .then(result =>{
        for(let key in result){
            this.fieldList.push({label:key,value:key});
        }
    })
    .catch(error =>{
        console.log('Error getting fields');
    })
}
}