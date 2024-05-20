public class EventTriggerHandler {
    public static void handleSingleEvent(List<Event__c> newEvents){
       // System.debug('hi');
        List<Session__c> insertSession = new List<Session__c>();
        Id recordType = [SELECT Id,DeveloperName FROM RecordType WHERE SObjectType='Event__c' AND DeveloperName='Single_Session_Event'].Id;
        //System.debug(recordType);
        for(Event__c ev: newEvents){
           // System.debug('hello'+ev.Name);
            if(ev.RecordTypeId==recordType){
         // List<Session__c> existingSessions = [SELECT Id FROM Session__c WHERE Event__c = :ev.Id];
             //   if(existingSessions.isEmpty()){
                    Session__c session = new Session__c();
                    session.Name__c= ev.Name;
                    session.Start_Date_Time__c = ev.Start_Date_Time__c;
                    session.End_Date_Time__c = ev.End_Date_Time__c;
                    session.Capacity__c=10;
                    session.Event__c=ev.Id;
                    insertSession.add(session);
                   // System.debug('session'+session);
               // }

            }
            }
        if (!insertSession.isEmpty()) {
            insert insertSession;
        }
        
    }
    
}