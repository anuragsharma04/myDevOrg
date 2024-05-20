trigger ClassTrigger on Class__c (after insert) {
    
   ClassTriggerHandler.OnInsert1(Trigger.new);
}