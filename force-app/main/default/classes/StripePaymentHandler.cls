public class StripePaymentHandler {
    @future (callout=True)
    public static void stripePayment(Set<Id> payIds){
       // System.debug('hi');
        List<Payment__c> paymentList= new List<Payment__c>();
      //  System.debug('hello');
        for(Payment__c p:[SELECT Charge_ID__c FROM Payment__c WHERE Id IN: payIds ]){
          //  System.debug('hola');
        Http http=new Http();
        HttpRequest request =new HttpRequest();
        request.setEndpoint('https://api.stripe.com/v1/payment_intents');
        request.setMethod('POST');
        request.setHeader('Authorization','Bearer sk_test_51OZCrbSAGw6iGNWMopO7oxomlbmgX9bkfSh7QyFDycOGxEYJ8hXZBsXAxqs6ODL4fQv2bDJD9vUCDRfyEd64ehLa00WtybQf1Q');
        request.setBody('amount=1000&currency=usd&automatic_payment_methods[enabled]=true');
         HttpResponse response=http.send(request);
            response.getBody();
          //  System.debug(response.getBody());
        if(response.getStatusCode() == 200){
          //  System.debug('Heylo');
          Map<String,Object> results =(Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            Object idToWord = results.get('id');
            p.Charge_ID__c= String.valueOf(idToWord);
            paymentList.add(p);
          //  System.debug('bye');
            }
 }
        if(!paymentList.isEmpty()){
            update paymentList;
          //  System.debug(paymentList);
        }
    }

}