trigger AccountNumberLocationsTrigger on Account (after insert,after update) {
    AccountNumberOfLocationsHandler.numberOfLocations(Trigger.new);

}