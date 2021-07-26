trigger CreateCarTrigger on Driver__c (after insert) {
    CreateCarTriggerHandler.CreateNewCar(Trigger.new);
}