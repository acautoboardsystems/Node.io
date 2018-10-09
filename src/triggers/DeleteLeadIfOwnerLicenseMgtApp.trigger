trigger    DeleteLeadIfOwnerLicenseMgtApp  on Lead (before insert) {


//If(Trigger.Isinsert && Trigger.Isupdate){
//mcc.DoNotDelete__c = False;
//{"Default Value for the Boolean is False"}

List<Lead> Lldd = [SELECT Id, OwnerId FROM Lead WHERE DoNotDelete__c = false AND OwnerId = '005370000011vYz'];

    for(Lead le : Trigger.new){

        if(le.DoNotDelete__c != true){
        
            
                                                  
            delete Lldd;
        }

  }// for loop
}