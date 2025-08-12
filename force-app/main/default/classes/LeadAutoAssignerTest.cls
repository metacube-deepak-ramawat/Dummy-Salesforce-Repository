@isTest
private class LeadAutoAssignerTest {

    @isTest
    static void testAssignLeadToSpecificOwner() {
        // Setup test user
        User testUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];

        // Create a Lead meeting assignment condition
        Lead lead = new Lead(
            FirstName = 'Test',
            LastName = 'Lead',
            Company = 'Test Company',
            Status = 'New',
            Email = 'test@example.com'
        );
        insert lead;

        Test.startTest();
        // Call the method under test
        LeadAutoAssigner.assignLead(lead.Id, testUser.Id);
        Test.stopTest();

        // Verify owner was updated
        Lead updatedLead = [SELECT OwnerId FROM Lead WHERE Id = :lead.Id];
        System.assertEquals(testUser.Id, updatedLead.OwnerId, 'Lead should be assigned to the test user');
    }

    @isTest
    static void testAssignLeadNullInputs() {
        Test.startTest();
        // This should handle gracefully when Ids are null
        LeadAutoAssigner.assignLead(null, null);
        Test.stopTest();
        // No assert needed — just verifying no exception is thrown
    }

    @isTest
    static void testAssignLeadWithDifferentStatus() {
        // Setup test user
        User testUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];

        // Create a lead with a different status
        Lead lead = new Lead(
            FirstName = 'Another',
            LastName = 'Lead',
            Company = 'Other Company',
            Status = 'Working',
            Email = 'another@example.com'
        );
        insert lead;

        Test.startTest();
        LeadAutoAssigner.assignLead(lead.Id, testUser.Id);
        Test.stopTest();

        // Verify still assigned
        Lead updatedLead = [SELECT OwnerId FROM Lead WHERE Id = :lead.Id];
        System.assertEquals(testUser.Id, updatedLead.OwnerId);
    }
}
