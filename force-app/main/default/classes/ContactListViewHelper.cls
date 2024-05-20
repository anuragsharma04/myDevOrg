public with sharing class ContactListViewHelper {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        return [SELECT  Id,AccountId,Email,	FirstName,	LastName FROM Contact LIMIT 1000];
    }
}