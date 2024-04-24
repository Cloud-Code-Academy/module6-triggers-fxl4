trigger OpportunityTrigger on Opportunity (before update, after update, before delete) {
    // Question #5
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Opportunity opp : Trigger.new) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    // Question #6

    if (Trigger.isBefore && Trigger.isDelete) {   
        Boolean bankingAccount = false;
        Boolean oppIsClosedWon = false;
        for (Opportunity opp : Trigger.old) {
            if (opp.Account.Industry == 'Banking') {
                bankingAccount = true;
            }
            if (opp.StageName == 'Closed Won') {
                oppIsClosedWon = true;
            }
            if (bankingAccount && oppIsClosedWon) {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    } 

    // Question #7 



}