@isTest

public class DeleteTriggerTest {

    public static testMethod void Test(){
    

List<Lead> le = [SELECT Id, OwnerId,CreatedById,Lead_Inbound_Outbound__c, CreatedDate FROM
                                                  Lead WHERE DoNotDelete__c = false AND OwnerId = '005370000011vYz'];
                                                  
  Lead l = new Lead();
  l.DoNotDelete__c = false;
  l.LastName = 'xyzs';
  l.Company = 'ABCS';
  l.Status = 'Pre-MQL';
  l.LeadSource = 'Webform';
  l.Lead_Inbound_Outbound__c='SDR Outbound';
  l.Secondary_Lead_Source__c = 'Direct';
  
  test.startTest();
  insert l; 
  delete l;
  test.stopTest();

}
}