public with sharing class ContactListHelper {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
      return[SELECT Id,FirstName,LastName,accountId,
      account.name,mailingStreet,mailingCity,mailingState,mailingPostalCode,mailingCountry,email FROM Contact LIMIT 1000];
        
}
}