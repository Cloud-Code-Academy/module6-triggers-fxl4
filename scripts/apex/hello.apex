/*
// Question 7
* Opportunity Trigger
* When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
* Trigger should only fire on update.
*/
        
List<Opportunity> oppList = [SELECT Id, Name, Primary_Contact__c, AccountId FROM Opportunity WHERE StageName = 'Closed Won'];

/** ----- DON'T USE THE ABOVE ----- */
Id contactAccountId;
Id oppAccountId;
List<Contact> ceoList = [SELECT Id, Name, Title, AccountId FROM Contact WHERE Title = 'CEO'];

//for (Opportunity o : Trigger.new) {
for (Opportunity o : oppList) {
    oppAccountId = o.AccountId;
    for (Contact c : ceoList) {
        contactAccountId = c.AccountId;
        if (contactAccountId == oppAccountId) {
            System.debug('Opportunity: ' + o.Name + '. Searching for CEO contact...');
            o.Primary_Contact__c = c.Id;
            System.debug('CEO identified: ' + c.Name + ', ' + c.Title + '.');
        }
    }
}



