trigger StripePaymentTrigger on Payment__c (after insert) {
    StripePaymentHandler.stripePayment(Trigger.newMap.keySet());

}