trigger Account_trgr1 on Account (after insert, after Update) {
    List<Account> acclist = [SELECT Id, Name, Account_Type__c FROM Account];
    List<Opportunity> newOpportunities = new List<Opportunity>();
    Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>();

    for (Account acc : Trigger.new) {
        if (acc.Account_Type__c == 'Health_Welfare_Fund') {
            if (!opportunityMap.containsKey(acc.Id)) {
                Opportunity newOpportunity = new Opportunity();
                newOpportunity.Name = 'Health & Welfare Opportunity';
                newOpportunity.StageName = 'Prospecting';
                newOpportunity.CloseDate = Date.today().addDays(30);
                newOpportunity.AccountId = acc.Id;

                opportunityMap.put(acc.Id, newOpportunity);
                newOpportunities.add(newOpportunity);
            }
        }
    }

    if (!newOpportunities.isEmpty()) {
        insert newOpportunities;
    }
}