public class RequestTriggerHandler {
    
    public static Set<Date> allHolidays = new Set<Date>();

    static {
        //Fetch the current holidays.
        for (List<Holiday> holidays : [SELECT ActivityDate FROM Holiday]) {
            for (Holiday h : holidays) {
                allHolidays.add(h.ActivityDate);
            }
        }
    }

    public static void preventInvalidRequests(List<Request__c> newRequestList, 
                                                    Map<ID, Request__c> oldRequestMap) {
        for (Request__c request : newRequestList) {
            // checks if new data is inserted or a record is updated
			Boolean checkDate = (trigger.isInsert || 
                            oldRequestMap.get(request.Id).Pickup_Date__c != 
                                                request.Pickup_Date__c);
			if (checkDate && request.Pickup_Date__c != NULL) {
                //Prevent the invoking DML action if the Start Date is in
                //  the allHolidays set.
                if ( allHolidays.contains(request.Pickup_Date__c) ) {
                    request.Pickup_Date__c.addError(
                        'Pickup cannot be scheduled because it starts on a holiday.');
                }
            }
        }
    }
}