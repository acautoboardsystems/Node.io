trigger tocountaccount on Account (before insert, after insert/*, after update*/)
{
    if(Trigger.isBefore && Trigger.isInsert){
        system.debug('@@@@@@@@@@@@@@@');
        Integer num ;
        List<Round_Robin_Setup__c>  rrs = [SELECT Id,Next_Assignee__c, Special_Assignee__c, 
                                           Total_Size__c, Type__c 
                                           FROM Round_Robin_Setup__c where Type__c = 'Account' Limit 1];
        List<Round_Robin_Assignee__c>  rra = [SELECT Id, Assignee_Id__c, Owner__c 
                                              FROM Round_Robin_Assignee__c WHERE Round_Robin_Setup__c =: rrs[0].Id];
        Map<Integer,Id> rrMap = new Map<Integer,Id>();
        Set<String> ownIds = new Set<String>();
        for(Round_Robin_Assignee__c ra:rra){
            rrMap.put(Integer.valueOf(ra.Assignee_Id__c), ra.Owner__c);
            ownIds.add(ra.Owner__c);
        }
         system.debug(rrMap);
        if(rrs[0].Special_Assignee__c != 0){
            num = Integer.valueOf(rrs[0].Special_Assignee__c) ;
            rrs[0].Special_Assignee__c = 0;
        }else {
            num = Integer.valueOf(rrs[0].Next_Assignee__c) ;
        }
        system.debug('num'+num);
        for(Account acc: Trigger.New){
           // if(!ownIds.contains(acc.OwnerId)){
             if(!acc.Assign_Manually__c){    
                system.debug('num'+num);
                if(num >  rra.size()){
                    num = 1;
                    system.debug('num'+num);
                }
                if(rrMap.containsKey(num)){
                    acc.OwnerId = rrMap.get(num);
                }
                if(num!=null){
                num++; 
                }
            }
         } 
        if(num >  rra.size()){
             num = 1;
            system.debug('num'+num);
        }
        //num--;
         rrs[0].Next_Assignee__c = num ;
        update rrs;
    }else{ 
                system.debug('##########');
        set<id> setid=new set<id>();
         for(account con:trigger.new)
        {
            setid.add(con.OwnerId);
        }
        Map<id,user> listuser=new Map<id,user>([SELECT id, AccountsCount__c FROM User where id IN : setid]);

        for(account con:trigger.new)
        {
                User ur1= new User();
                ur1=listuser.get(con.OwnerId);
                 if(con.Open_Opportunity_Count__c==0){
                     if(ur1.AccountsCount__c ==  null){
                         ur1.AccountsCount__c = 0;
                     }
                    ur1.AccountsCount__c=ur1.AccountsCount__c+1;
                    listuser.put(ur1.Id,ur1);
                }
         }
       update listuser.values();
    }
}