public with sharing class CheckVehicleForRideTriggerHandler {
   
    public static void CheckForVehicle(List<Ride__c> allRides, List<Driver__c> allDrivers) {

        // Get all drivers, their vehicles and their rides
        Map<Id,Driver__c> drivers = new Map<Id,Driver__c>([SELECT Id,(SELECT Id FROM Vehicles__r),
                                                         (SELECT Id FROM Rides__r) 
                                                            FROM Driver__c 
                                                            WHERE Id IN :allDrivers]);

        Map<Id,Ride__c> rides = new Map<Id,Ride__c>([SELECT Id 
                                                    FROM Ride__c 
                                                    WHERE Id IN :allRides]);
        Integer index, i;
        for(i = 0; i < allDrivers.size(); i++) {
            // check if there is no vehicle 
            if (trigger.isInsert && drivers.get(allDrivers[i].Id).Vehicles__r.size() == 0) {
                if(drivers.get(allDrivers[i].Id).Rides__r.size() != 0) {   
                    index = i;
                }
            }     
        }                               
        // loop through all rides
        //for(Ride__c ride : allRides) {  
            rides.get(allRides[index].Id).Driver__c.addError('No vehicle found for ride.');
        //}  
    }
}
