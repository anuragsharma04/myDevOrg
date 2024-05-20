trigger EventAttendeeTrigger on Event_Attendee__c (after insert) {
    EventAttendeeHandler.singleSessionEventAttendees(Trigger.new);

}