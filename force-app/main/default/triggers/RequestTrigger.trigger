trigger RequestTrigger on Request__c (before insert, before update) {
    RequestTriggerHandler.preventInvalidRequests(Trigger.new, Trigger.oldMap);
}
