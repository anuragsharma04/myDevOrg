trigger AccountOrderTrigger on Order (before insert) {
AccountOrderTriggerHandler.checkDuplicateOrder(Trigger.new);
}