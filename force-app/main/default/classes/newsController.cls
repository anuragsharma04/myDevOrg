public with sharing class newsController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getNews(String type, String country) {
        HttpRequest httpRequest = new HttpRequest();
       
        String endpoint = 'https://newsapi.org/v2/top-headlines?country=' + country + '&category=' + type + '&apiKey=273454e1bf0f47a19045da68962913e4';
        httpRequest.setEndpoint(endpoint);
        httpRequest.setMethod('GET');
        Map<String, Object> newsJsonData = new Map<String, Object>();
        String strResponse = null;
        try {
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            if(httpResponse.getStatusCode() == 200) {
                strResponse = httpResponse.getBody();
            } else {
                throw new CalloutException(httpResponse.getBody());
            }
        } catch(Exception e) {
            throw e;
        }
        if(!String.isBlank(strResponse)) {
            newsJsonData = (Map<String, Object>) JSON.deserializeUntyped(strResponse);
        }
        return newsJsonData;
    }
}