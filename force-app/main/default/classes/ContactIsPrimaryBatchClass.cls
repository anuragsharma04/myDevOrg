public class ContactIsPrimaryBatchClass implements Database.Batchable<sObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext context) {
        String query = 'SELECT Id, Is_Primary__c, AccountId, CreatedDate FROM Contact WHERE Is_Primary__c = true';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext context, List<Contact> scope) {
        
        Map<Id, Contact> recentPrimaryContacts = new Map<Id, Contact>();
        List<Id> contactIdsToUpdate = new List<Id>();

        for (Contact con : scope) {
            if (!recentPrimaryContacts.containsKey(con.AccountId) || 
                recentPrimaryContacts.get(con.AccountId).CreatedDate < con.CreatedDate) {
                recentPrimaryContacts.put(con.AccountId, con);
            }
            contactIdsToUpdate.add(con.Id);
        }

        List<Account> accountsToUpdate = new List<Account>();
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Id accountId : recentPrimaryContacts.keySet()) {
            Account acc = new Account(Id = accountId, Primary_Contact__c = recentPrimaryContacts.get(accountId).Id);
            accountsToUpdate.add(acc);

            for (Contact con : scope) {
                if (con.AccountId == accountId && !con.Id.equals(recentPrimaryContacts.get(accountId).Id)) {
                    con.Is_Primary__c = false;
                    contactsToUpdate.add(con);
                }
            }
        }

        update accountsToUpdate;
        update contactsToUpdate;
    }

    public void finish(Database.BatchableContext context) {
    }
}