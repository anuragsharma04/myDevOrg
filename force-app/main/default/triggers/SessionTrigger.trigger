trigger SessionTrigger on Session__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
           SessionTriggerHanlder.canNotHaveMultipleSession(Trigger.new);
          SessionTriggerHanlder.updateEventDateTime(Trigger.new);
    
        }
    }
}