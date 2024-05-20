public class TransactionTriggerHandler {
    public static void paymentInsert(List<Transaction__c> transcList){
        // System.debug('HIIII'); 
        Set<Id> accIds = new Set<Id>();
        List<Account> accList=new List<Account>();
        for(Transaction__c t: transcList){
            // System.debug('Heloo');
            accIds.add(t.Id);
        }
        for(Transaction__c tr:[SELECT Id,Amount__c,Payment__c,AccountTransaction__c FROM Transaction__c WHERE Id IN:accIds ]){
            // System.debug('HEYYYY');
            if(tr.Payment__c=='Credit Account'){
                //  System.debug('HeYLOO');
                Account ac=new Account();
                ac.Id = tr.AccountTransaction__c;
                ac.TotalBalance__c= +tr.Amount__c;
                accList.add(ac);
                
            } else{
                
                // System.debug('BYYE');
                Account ac1=new Account();
                ac1.Id = tr.AccountTransaction__c;
                ac1.TotalBalance__c= -tr.Amount__c;
                accList.add(ac1);
            }
        }
        if(!accList.isEmpty()){
            // System.debug(accList);
            update accList;
            
        }
        
    }
    
}