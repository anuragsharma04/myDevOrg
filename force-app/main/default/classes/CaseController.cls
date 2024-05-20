public with sharing class CaseController {
@AuraEnabled(cacheable = true)
  public static List<Case> getCase(){
        return [SELECT CaseNumber, Contact.LastName,Subject,Priority,Status FROM Case LIMIT 3000];
        //Sampleee
        
    }
}