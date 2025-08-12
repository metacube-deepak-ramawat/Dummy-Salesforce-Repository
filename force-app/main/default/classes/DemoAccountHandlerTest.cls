@isTest
private class DemoAccountHandlerTest {

    @isTest
    static void testCreateAccount() {
        // Problem: No assertions, doesn't verify functionality
        DemoAccountHandler.createAccount('TestAcc', '1234567890');
    }

    @isTest
    static void testUpdatePhoneNumber() {
        Account a = new Account(Name = 'AccToUpdate');
        insert a;
        DemoAccountHandler.updatePhoneNumber(a.Id, '9999999999');
    }

    @isTest
    static void testGetAccountName() {
        Account a = new Account(Name = 'AccName');
        insert a;
        String name = DemoAccountHandler.getAccountName(a.Id);
    }
}
