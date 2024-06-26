public with sharing class FieldSetController {
    @AuraEnabled(cacheable=true)
    public static DynamicDataWrapper getDynamicData(String parentObjectName, String childObjectName, String fieldNames) {
        DynamicDataWrapper resultWrapper = new DynamicDataWrapper();
        resultWrapper.data = new List<Map<String, Object>>();
        resultWrapper.columns = new List<Map<String, String>>();

        try {
            // Get fields from comma-separated string
            List<String> fieldList = fieldNames.split(',');

            // Build columns for datatable
            for (String fieldName : fieldList) {
                Map<String, String> column = new Map<String, String>();
                column.put('label', fieldName);
                column.put('fieldName', fieldName);
                column.put('type', 'text');
                resultWrapper.columns.add(column);
            }

            // Query records dynamically based on object names and fields
            String query = 'SELECT ';
            for (String fieldName : fieldList) {
                query += fieldName + ', ';
            }
            query += ' FROM ' + childObjectName;

            List<SObject> records = Database.query(query);

            // Build data for datatable
            for (SObject record : records) {
                Map<String, Object> rowData = new Map<String, Object>();
                for (String fieldName : fieldList) {
                    rowData.put(fieldName, record.get(fieldName));
                }
                resultWrapper.data.add(rowData);
            }
        } catch (Exception e) {
            // Handle exceptions
            System.debug('Error occurred: ' + e.getMessage());
        }

        return resultWrapper;
    }

    public class DynamicDataWrapper {
        @AuraEnabled public List<Map<String, Object>> data { get; set; }
        @AuraEnabled public List<Map<String, String>> columns { get; set; }
    }
}