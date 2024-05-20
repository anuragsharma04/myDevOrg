public class ContactsFieldTriggerHandler {
    public static void contactsFieldId(List<Contact> conList) {
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        List<Account> accList = new List<Account>();
        
        for (Contact con : conList) {
            conMap.put(con.AccountId, con);
        }
        
        for (Account ac : [SELECT Id, Contacts_Field__c FROM Account WHERE Id IN :conMap.keySet()]) {
            if (conMap.containsKey(ac.Id)) {
                if (ac.Contacts_Field__c == null) {
                    ac.Contacts_Field__c = conMap.get(ac.Id).Id;
                } else {
                    ac.Contacts_Field__c += ',' + conMap.get(ac.Id).Id;
                }
                accList.add(ac);
            }
        }

        if (!accList.isEmpty()) {
            update accList;
        }
    }

    public static void UpdatecontactsFieldId(List<Contact> conList, Map<Id, Contact> oldConMap) {
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        List<Account> accList = new List<Account>();
        Set<Id> newAccountIds = new Set<Id>();
        Set<Id> oldAccountIds = new Set<Id>();
     for (Contact con : conList) {
          conMap.put(con.AccountId, con);
            if (oldConMap != null && oldConMap.containsKey(con.Id) && oldConMap.get(con.Id).AccountId != con.AccountId) {
                newAccountIds.add(con.AccountId);
                oldAccountIds.add(oldConMap.get(con.Id).AccountId);
            }
        }
        for (Account ac : [SELECT Id, Contacts_Field__c FROM Account WHERE Id IN :newAccountIds]) {
            if (conMap.containsKey(ac.Id)) {
                if (ac.Contacts_Field__c == null) {
                    ac.Contacts_Field__c = conMap.get(ac.Id).Id;
                } else {
                    ac.Contacts_Field__c += ',' + conMap.get(ac.Id).Id;
                }
                accList.add(ac);
            }
        }
        for (Account ac : [SELECT Id, Contacts_Field__c FROM Account WHERE Id IN :oldAccountIds]) {
            if (conMap.containsKey(ac.Id)) {
                if (ac.Contacts_Field__c != null) {
                    ac.Contacts_Field__c = ac.Contacts_Field__c.replace(',' + conMap.get(ac.Id).Id, '');
                    ac.Contacts_Field__c = ac.Contacts_Field__c.replace(conMap.get(ac.Id).Id + ',', '');
                    ac.Contacts_Field__c = ac.Contacts_Field__c.replace(conMap.get(ac.Id).Id, '');
                    accList.add(ac);
                }
            }
        }

        if (!accList.isEmpty()) {
            update accList;
        }
    }
}