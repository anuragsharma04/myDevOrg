public class findSobjectName {

    public static boolean hasChildRelationship(String parentObj, String childObj) {
        Map<String, ChildRelationship> childRelationshipMap = getChildRelationshipMap(parentObj);
//        System.debug('childRelationshipMap: ' + childRelationshipMap); // Debug statement
        for (ChildRelationship relationship : childRelationshipMap.values()) {
            if (relationship.getChildSObject().getDescribe().getName().equals(childObj)) {
                return true;
            }
        }
        return false;
    }

    public static String getChildRelationshipFieldName(String parentObj, String childObj) {
        Map<String, ChildRelationship> childRelationshipMap = getChildRelationshipMap(parentObj);
      //  System.debug('childRelationshipMap: ' + childRelationshipMap); 
        for (ChildRelationship relationship : childRelationshipMap.values()) {
            if (relationship.getChildSObject().getDescribe().getName().equals(childObj)) {
                return relationship.getField().getDescribe().getName();
            }
        }
        return null;
    }

    private static Map<String, ChildRelationship> getChildRelationshipMap(String parentObj) {
        Map<String, ChildRelationship> childRelationshipMap = new Map<String, ChildRelationship>();
        SObjectType parentType = Schema.getGlobalDescribe().get(parentObj);
      //  System.debug('parentType: ' + parentType); 
        if (parentType != null) {
            DescribeSObjectResult parentDescribe = parentType.getDescribe();
          //  System.debug('parentDescribe: ' + parentDescribe); 
            for (Schema.ChildRelationship relationship : parentDescribe.getChildRelationships()) {
                childRelationshipMap.put(relationship.getChildSObject().getDescribe().getName(), relationship);
            }
        }
        return childRelationshipMap;
    }
}