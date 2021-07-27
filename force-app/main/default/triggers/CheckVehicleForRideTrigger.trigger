trigger CheckVehicleForRideTrigger on Ride__c (before insert) {
    CheckVehicleForRideTriggerHandler.CheckForVehicle(Trigger.new, Trigger.new);
}