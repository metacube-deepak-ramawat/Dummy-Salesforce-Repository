public class DemoAccountHandler {

    public static void createAccount(String accName, String phoneNumber) {
        // Problem: SOQL inside a loop (will cause limits in bulk)
        for (Integer i = 0; i < 5; i++) {
            List<Account> existingAcc = [SELECT Id FROM Account WHERE Name = :accName];
            if (existingAcc.isEmpty()) {
                Account acc = new Account();
                acc.Name = accName;
                acc.Phone = phoneNumber;
                insert acc;
            }
        }
    }

    public static void updatePhoneNumber(Id accountId, String newPhone) {
        // Problem: No null checks, no error handling, no sharing keywords
        Account acc = [SELECT Id, Phone FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Phone = newPhone; // No validation on phone format
        update acc;
    }

    public static String getAccountName(Id accountId) {
        // Problem: Potential SOQL injection (string concatenation in query)
        String query = 'SELECT Name FROM Account WHERE Id = \'' + accountId + '\'';
        List<Account> accList = Database.query(query);
        if (!accList.isEmpty()) {
            return accList[0].Name;
        }
        return null;
    }
}
