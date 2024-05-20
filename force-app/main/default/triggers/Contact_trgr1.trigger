trigger Contact_trgr1 on Contact (after insert, after update, after delete) {
   set<Id> accountId = new Set<Id>();
   Map<Id, Account> accMap = new Map<Id, Account>();
if(Trigger.isInsert || Trigger.isUpdate){
        List<Contact> contactUpdate = new List<Contact>();
        for(Contact con: Trigger.new){
            if(con.Is_Primary__c==true){
               accountId.add(con.AccountId);
                }
        }
  Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id,Primary_Contact__c FROM Account WHERE Id IN:accountId]);
        for(Contact con: Trigger.new){
            if(con.Is_Primary__c==true){
                if(accMap.containsKey(con.AccountId)){
 List<Contact> PreviousPrimaryContact =[SELECT Id,Is_Primary__c FROM Contact WHERE AccountId= :con.AccountId AND Is_Primary__c=true AND Id!= :con.Id];
                    for(Contact prevcon : PreviousPrimaryContact ){
                        prevcon.Is_Primary__c=false;
                        contactUpdate.add(prevcon);
                    }          
                accMap.get(con.AccountId).Primary_Contact__c=con.Id;
                } else{
                    if(!con.Is_Primary__c && accMap !=null){
                accMap.put(con.AccountId, new Account(Id=con.AccountId, Primary_Contact__c=null));
                        update contactUpdate;
                        update accMap.values();

                    }
                }
            } 
         
            
        update contactUpdate;
        update accMap.values();
        }
    if(Trigger.isDelete){
        for(Contact con:Trigger.old){
          if(accMap.containsKey(con.AccountId) && accMap.get(con.AccountId).Primary_Contact__c==con.Id ){
            accMap.get(con.AccountId).Primary_Contact__c= NULL;
            }
        }
        update accMap.values();
    }
}
}