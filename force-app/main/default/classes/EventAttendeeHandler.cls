public class EventAttendeeHandler {
    public static void singleSessionEventAttendees(List<Event_Attendee__c> evtList) {
        List<Session_Attendee__c> sessionAttendees = new List<Session_Attendee__c>();

        Set<Id> eventIds = new Set<Id>();
        for (Event_Attendee__c attendee : evtList) {
            eventIds.add(attendee.Event__c);
        }

        Map<Id, Session__c> sessionMap = new Map<Id, Session__c>();
        for (Session__c session : [SELECT Id, Event__c FROM Session__c WHERE Event__c IN :eventIds]) {
            sessionMap.put(session.Event__c, session);
        }

        for (Event_Attendee__c attendee : evtList) {
            if (sessionMap.containsKey(attendee.Event__c)) {
                Session_Attendee__c sessionAttendee = new Session_Attendee__c();
                sessionAttendee.Event_Attendee__c = attendee.Id;
                sessionAttendee.Session__c = sessionMap.get(attendee.Event__c).Id;
                sessionAttendee.Email__c=attendee.Email__c;
                sessionAttendee.Status__c=attendee.Status__c;

                sessionAttendees.add(sessionAttendee);
            }
        }

        if (!sessionAttendees.isEmpty()) {
            insert sessionAttendees;
        }
    }
}