trigger AccountTrigger on account (before insert, after insert) {
    if (Trigger.isInsert && Trigger.isBefore) {
        for (Account a : Trigger.new) {
            // Question #1 
            if (a.Type == null) {
                a.Type = 'Prospect';
            }
            // Question #2
            if (a.BillingStreet == null && 
                a.BillingCity == null && 
                a.BillingState == null && 
                a.BillingPostalCode == null && 
                a.BillingCountry == null &&
                a.ShippingStreet != null &&
                a.ShippingCity != null &&
                a.ShippingState != null &&
                a.ShippingPostalCode != null && 
                a.ShippingCountry != null) {
                a.BillingStreet = a.ShippingStreet;
                a.BillingCity = a.ShippingCity;
                a.BillingState = a.ShippingState;
                a.BillingPostalCode = a.ShippingPostalCode;
                a.BillingCountry = a.ShippingCountry;
            }
            // Question #3
            if (a.Phone != null && 
                a.Website != null && 
                a.Fax != null &&
                a.Rating != 'Hot') {
                a.Rating = 'Hot';
            }
        }
    }
    if (Trigger.isInsert && Trigger.isAfter) {
        List<Contact> conList = new List<Contact>();
        for (Account acc : Trigger.new) {
            // Question #4
            Contact con = new Contact();
            con.LastName = 'DefaultContact';
            con.Email = 'default@email.com';
            con.AccountId = acc.Id;
            conList.add(con);
            System.debug(con);
        }
        insert conList;
    }
}
