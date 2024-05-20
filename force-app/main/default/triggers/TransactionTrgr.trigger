trigger TransactionTrgr on Transaction__c (after insert) {
    TransactionTriggerHandler.paymentInsert(Trigger.new);

}