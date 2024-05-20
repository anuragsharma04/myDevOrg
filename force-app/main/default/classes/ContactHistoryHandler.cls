public class ContactHistoryHandler {
    public static void handleAfterInsert(List<Contact> newContacts) {
      //  System.debug('hii');
        List<Contact_Account_History__c> contactAccountHistories = new List<Contact_Account_History__c>();
       // System.debug('hiii');

       // System.debug('hello');

        for (Contact newContact : newContacts) {
          //  System.debug('hiiii');
            Contact_Account_History__c historyRecord = new Contact_Account_History__c();
              historyRecord.ContactsLookup__c = newContact.Id;
              historyRecord.AccountsLookups__c = newContact.AccountId;
              historyRecord.Designation__c = newContact.Designation__c;
            

            contactAccountHistories.add(historyRecord);
        }

       // System.debug(contactAccountHistories);

        if (!contactAccountHistories.isEmpty()) {
           insert contactAccountHistories;
        }
    }
}