public class OppTimerHandlerr{
    public static void opp(List<Opportunity> oppList){
        List<Opportunity> opplst=new List<Opportunity>();
        System.debug(oppList);
       // Integer add;
      // List<OpportunityFieldHistory> history = [Select Id, CreatedById, CreatedDate,Field, NewValue, OldValue from OpportunityFieldHistory Where Field = 'StageName'];
       // System.debug('hh'+history);
       for(Opportunity o: oppList){
        if(o.StageName=='Closed Won'){
            Opportunity op = new Opportunity();
            op.ClosedWonTime__c=  DateTime.Now();
            op.Name='StageTest';
            op.StageName='Qualification';
            op.CloseDate=system.today(); 
           // op.AccountId= '0015h00001YsbSvAAJ';
            System.debug('hi'+op);
            opplst.add(op);
        }
        if(o.StageName=='Prospecting'){
            Opportunity op =new Opportunity();
            DateTime startDateTime = DateTime.Now();

          DateTime targetDateTime = startDateTime.addSeconds(5);

        while(DateTime.Now() < targetDateTime)

           {
            op.ClosedWonTime__c= startDateTime;
            op.ClosedWonTime__c= targetDateTime;
          

             }
             
         System.debug('time'+op);
         
          opplst.add(op);

          system.debug('Operation started at: ' + startDateTime+'Operation ended at: ' + dateTime.Now());

      //  system.debug('Operation ended at: ' + dateTime.Now());


        }
       }
       System.debug('list'+opplst);
      // System.debug('list'+oppList);

       INSERT opplst;
      // UPDATE opplst;
       //System.debug('hello'+opplst);
    }
}