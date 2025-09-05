@isTest
public class ContactManagerTest {
    
    @isTest
    static void testCreateContact_Success() {
        String firstName = 'John';
        String lastName = 'Doe';
        String email = 'john.doe@example.com';
        
        Test.startTest();
        Contact con = ContactManager.createContact(firstName, lastName, email);
        Test.stopTest();
        
        System.assertNotEquals(null, con.Id, 'Contact should be inserted');
        System.assertEquals(firstName, con.FirstName, 'First name should match');
        System.assertEquals(lastName, con.LastName, 'Last name should match');
        System.assertEquals(email, con.Email, 'Email should match');
    }
    
    @isTest
    static void testCreateContact_BlankFirstName() {
        try {
            ContactManager.createContact('', 'Doe', 'john.doe@example.com');
            System.assert(false, 'Exception should have been thrown for blank first name');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('First name and last name are required'));
        }
    }
    
    @isTest
    static void testCreateContact_InvalidEmail() {
        try {
            ContactManager.createContact('John', 'Doe', 'invalid-email');
            System.assert(false, 'Exception should have been thrown for invalid email');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Valid email address is required'));
        }
    }
    
    @isTest
    static void testUpdateContactEmail_Success() {
        Contact con = new Contact(FirstName = 'Jane', LastName = 'Smith', Email = 'jane.smith@example.com');
        insert con;
        
        String newEmail = 'jane.updated@example.com';
        Test.startTest();
        Contact updated = ContactManager.updateContactEmail(con.Id, newEmail);
        Test.stopTest();
        
        System.assertEquals(newEmail, updated.Email, 'Email should be updated');
    }
    
    @isTest
    static void testGetContactByEmail_Success() {
        Contact con = new Contact(FirstName = 'Alice', LastName = 'Johnson', Email = 'alice.johnson@example.com');
        insert con;
        
        Test.startTest();
        Contact found = ContactManager.getContactByEmail('alice.johnson@example.com');
        Test.stopTest();
        
        System.assertNotEquals(null, found, 'Contact should be found');
        System.assertEquals(con.Id, found.Id, 'Contact ID should match');
    }
    
    @isTest
    static void testGetContactByEmail_NotFound() {
        Test.startTest();
        Contact found = ContactManager.getContactByEmail('nonexistent@example.com');
        Test.stopTest();
        
        System.assertEquals(null, found, 'Contact should not be found');
    }
    
    @isTest
    static void testGetContactsByAccount_Success() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        Contact con1 = new Contact(FirstName = 'Bob', LastName = 'Wilson', Email = 'bob.wilson@example.com', AccountId = acc.Id);
        Contact con2 = new Contact(FirstName = 'Carol', LastName = 'Brown', Email = 'carol.brown@example.com', AccountId = acc.Id);
        insert new List<Contact>{con1, con2};
        
        Test.startTest();
        List<Contact> contacts = ContactManager.getContactsByAccount(acc.Id);
        Test.stopTest();
        
        System.assertEquals(2, contacts.size(), 'Should return 2 contacts');
    }
    
    @isTest
    static void testDeleteContact_Success() {
        Contact con = new Contact(FirstName = 'David', LastName = 'Lee', Email = 'david.lee@example.com');
        insert con;
        
        Test.startTest();
        ContactManager.deleteContact(con.Id);
        Test.stopTest();
        
        List<Contact> remainingContacts = [SELECT Id FROM Contact WHERE Id = :con.Id];
        System.assertEquals(0, remainingContacts.size(), 'Contact should be deleted');
    }
}
