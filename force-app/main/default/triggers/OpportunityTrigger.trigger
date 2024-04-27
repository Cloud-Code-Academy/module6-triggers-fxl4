trigger OpportunityTrigger on Opportunity (before update, after update, before delete) {
    
    if (Trigger.isBefore && Trigger.isUpdate) {
        // Question #5
        for (Opportunity opp : Trigger.new) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
        // Question #7
        Id contactAccountId;
        Id oppAccountId;
        List<Contact> ceoList = [SELECT Id, Name, Title, AccountId FROM Contact WHERE Title = 'CEO'];
        for (Opportunity o : Trigger.new) {
            oppAccountId = o.AccountId;
            for (Contact c : ceoList) {
                contactAccountId = c.AccountId;
                if (contactAccountId == oppAccountId) {
                    o.Primary_Contact__c = c.Id;
                }
            }
        }
        
    }

    // Question #6
    if (Trigger.isBefore && Trigger.isDelete) {   
        Boolean closedWonBankOpp = false;
        List<Opportunity> wonBankOppList = new List<Opportunity>();
        for (Opportunity opp : Trigger.old) {    
            if (opp.Account.Industry == 'Banking' && opp.StageName == 'Closed Won') {
                closedWonBankOpp = true;
            }
            wonBankOppList.add(opp);
        }
        for (Opportunity listItem : wonBankOppList) {
            listItem.addError('Cannot delete closed opportunity for a banking account that is won');
        }
    }
}