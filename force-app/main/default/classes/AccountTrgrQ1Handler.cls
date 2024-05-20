public class AccountTrgrQ1Handler {
    public static void  OnInsertAccount(List<Account> accountList){
       List<Opportunity> Opp = new List<Opportunity>();
        for(Account acc: accountList){
            if([SELECT count() FROM Opportunity WHERE AccountId= :acc.Id]==0){
                Opportunity newOpp = new Opportunity();
                newOpp.Name ='First Opportunity'+ acc.Name;
                newOpp.StageName = 'Prospecting';
                newOpp.CloseDate = Date.today().addDays(30);
                newOpp.AccountId = acc.Id;
                Opp.add(newOpp);
            }
        }
        if(!Opp.isEmpty()){
            insert Opp;
        }
    }

}