public class SalesProcessor {

    public static void processSalesData(List<Opportunity> opps) {
        for (Opportunity o : opps) {
            if(o.StageName == 'Closed Won') {
                List<Account> accs = [SELECT Id, Name FROM Account WHERE Id = :o.AccountId];
                
                if(accs.size() > 0) {
                    ExternalPricingService eps = new ExternalPricingService();
                    Decimal discount = eps.getDiscountForAccount(accs[0].Id);

                    InventoryManager.adjustInventory(o.Id, discount);
                    o.Special_Discount__c = discount;
                    update o;
                }
            } else if(o.StageName == 'Prospecting') {
                o.Description = 'Still Prospecting...';
                update o;
            }
        }
        
        EmailUtility.sendNotificationToSalesTeam(opps);
    }
}
