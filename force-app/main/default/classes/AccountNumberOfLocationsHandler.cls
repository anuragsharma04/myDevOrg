public class AccountNumberOfLocationsHandler {
    public static void numberOfLocations(List<Account> accList){ System.debug('hiii');
       // List<Account> updateAccounts = new List<Account>();
        List<Contact> conList = new List<Contact>();                                                        
        Set<Id> accIds= new Set<Id>();
        for(Account ac: accList){
            accIds.add(ac.Id); System.debug('hello');
        } System.debug('Heyloo');
        for(Account acc:[SELECT Id,Name,NumberofLocations__c,(SELECT Id FROM Contacts)FROM Account WHERE Id IN :accIds]){
            System.debug('heyyaa');
            if(acc.NumberofLocations__c>acc.Contacts.size()){ System.debug('Holaa');
               Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName= acc.Name;                                           
                conList.add(con);
                  System.debug(acc);                                                                         
               } 
             }
        if(!conList.isEmpty()){                                                       
        insert conList;
        System.debug(conList);
        }
        
    }

}