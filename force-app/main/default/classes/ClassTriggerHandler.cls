public Class ClassTriggerHandler{
    public static void OnInsert1(List<Class__c> classList){
        //System.debug('hhhhhhiiiii');
        Map<Id,Class__c> classMap =new Map<Id,Class__c>();
        List<Class__c> updateClassList = new List<Class__c>();
        List<College__c> updateCollegeList = new List<College__c>();
        Map<Id,College__c> clgMap = new Map<Id,College__c>();
        //college with class
        for(Class__c cl: classList){
            classMap.put(cl.College__c,cl);
            
        }
        for(Class__c newClass:[SELECT Name,College__c,Max_Limit__c,Is_Highest__c,College__r.Name,College__r.Highest_Limit__c FROM Class__c WHERE College__c IN:classMap.KeySet()] ){
                          //  System.debug('Hello00');

            if(newClass.Max_Limit__c > newClass.College__r.Highest_Limit__c){ 
              //  System.debug('Hello');
                newClass.Is_Highest__c=true;
                College__c clgUpdate = new  College__c();
                clgUpdate.Highest_Class__c= newClass.Id;
                clgUpdate.Highest_Limit__c= newClass.Max_Limit__c;
                clgUpdate.Id= newClass.College__c;
                clgMap.put(clgUpdate.Id,clgUpdate);
                updateClassList.add(newClass);
                updateCollegeList.add(clgUpdate);
               
            } else {
                newClass.Is_Highest__c=false;
                updateClassList.add(newClass);
                   //System.debug('hHello');

 }
           }
      //  System.debug(updateClassList);
      //  System.debug(updateCollegeList);
        update updateClassList;
        update clgMap.values();
        
    }
  
}