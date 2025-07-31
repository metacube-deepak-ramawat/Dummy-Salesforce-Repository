public with sharing class AccountHelper {
    // Method to create an Account
    // test comment for cirus
//hello this is a testing comment
    public static Account createAccount(String name) {
        // blank name check
        if (String.isBlank(name)) {
            throw new IllegalArgumentException('Account name cannot be blank');
        }
        Account acc = new Account(Name = name);
        insert acc;
        return acc;
    }

    // Method to update Account name
    // I am adding this comment just to create a PR
    public static Account updateAccountName(Id accountId, String newName) {
        // blank name check - test
        if (String.isBlank(newName)) {
            throw new IllegalArgumentException('New name cannot be blank');
        }
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Name = newName;
        update acc;
        return acc;
    }
} 
