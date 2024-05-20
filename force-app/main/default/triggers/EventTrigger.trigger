trigger EventTrigger on Event__c (after insert) {
    EventTriggerHandler.handleSingleEvent(Trigger.new);
}