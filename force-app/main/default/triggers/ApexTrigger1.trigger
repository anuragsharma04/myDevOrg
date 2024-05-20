trigger ApexTrigger1 on Student_Enrolls__c (before insert) {
    for (Student_Enrolls__c se : Trigger.new) {
        if (se.Ph_Number__c != null) {
            se.Ph_Number__c = '+91' + se.Ph_Number__c;
        }
    }
}