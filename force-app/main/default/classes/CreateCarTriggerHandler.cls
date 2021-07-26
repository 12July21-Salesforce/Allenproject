public with sharing class CreateCarTriggerHandler {
    
    public static void CreateNewCar(List<Driver__c> allDrivers) {
   
        List<Vehicle__c> vehicles = new List<Vehicle__c>();  

        //Get Related Vehicle Records For The Drivers  
        Map<Id,Driver__c> driversWithVehicles = new Map<Id,Driver__c>([SELECT Id,(SELECT Id FROM Vehicles__r) 
                                                                       FROM Driver__c 
                                                                       WHERE Id IN :allDrivers]);

        // Check for All the Drivers & If Any Drivers doesn't have the Vehicle, then ADD The Related Vehicle to that driver.  
        // Iterate Through Each Driver.  
        for(Driver__c driver : allDrivers) {  
            // Check if the driver already has a related vehicle.  
            if (driversWithVehicles.get(driver.Id).Vehicles__r.size() == 0) {  
            // If it doesn't have then, add Default vehicle  
            vehicles.add(new Vehicle__c(Make__c = 'test',
                                        Model__c = 'test',
                                        Year__c = 2000,
                                        Driver__c = driver.Id));  
            }        
        }  
        if (vehicles.size() > 0) {  
            insert vehicles;  
        }  
    }
}