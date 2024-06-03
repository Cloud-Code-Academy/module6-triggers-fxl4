trigger OpportunityTrigger on Opportunity (before update, after update, before delete) {
    
    if (Trigger.isBefore && Trigger.isUpdate) {
        // Question #5
        for (Opportunity opp : Trigger.new) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
        // Question #7
        // Set of account Ids related to opps that were just updated
        /** List<Id> opportunityAccountIds = new List<Id>();

        // Add the account Ids to the set I created above
        for (Opportunity opp : Trigger.new) {
            opportunityAccountIds.add(opp.AccountId);
        }

        // Grab CEO contacts from accounts in Map above
        List<Contact> ceoContacts = [SELECT Id, Name, Title, AccountId FROM Contact WHERE AccountId = :opportunityAccountIds AND Title = 'CEO'];
        Map<Id,Id> accountsAndContacts = new Map<Id,Id>();
        for (Contact c : ceoContacts) {
            accountsAndContacts.put(c.AccountId, c.Id);
        }

        // Assign the CEO contact as the primary contact if the AccountIds match
        for (Opportunity opp : Trigger.new) {
            opp.Primary_Contact__c = accountsAndContacts.get(opp.AccountId);
        } */
    }

    // Question #6
    if (Trigger.isBefore && Trigger.isDelete) {   
        Account mainAccount;
        List<Opportunity> wonBankOpps = new List<Opportunity>();
        for (Opportunity opp : Trigger.old) {  
            mainAccount = opp.Account;  
            if (mainAccount.Industry == 'Banking' && opp.StageName == 'Closed Won') {
                wonBankOpps.add(opp);
            }
        }
        for (Opportunity listItem : wonBankOpps) {
            listItem.addError('Cannot delete closed opportunity for a banking account that is won');
        }
    }
}