trigger oppTimeTrigger on Opportunity (before insert,before update) {
    OppTimerHandlerr.opp(trigger.new);

}