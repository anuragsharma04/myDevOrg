trigger ContactHistoryTrigger on Contact (after insert) {
    ContactHistoryHandler.handleAfterInsert(Trigger.new);

}