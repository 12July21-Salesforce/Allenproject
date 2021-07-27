public with sharing class CreateCarTriggerHandler {
    
    public static void CreateNewCar(List<Driver__c> allDrivers) {
   
        List<Vehicle__c> vehicles = new List<Vehicle__c>();  

        // Get all drivers 
        Map<Id,Driver__c> drivers = new Map<Id,Driver__c>([SELECT Id,(SELECT Id FROM Vehicles__r) 
                                                                       FROM Driver__c 
                                                                       WHERE Id IN :allDrivers]);

        // loop through all drivers
        for(Driver__c driver : allDrivers) {  
            // check if there is no related vehicle and make one 
            if (drivers.get(driver.Id).Vehicles__r.size() == 0) {   
            vehicles.add(new Vehicle__c(Make__c = 'Toyota',
                                        Model__c = 'Corolla',
                                        Year__c = 2009,
                                        Driver__c = driver.Id));  
            }        
        }  
        if (vehicles.size() > 0) {  
            insert vehicles;  
        }  
    }
}