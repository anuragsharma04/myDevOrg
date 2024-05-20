public with sharing class displayObjectsFields {
    @AuraEnabled(cacheable=true)
    public static Map<String,String> getAllObjectList(){
        Map<String,String> mapOfAllObjects = new Map<String,String>();
        for(Schema.SObjectType objType: Schema.getGlobalDescribe().values()){
            String name = objType.getDescribe().getLocalName();
            String label = objType.getDescribe().getLabel();
           mapOfAllObjects.put(name,label);
        }
        return mapOfAllObjects;

    }
    @AuraEnabled(cacheable=true)
    public static Map<String,String> getAllFieldList(String strObjectName){
        Map<String,Schema.SObjectType> detail= Schema.getGlobalDescribe();
        Map<String,String> mapOfFields = new Map<String,String>();
        for(Schema.SObjectField fields: detail.get(strObjectName).getDescribe().fields.getMap().values()){
           mapOfFields.put(fields.getDescribe().getName(), fields.getDescribe().getName());
        }
        return mapOfFields;

    }
}