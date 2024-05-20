public class StripeHandler {
    @future (callout=True)
    public static void stripeCustomerId(Set<Id> acIds){
      //  System.debug('Heyyaaaaa');
        List<Account> acList= new List<Account>();
      //  System.debug('Heyy');
        for(Account ac:[SELECT Id,Customer_ID__c FROM Account WHERE Id IN :acIds]){
          //  System.debug('Helo');
        Http http = new Http(); 
      //  System.debug('hi');
        HttpRequest request= new HttpRequest();
              //  System.debug('hii');
 request.setEndpoint('https://api.stripe.com/v1/customers');
 request.setMethod('POST');
  request.setHeader('Authorization','Bearer sk_test_51OZCrbSAGw6iGNWMopO7oxomlbmgX9bkfSh7QyFDycOGxEYJ8hXZBsXAxqs6ODL4fQv2bDJD9vUCDRfyEd64ehLa00WtybQf1Q');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
           // System.debug('Heyyloo');
            Map<String,Object> results =(Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            System.debug(results);
            Object idToword = results.get('id');
            ac.Customer_ID__c= String.valueOf(idToword);
            acList.add(ac);
           // System.debug(ac);

             }
           // acList.add(ac);
        } if(!acList.isEmpty()){ 
       update acList;
       // System.debug(acList);
    }
    }
}