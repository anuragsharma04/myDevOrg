trigger Account_trgr on Account (after insert, after update) {
    static Set<Id> accIds = new Set<Id>();

    List<Opportunity> newOpportunities = new List<Opportunity>();

    for (Account acc : Trigger.new) {
        if (acc.Account_Type__c == 'Health_Welfare_Fund' && !accIds.contains(acc.Id)) {
            Opportunity newOpportunity = new Opportunity();
            newOpportunity.Name = 'Health & Welfare Opportunity';
            newOpportunity.StageName = 'Prospecting';
            newOpportunity.CloseDate = Date.today().addDays(30);
            newOpportunity.AccountId = acc.Id;

            newOpportunities.add(newOpportunity);

            accIds.add(acc.Id);
        }
    }

    if (!newOpportunities.isEmpty()) {
        insert newOpportunities;
    }
}