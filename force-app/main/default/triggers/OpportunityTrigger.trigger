trigger OpportunityTrigger on Opportunity (before update, after update, before delete) {
    
    if (Trigger.isBefore && Trigger.isUpdate) {
        // Question #5
        for (Opportunity opp : Trigger.new) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
        // Question #7
        Set<Id> opportunityAccountIds = new Set<Id>();

        for (Opportunity opp : Trigger.new) {
            opportunityAccountIds.add(opp.AccountId);
        }

        for (Id oppAcctId : opportunityAccountIds) {
            System.debug(oppAcctId);
        }

        /** Map<Id,Account> accountMap = new Map<Id,Account>();
        accountMap = [SELECT Id, Name, (SELECT Id FROM Contacts WHERE Title = 'CEO') FROM Account WHERE Id IN :opportunityAccountIds]; */

        Map<Id,Account> accountMap = new Map<Id,Account>(
            [SELECT Id, Name, (SELECT Id FROM Contacts WHERE Title = 'CEO') FROM Account WHERE Id IN :opportunityAccountIds]
        );

        
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