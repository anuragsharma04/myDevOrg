public with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static void saveContact(String firstName, String lastName, Boolean isPrimary, Id accountId) {
        Contact newContact = new Contact(
            FirstName = firstName,
            LastName = lastName,
            AccountId = accountId
        );

        insert newContact;
        
        if(isPrimary) {
            updateAccountPrimaryContact(accountId, newContact.Name);
        }
    }

    @AuraEnabled(cacheable=true)
    public static void updateAccountPrimaryContact(Id accountId, String contactName) {
        Account acc = [SELECT Id, Primary_Contact__c FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Primary_Contact__c = contactName;
        update acc;
    }
}