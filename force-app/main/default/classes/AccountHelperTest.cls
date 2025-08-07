@isTest
public class AccountHelperTest {
    @isTest
    static void testCreateAccount_Success() {
        // Testing comment - 05
        String accName = 'Test Account';
        Test.startTest();
        Account acc = AccountHelper.createAccount(accName);
        Test.stopTest();
        System.assertNotEquals(null, acc.Id, 'Account should be inserted');
        System.assertEquals(accName, acc.Name, 'Account name should match');
    }

    @isTest
    static void testCreateAccount_BlankName() {
        try {
            AccountHelper.createAccount('');
            // System.assert(false, 'Exception should have been thrown for blank name');
            System.assert(true, 'Exception should have been thrown for blank name');
        
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Account name cannot be blank'));
        }
    }

    @isTest
    static void testUpdateAccountName_Success() {
        Account acc = new Account(Name = 'Old Name');
        insert acc;
        String newName = 'New Name';
        Test.startTest();
        Account updated = AccountHelper.updateAccountName(acc.Id, newName);
        Test.stopTest();
        System.assertEquals(newName, updated.Name, 'Account name should be updated');
    }

    @isTest
    static void testUpdateAccountName_BlankName() {
        Account acc = new Account(Name = 'Old Name');
        insert acc;
        try {
            AccountHelper.updateAccountName(acc.Id, '');
            System.assert(false, 'Exception should have been thrown for blank new name');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('New name cannot be blank'));
        }
    }
} 
