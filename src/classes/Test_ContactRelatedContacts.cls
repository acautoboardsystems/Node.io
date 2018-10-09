@isTest (SeeAllData = false)

public class Test_ContactRelatedContacts {

    public static testMethod void FindoutHowmuch(){
         List<Profile> ps = [select id, name from Profile where  name = 'AE'];
        List<user> usrlst = new List<user>();
        for(integer i = 0;i<5;i++){
            User standard = new User(alias = 'standt'+i, AccountsCount__c = 0,
                                 email='standarduser'+i+'@testorg.com', 
                                 emailencodingkey='UTF-8', 
                                 lastname='Testing', languagelocalekey='en_US', 
                                 localesidkey='en_US', 
                                 profileid = ps[0].Id, 
                                 timezonesidkey='America/Los_Angeles', 
                                 username='standarduserzzi8'+i+'@testorg.com');
            usrlst.add(standard);
            
        } 
        insert usrlst;
         Round_Robin_Setup__c rrs = new Round_Robin_Setup__c(Name = 'account',Type__c = 'Account',
                                                           Special_Assignee__c = 4,Next_Assignee__c =1);
        insert rrs;
         Round_Robin_Setup__c rrs1 = new Round_Robin_Setup__c(Name = 'Opp',Type__c = 'Opportunity',
                                                           Special_Assignee__c = 4,Next_Assignee__c =1);
         insert rrs1;
        List<Round_Robin_Assignee__c> rralist = new List<Round_Robin_Assignee__c>();
        for(Integer i=0;i<5;i++){
            Round_Robin_Assignee__c rra = new Round_Robin_Assignee__c();
                 rra.Assignee_Id__c = i;
                rra.Round_Robin_Setup__c = rrs.id;
                rra.Owner__c = usrlst[i].Id;
             rralist.add(rra);
        }
        for(Integer i=0;i<5;i++){
            Round_Robin_Assignee__c rra = new Round_Robin_Assignee__c();
            rra.Assignee_Id__c = i;
            rra.Round_Robin_Setup__c = rrs1.id;
            rra.Owner__c = usrlst[i].Id;
            rralist.add(rra);
        }
           insert rralist;
        List<account> acs = new List<account>();
        for(integer i=1;i<8;i++){
            account ac = new account(name = 'test'+i,Website= 'test'+i);
            acs.add(ac);
        }
        insert acs;
        List<Opportunity> opps = new List<Opportunity>();
        Id recId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('New or Add-On').getRecordTypeId();
 
        for(integer i=1;i<4;i++){
            Opportunity opac = new Opportunity(name = 'test'+i,AccountId = acs[i-1].Id );
            opac.Opportunity_Inbound_Outbound__c = 'SDR Outbound';
            opac.stageName = '00-Qualification';
            opac.Secondary_Lead_Source__c = 'Organic';
            opac.CloseDate = system.today().adddays(+30);
            opac.RecordTypeId = recId;
            opac.LeadSource='Chat';
            opac.Secondary_Lead_Source__c='Direct';
            opps.add(opac);
        }
        Opportunity opac = new Opportunity(name = 'test',AccountId = acs[ 1].Id );
        opac.Opportunity_Inbound_Outbound__c = 'Inbound';
        opac.stageName = '00-Qualification';
        opac.CloseDate = system.today().adddays(+30);
        opac.RecordTypeId = recId;
        opac.LeadSource='Chat';
        opac.Secondary_Lead_Source__c='Conference';
        opps.add(opac);
        insert opps;
        
        Account ac01 = New Account();
        ac01.Name = 'abc';
        ac01.Website = 'www.google.com';
        ac01.Type = 'Prospect';
        insert ac01;
        
        Contact c01 = New Contact();
        c01.LastName = 'xyz';
        c01.AccountId = ac01.Id;
        c01.Title='Mr';
        c01.Email='a@b.com';
        c01.Lead_Class__c='Inbound';
        c01.LeadSource='Chat';
        c01.Secondary_Lead_Source__c='Direct';
        c01.Contact_Status__c='Pre-MQL';
        
        Contact c02 = New Contact();
        c02.LastName = 'xyz';
        c02.AccountId = ac01.Id;
        c02.Title='Mr';
        c02.Email='a@b.com';
        c02.Lead_Class__c='Inbound';
        c02.LeadSource='Chat';
        c02.Secondary_Lead_Source__c='Direct';
        c02.Contact_Status__c='Pre-MQL';
        
         Test.startTest();
            
            insert c01;
            update c01;
            insert c02;
            delete c01;
            update ac01;
        Test.StopTest();
        
        
    }
}