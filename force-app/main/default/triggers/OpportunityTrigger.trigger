trigger OpportunityTrigger on Opportunity (before update, after update, before delete) {
    // Question #5
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Opportunity opp : Trigger.new) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
    /** 
    // Question #6 - Failing. System is expecting an error and not getting one?

    if (Trigger.isBefore && Trigger.isDelete) {   
        Boolean bankingAccount = false;
        Boolean oppIsClosedWon = false;
        //for (Opportunity opp : Trigger.new) {
        for (Opportunity opp : Trigger.old) {
            if (opp.Account.Industry == 'Banking') {
                bankingAccount = true;
            }
            if (opp.StageName == 'Closed Won') {
                oppIsClosedWon = true;
            }
            if (bankingAccount && oppIsClosedWon) {
                //opp.addError('Cannot delete closed opportunity for a banking account that is won'); didn't work with new or old
                //System.assert(true, 'Cannot delete closed opportunity for a banking account that is won'); didn't work with new or old
                throw new IllegalArgumentException('Cannot delete closed opportunity for a banking account that is won'); straight up doesn't work
            }
        }
    }    */

    // Question #7 - can't figure out how to deploy the custom field. 
    // I can see the field in object manager after deploying it.

    if (Trigger.isAfter && Trigger.isUpdate) {
        for (Opportunity opp : Trigger.new) {
            Account oppAcc = opp.Account;
            Contact ceoCon = [SELECT Id FROM Contact WHERE AccountId = :oppAcc.Id AND Title = 'CEO' LIMIT 1];
            //opp.Primary_Contact__c = ceoCon;
        }
    } 


}