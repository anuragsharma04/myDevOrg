// Apex Class
public with sharing class sampleTable {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getData(String objectAPIName, List<String> fieldAPINames, Integer customLimit) {
        try {
            String fields = String.join(fieldAPINames, ', ');
            String query = 'SELECT ' + fields + ' FROM ' + objectAPIName;
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