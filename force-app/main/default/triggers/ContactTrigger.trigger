trigger ContactTrigger on Contact (before insert, before update) {
    Map<String, Contact> uniqueContacts = new Map<String, Contact>();
    for (Contact existingContact : [SELECT FirstName, LastName, Email FROM Contact]) {
        String existingKey = existingContact.FirstName + existingContact.LastName + existingContact.Email;
        String existingNameKey = existingContact.FirstName + existingContact.LastName;
        uniqueContacts.put(existingKey, existingContact);
        uniqueContacts.put(existingNameKey, existingContact);
    }
    for (Contact con : Trigger.new) {
        String key = con.FirstName + con.LastName + con.Email;
        String nameKey = con.FirstName + con.LastName;

        if (uniqueContacts.containsKey(key) || uniqueContacts.containsKey(nameKey)) {
            con.addError('Error:contact with the same FirstName:LastName:Email already exists.');
        } else {
            uniqueContacts.put(key, con);
        }
    }
}