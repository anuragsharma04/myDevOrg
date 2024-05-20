trigger ContactsFieldTrigger on Contact (after insert,after update) {
    ContactsFieldTriggerHandler.contactsFieldId(Trigger.new);
        ContactsFieldTriggerHandler.UpdatecontactsFieldId(Trigger.new,Trigger.oldMap);
    

    

}