public with sharing class SlackOpportunityPush {
    
    
    // To publish Opportunity values in form of a String//
    public static final String slackURL = 'https://hooks.slack.com/services/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';



     
    public class Oppty {
        @InvocableVariable(label='Opportunity Name')
        public String opptyName;
        
        @InvocableVariable(label='Owner')
        public String Owner;
        
        @InvocableVariable(label='Opportunity Amount')
        public String Amount;
        
        @InvocableVariable(label='Account Development Owner')
        public String AccountDE;
        
        @InvocableVariable(label='Account')
        public String Account;
        
        
    }
     
    @InvocableMethod(label='Push to Slack')
    
    public static void postToSlack(List<Oppty> oppties) { 
        Oppty o = oppties[0]; // If bulk, only post first to avoid overloading Slack channel
        Map<String,Object> msg = new Map<String,Object>();
        msg.put('text',  '\n Time to celebrate!  Congrats to ' +o.Owner +   '\n and  '+ o.AccountDE  +  '\n who just closed a deal with ' + o.Account + ' \n for  $ ' + o.Amount);
        
        
     
        System.debug('Called msg.put');
        System.debug('OpportunityOwner '+o.Owner);
        System.debug('OpportunityAccount '+o.Account);
        System.debug('OpportunityAmount '+o.Amount);
        
        
        msg.put('mrkdwn',true);
        String body = JSON.serialize(msg);    
        System.enqueueJob(new QueueableSlackCall(slackURL,'POST',body));
    
    
    
    }
     
    public class QueueableSlackCall implements System.Queueable, Database.AllowsCallouts {
         
        public final String url;
        public final String method;
        public final String body;
         
        public QueueableSlackCall(String url,String method,String body) {
            this.url = url;
            this.method = method;
            this.body = body;
        }
         
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method);
            req.setBody(body);
            Http http = new Http();
            HttpResponse res = http.send(req);
 }
        
        public HttpResponse respond(HttpRequest request) 
{
            
									
            HttpResponse res = new HttpResponse();
            if (Test.isRunningTest()) { 
            return res;
        } else{
            return null;
 
    }
}
    }
}