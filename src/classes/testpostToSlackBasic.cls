@isTest (seeAllData=true)
public class testpostToSlackBasic{
 
    static testmethod void testpostToSlack(){
        Test.setMock(HttpCalloutMock.class, new mockCallout());
        
        List<SlackOpportunityPush.Oppty> requests = new List<SlackOpportunityPush.Oppty>();
        
        SlackOpportunityPush.Oppty r = new SlackOpportunityPush.Oppty();
        r.opptyName = 'Unit Test Opt';
        r.Owner = 'Unit Test Owner';
        r.Amount ='10000';
        r.AccountDE = 'Owner';
        r.Account = 'XYZ';
        
        requests.add(r);
        SlackOpportunityPush.postToSlack(requests);
       
    }
    
    public class mockCallout implements HttpCalloutMock {
        
        public HttpResponse respond(HttpRequest request) {
        HttpResponse res = new HttpResponse();
        res.setBody( '{"text":"value"}');
        res.setStatusCode(200);
        return res;
      
        }   
    }
}