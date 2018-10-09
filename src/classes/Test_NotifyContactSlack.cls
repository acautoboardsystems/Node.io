@isTest

public class Test_NotifyContactSlack {

    static testmethod void NOtifySlack(){
     Test.setMock(HttpCalloutMock.class, new mockCallout());   
      List<NotifyContactSlack.Contact>requests= new List<NotifyContactSlack.Contact>();  
        
        NotifyContactSlack.Contact c = new NotifyContactSlack.Contact();
        c.Email = 'test@mail.com';
        c.Owner = 'testOwner';
        c.Account = 'testAccount';
        c.AccountDevelopmentOwner ='testOwner';
        c.Name = 'test test';
        c.ALink = 'https://xyz.com';
        c.CLink = 'https://xyz.com';
        
       requests.add(c);
        
        NotifyContactSlack.NotifySlack(requests);
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