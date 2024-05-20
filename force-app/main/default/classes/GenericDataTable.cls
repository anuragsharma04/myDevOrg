public with sharing class GenericDataTable {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getData(String parentFieldName, String parentId, String objectAPIName, String fieldAPINames, Integer customLimit, String whereCondition) {
        //System.debug("hi");
        try {
            String query;
            
            if (parentFieldName == null) {
                query = 'SELECT ' + fieldAPINames + ' FROM ' + objectAPIName;
            } else {
                List<String> fields = fieldAPINames.split(',');
                query = 'SELECT ' + String.join(fields, ',') + ' FROM ' + objectAPIName + ' WHERE ' + parentFieldName + ' = :parentId';
            }
            
            if (whereCondition != null && whereCondition != '') {
                query += ' AND ' + whereCondition;
            }

            if (customLimit != null && customLimit > 0) {
                query += ' LIMIT ' + customLimit;
            }
            return Database.query(query);
        } catch (Exception ex) {
            System.debug('Error in getData method: ' + ex.getMessage());
            throw ex;
        }
    }
}