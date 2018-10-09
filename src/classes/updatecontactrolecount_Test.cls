@isTest
private class updatecontactrolecount_Test {
    
    static testMethod void TestAccount()
    {     
        Round_Robin_Setup__c robinsetup = new Round_Robin_Setup__c();
            robinsetup.Type__c = 'Account';
            robinsetup.Next_Assignee__c = 0;
         insert robinsetup;
         
        Round_Robin_Assignee__c robinassign = new Round_Robin_Assignee__c();
        robinassign.Round_Robin_Setup__c  = robinsetup.id;
        insert robinassign;
           
         Id p = [select id from profile where name='System Administrator'].id;

        User user = new User(alias = 'test123', email='test123comm@example.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                UserRole = [Select id From userrole  LIMIT 1],
                timezonesidkey='America/NEW_YORK', username='test123comm@exam.com'); 

        insert user;
        
        Round_Robin_Setup__c robinsetup2 = new Round_Robin_Setup__c();
        robinsetup2.Type__c = 'Opportunity';
        robinsetup2.Next_Assignee__c = 0;
        insert robinsetup2;
        Round_Robin_Assignee__c robinassign2 = new Round_Robin_Assignee__c();
        robinassign2.Round_Robin_Setup__c  = robinsetup2.id;
        robinassign2.Owner__c = user.id;
        insert robinassign2;
        
              
     
        
                
       Id recId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('New or Add-On').getRecordTypeId();
       Opportunity Opp = new Opportunity();
       Opp.Number_of_Contacts_Roles_Assigned__c=2;
        Opp.Name='Test';
        Opp.OwnerID=user.Id;
        Opp.StageName='00 - Qualification';
        Opp.CloseDate=System.today().addDays(6);
        Opp.Secondary_Lead_Source__c = 'Organic';
        Opp.Opportunity_Inbound_Outbound__c = 'SDR Outbound';
        Opp.LeadSource='Chat';
        Opp.RecordTypeId = recId;
        Opp.AccountID =  System.Label.Live_Account_ID;
          
        insert Opp;
 
      System.assertEquals(2, Opp.Number_of_Contacts_Roles_Assigned__c); 
    }   
}