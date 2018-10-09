trigger updatecontactrolecount on Opportunity (before insert, before update){
    if(Trigger.isBefore && Trigger.isInsert){
        Integer num ;
        Set<String> ownIds = new Set<String>();
        List<Round_Robin_Setup__c>  rrs = [SELECT Id,Next_Assignee__c, Special_Assignee__c, 
                                           Total_Size__c, Type__c 
                                           FROM Round_Robin_Setup__c where Type__c = 'Opportunity' Limit 1];
        List<Round_Robin_Assignee__c>  rra = [SELECT Id, Assignee_Id__c, Owner__c 
                                              FROM Round_Robin_Assignee__c WHERE Owner__c!='' AND Round_Robin_Setup__c =: rrs[0].Id];
        Map<Integer,Id> rrMap = new Map<Integer,Id>();
        for(Round_Robin_Assignee__c ra:rra){
            rrMap.put(Integer.valueOf(ra.Assignee_Id__c), ra.Owner__c);
            ownIds.add(string.valueof(ra.Owner__c).left(15));
        }
        system.debug(rrMap);
        if(rrs[0].Special_Assignee__c != 0){
            num = Integer.valueOf(rrs[0].Special_Assignee__c) ;
            rrs[0].Special_Assignee__c = 0;
        }else {
            num = Integer.valueOf(rrs[0].Next_Assignee__c) ;
        }
        system.debug('num'+num);
        
        for(Opportunity opp: Trigger.New ){
           /* if(opp.Opportunity_Inbound_Outbound__c == 'SDR Outbound' ||
               opp.Opportunity_Inbound_Outbound__c == 'AE Outbound'){
                   system.debug('sssss');
                    opp.ownerId = opp.AccountOwner__c ;
               }else if(opp.Opportunity_Inbound_Outbound__c == 'Inbound'){
                   if(!ownIds.contains(opp.AccountOwner__c)){
                       system.debug(opp.AccountOwner__c);
                       system.debug(ownIds);
                   system.debug('num'+num);
                   if(num >  rra.size()){
                       num = 1;
                       system.debug('num'+num);
                   }
                   if(rrMap.containsKey(num)){
                       opp.OwnerId = rrMap.get(num);
                   }
                   num++;
                   }else{
                        opp.ownerId = opp.AccountOwner__c ;
                   }*/
                   
                   if(!opp.Assign_Manually__c){    
                system.debug('num'+num);
                if(num >  rra.size()){
                    num = 1;
                    system.debug('num'+num);
                }
                if(rrMap.containsKey(num)){
                    opp.OwnerId = rrMap.get(num);
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
    }
    Boolean isPrimary; 
    Integer iCount;
    
    Map<String, Opportunity> oppty_con = new Map<String, Opportunity>();//check if the contact role is needed and add it to the oppty_con map
    for (Integer i = 0; i < Trigger.new.size(); i++) 
    {
        //oppty_con.put(Trigger.new[i].id,
        //Trigger.new[i]);      
    }
    isPrimary = False; 
    for (List<OpportunityContactRole> oppcntctrle :[select OpportunityId from OpportunityContactRole where (OpportunityContactRole.IsPrimary = True and OpportunityContactRole.OpportunityId in :oppty_con.keySet())])
    {
        if (oppcntctrle .Size() >0)
        {
            isPrimary = True;     
        }
    }
    iCount = 0;
    for (List<OpportunityContactRole> oppcntctrle2 : [select OpportunityId from OpportunityContactRole where (OpportunityContactRole.OpportunityId in :oppty_con.keySet())])//Query for Contact Roles
    {    
        if (oppcntctrle2 .Size()>0)
        {
            iCount= oppcntctrle2 .Size();     
        }
    }
    for (Opportunity Oppty : system.trigger.new) //Check if  roles exist in the map or contact role isn't required 
    {
        Oppty.Number_of_Contacts_Roles_Assigned__c = iCount;
        Oppty.Primary_Contact_Assigned__c =isPrimary; 
    }
}