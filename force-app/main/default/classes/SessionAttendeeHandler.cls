public class SessionAttendeeHandler {
    public static void sessionAttendees(List<Session_Attendee__c> saList, Map<Id,Session_Attendee__c>oldSessionAttendeesMap){
        set<Id> eaIds = new Set<Id>();
        for(Session_Attendee__c sa: saList){
            eaIds.add(sa.Event_Attendee__c);
        }
        List<Event_Attendee__c> eventAttd =[SELECT Id,Status__c FROM Event_Attendee__c WHERE Id IN: eaIds];
        for(Event_Attendee__c ea: eventAttd){
      List<Session_Attendee__c> relatedSessionAttd =[SELECT Id,Status__c FROM Session_Attendee__c WHERE Event_Attendee__c=:ea.Id];
            Boolean allAttd= true;
            for(Session_Attendee__c seAttd: relatedSessionAttd){
                if(seAttd.Status__c!='Attended'){
                    allAttd=false;
                    break;
                    
                }
            }
            if(allAttd){
                ea.Status__c='Attended';
            }
        }
        update eventAttd;
    }

}