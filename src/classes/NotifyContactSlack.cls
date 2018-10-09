public class NotifyContactSlack {

    // To publish Contact values in form of a String//
 private static final String slackURL = 'https://hooks.slack.com/services/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';
     
 public class Contact {
        
        @InvocableVariable(label='Account_Development_Owner__c')
        public String AccountDevelopmentOwner;
        @InvocableVariable(label='Contact_Full_Name__c')
        public String Name;
        @InvocableVariable(label='Account_Owner__c')
        public String Owner;
        @InvocableVariable(label='	Account')  
        public String Account;
        @InvocableVariable(label='ALink__c')  
        public String ALink;
        @InvocableVariable(label='CLink__c')  
        public String CLink;
        @InvocableVariable(label='Email')  
        public String Email;
        
    }    
    
        @InvocableMethod(label='Notify Slack')
        public static void NotifySlack(List<Contact> Contact) {
        Contact a = Contact[0]; // If bulk, only post first to avoid overloading Slack channel
        Map<String,Object> msg = new Map<String,Object>();
       
        msg.put('text',  + ' \n '+'\n ***A contact has become marketing qualified for ' + a.AccountDevelopmentOwner + ' within  ' +a.Owner +  ' \'s  Account***'+ '\n'+ '\n' +'\n' +'Account Owner  : ' +a.Owner + '\n '+ 'Account Development Owner  : '+ a.AccountDevelopmentOwner +'\n '+'Account Name  : '+a.Account +'\n '+ a.ALink +'\n' + '\n'+'\n' + 'Contact Name  : '+a.Name +'\n'+ 'Contact Email  : '+a.Email +'\n'+  a.CLink);
        
        System.debug('Called msg.put');
        System.debug('Account_Development_Owner__c'+a.AccountDevelopmentOwner);
        System.debug('Name'+a.Name);
        System.debug('Owner'+a.Owner);
        System.debug('Account'+a.Account);
        System.debug('AccountLink'+a.ALink);
        System.debug('ContactLink'+a.CLink);
        System.debug('Email'+a.Email);
        
        
            
        msg.put('mrkdwn', true);
        String body = JSON.serialize(msg);    
        System.enqueueJob(new QueueableSlackCall(slackURL, 'POST', body));
     }
    
     
 public class QueueableSlackCall implements System.Queueable, Database.AllowsCallouts {
         
        private final String url;
        private final String method;
        private final String body;
         
 public QueueableSlackCall(String url, String method, String body) {
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
        
        
 public HttpResponse respond(HttpRequest request) {
            
                                    
            HttpResponse res = new HttpResponse();
            if (Test.isRunningTest()) { 
            return res;
            } else{
            return null;
 
            }
           
          }
       }
  }