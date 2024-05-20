public with sharing class AccountListHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name,Phone,Industry FROM Account LIMIT 10];
        
    }
    @AuraEnabled
    public static void deleteAccounts(String acId){
        Id recordId = Id.valueOf(acId);
       DELETE new Account(Id=recordId);
        
    }
  
}