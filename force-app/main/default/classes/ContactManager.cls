public with sharing class ContactManager {
    
    // Method to create a Contact with basic information
    public static Contact createContact(String firstName, String lastName, String email) {
        if (String.isBlank(firstName) || String.isBlank(lastName)) {
            throw new IllegalArgumentException('First name and last name are required');
        }
        
        if (String.isBlank(email) || !email.contains('@')) {
            throw new IllegalArgumentException('Valid email address is required');
        }
        
        Contact con = new Contact(
            FirstName = firstName,
            LastName = lastName,
            Email = email
        );
        insert con;
        return con;
    }
    
    // Method to update Contact email
    public static Contact updateContactEmail(Id contactId, String newEmail) {
        if (String.isBlank(newEmail) || !newEmail.contains('@')) {
            throw new IllegalArgumentException('Valid email address is required');
        }
        
        Contact con = [SELECT Id, Email FROM Contact WHERE Id = :contactId LIMIT 1];
        con.Email = newEmail;
        update con;
        return con;
    }
    
    // Method to get Contact by email
    public static Contact getContactByEmail(String email) {
        if (String.isBlank(email)) {
            throw new IllegalArgumentException('Email cannot be blank');
        }
        
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email = :email LIMIT 1];
        return contacts.isEmpty() ? null : contacts[0];
    }
    
    // Method to get all Contacts for an Account
    public static List<Contact> getContactsByAccount(Id accountId) {
        if (accountId == null) {
            throw new IllegalArgumentException('Account ID cannot be null');
        }
        
        return [SELECT Id, FirstName, LastName, Email, AccountId 
                FROM Contact 
                WHERE AccountId = :accountId 
                ORDER BY LastName, FirstName];
    }
    
    // Method to delete Contact
    public static void deleteContact(Id contactId) {
        if (contactId == null) {
            throw new IllegalArgumentException('Contact ID cannot be null');
        }
        
        Contact con = [SELECT Id FROM Contact WHERE Id = :contactId LIMIT 1];
        delete con;
    }
}
