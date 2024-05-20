import { LightningElement } from 'lwc';

export default class ParentLwc extends LightningElement {
    countValues=0;

    handleDecrement(){
        if(this.countValues>0){
        this.countValues--; }
    }
    handleIncrement(){
        this.countValues++;
    }
}