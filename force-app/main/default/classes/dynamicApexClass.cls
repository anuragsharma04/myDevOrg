public with sharing class dynamicApexClass {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getData(String objectAPIName, String fieldAPINames, Integer customLimit) {
        try {
            List<String> fields = fieldAPINames.split(',');
            String query = 'SELECT ' + String.join(fields, ', ') + ' FROM ' + objectAPIName;
            if (customLimit != null && customLimit > 0) {
                query += ' LIMIT ' + customLimit;
            }
            System.debug('Dynamic Query: ' + query);
            return Database.query(query);
        } catch (Exception ex) {
            System.debug('Error in getData method: ' + ex.getMessage());
            throw ex;
        }
    }
}