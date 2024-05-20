public class SessionTriggerHanlder {

    public static void canNotHaveMultipleSession(List<Session__c> sessionList){
        set<Id> eventIds = new set<Id>();
        for(Session__c se: sessionList){
            if(se.Event__c!=NULL){
                eventIds.add(se.Event__c);
            }
        }
        Map<Id,Session__c> sessionMap = new Map<Id,Session__c>();
        for(Session__c s:[SELECT Id,Event__c FROM Session__c WHERE Event__c IN: eventIds]){
            sessionMap.put(s.Event__c,s);
             }
        for(Session__c sess: sessionList){
            if(sessionMap.containsKey(sess.Event__c)){
                sess.addError('session Exists');
            }
       
    }
    }
    public static void updateEventDateTime(List<Session__c> updatedSessions) {
        Set<Id> eventIds = new Set<Id>();

        for (Session__c updatedSession : updatedSessions) {
            if (updatedSession.Event__c != null) {
                eventIds.add(updatedSession.Event__c);
            }
        }

        if (!eventIds.isEmpty()) {
            List<Event__c> eventsToUpdate = new List<Event__c>();

            for (Event__c event : [SELECT Id, Start_Date_Time__c, End_Date_Time__c FROM Event__c WHERE Id IN :eventIds]) {
                Session__c relatedSession = null;

                for (Session__c session : updatedSessions) {
                    if (session.Event__c == event.Id) {
                        relatedSession = session;
                        break;
                    }
                }

                if (relatedSession != null) {
                    event.Start_Date_Time__c = relatedSession.Start_Date_Time__c;
                    event.End_Date_Time__c = relatedSession.End_Date_Time__c;

                    eventsToUpdate.add(event);
                }
            }

            if (!eventsToUpdate.isEmpty()) {
                update eventsToUpdate;
            }
        }
    }
}