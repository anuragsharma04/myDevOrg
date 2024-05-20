trigger BookOrderTrigger on BookOrder__c (after update) {
 //BookOrderHandler.handleAfterUpdate(Trigger.new);
 orderbookhandler.handleAfterUpdate(Trigger.new);
}