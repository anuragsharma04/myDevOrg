trigger StripeTrigger on Account (after insert) {
StripeHandler.stripeCustomerId(Trigger.newMap.keySet());
}