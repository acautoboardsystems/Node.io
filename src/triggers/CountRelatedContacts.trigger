trigger CountRelatedContacts on Contact (before insert, after delete,after undelete,after update) {
 
    set<id> accId =new set<id>();
    
    List<Account> accountToUpdate = new List<Account>();
    
    
    if(trigger.isInsert){
        for(Contact c:trigger.new){
            accId.add(c.accountID);
 } }
    if(trigger.isUpdate|| trigger.isDelete ){
        for(Contact c:trigger.old){
            accId.add(c.accountID);
 } }
    Map<Id,Account> accountMap =new Map<Id,Account>
        ([select id,name,Contact_Count__c from  Account where Id IN: accId ]);
    
for(Account acc:[select id,name,Contact_Count__c,(Select id from Contacts Where Actively_Being_Sequenced__c=true) from Account where Id IN: accId]){
           accountMap.get(acc.id).Contact_Count__c = acc.Contacts.size();
           accountToUpdate.add(accountMap.get(acc.id));
 }
       update accountToUpdate;   
}