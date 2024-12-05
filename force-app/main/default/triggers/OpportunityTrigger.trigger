trigger OpportunityTrigger on Opportunity (before update, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            // Question #5
            for (Opportunity opp : Trigger.new) {
                if (opp.Amount < 5000) {
                    opp.addError('Opportunity amount must be greater than 5000');
                }
            }
            // Question #7
            Set<Id> opportunityAccountIds = new Set<Id>();
            List<Contact> ceoContact = new List<Contact>();
    
            for (Opportunity opp : Trigger.new) {
                opportunityAccountIds.add(opp.AccountId);
            }
    
            List<Contact> ceoContacts = [SELECT Id, Name, Title, AccountId FROM Contact WHERE AccountId = :opportunityAccountIds AND Title = 'CEO'];
            Map<Id,Id> accountsAndContacts = new Map<Id,Id>();
            for (Contact c : ceoContacts) {
                accountsAndContacts.put(c.AccountId, c.Id);
            }
    
            // Assign the CEO contact as the primary contact if the AccountIds match
            for (Opportunity opp : Trigger.new) {
                opp.Primary_Contact__c = accountsAndContacts.get(opp.AccountId);
            }
        }
    
        // Question #6
        if (Trigger.isDelete) { 
            List<Opportunity> closedWonBankOpps = new List<Opportunity>();
            for (Opportunity opp : Trigger.old) {
                if (opp.Account.Industry == 'Banking' && opp.StageName == 'Closed Won') {
                    closedWonBankOpps.add(opp);
                    //opp.addError('Cannot delete closed opportunity for a banking account that is won');
                    //Assert.isTrue(opp.Account.Industry == 'Banking' && opp.StageName == 'Closed Won', 'Cannot delete closed opportunity for a banking account that is won');
                }
            }
        }
    }
}
