public class MetadataServiceController {
     @AuraEnabled
    public static void createObject(String objectName,String objectAPI,String objectPlural) {
        MetadataService.MetadataPort   metadataservice = new MetadataService.MetadataPort();
        metadataservice.SessionHeader =   new MetadataService.SessionHeader_element();
        metadataservice.SessionHeader.sessionId = session.getSessionIdFromVFPage(Page.sessionId);

       //  metadataservice.SessionHeader.sessionId =UserInfo.getSessionId();
         List<MetadataService.CustomObject> objectList = new List<MetadataService.CustomObject>();
        MetadataService.CustomObject   customobject = new MetadataService.CustomObject();
        customobject.fullName =   objectAPI;
        customobject.label =   objectName;
        customobject.pluralLabel =   objectPlural;
        customObject.nameField = new MetadataService.CustomField();
        customobject.nameField.type_x =   'Text';
        customobject.nameField.label = 'Name';
        customobject.deploymentStatus =   'Deployed';
        customObject.sharingModel = 'ReadWrite';
        objectList.add(customobject);
         metadataservice.createMetadata(objectList);
    }
   @AuraEnabled
    public static void createCustomField(String objectAPIName, String fieldAPIName, String fieldDescription, String fieldLabel){
        system.debug('fieldAPIName'+fieldAPIName);
        MetadataService.MetadataPort metadataservice = new MetadataService.MetadataPort();
        metadataservice.SessionHeader =   new MetadataService.SessionHeader_element();
         metadataservice.SessionHeader.sessionId = session.getSessionIdFromVFPage(Page.sessionId);
        //metadataservice.SessionHeader.sessionId =UserInfo.getSessionId();
        List<MetadataService.CustomField > fieldList = new List<MetadataService.CustomField >();
        MetadataService.CustomField    customfield = new MetadataService.CustomField();
        String fullNaming =objectAPIName;
        fullNaming += '.'+fieldAPIName;
        system.debug('fullNaming'+fullNaming);
        customField.fullName =   fullNaming;
        customField.label =   fieldLabel;
        customField.type_x = 'Text';
        customField.length = 52;
        system.debug('custom'+customField);
        fieldList.add(customField);
        metadataservice.createMetadata(fieldList);
    }

}