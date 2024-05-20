trigger SessionAttendeeTrgr on Session_Attendee__c (after insert,after update) {
SessionAttendeeHandler.sessionAttendees(Trigger.new,Trigger.oldMap);
}