@isTest(seeAllData=true)
private class tocountaccount_Test
{
     
    static testMethod void TestAccount()
    { 
    Test.startTest();      
   // TestDataFactory.createTestRecords(5,3);
   Account a = [SELECT Id, Name FROM Account WHERE Name!='' LIMIT 1];

        System.assert(a != null);
         

        // Create a test account based on the queried account.
        Account testAccount = a.clone();

        testAccount.Name = 'Acme Test';
        testAccount.Website='www.google.com';

        insert testAccount;
        system.debug('----->'+testAccount.ID);

   
    Test.stopTest();
    }

    
 

    
    
    
}