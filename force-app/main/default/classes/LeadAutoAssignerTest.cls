@isTest
public class LeadAutoAssignerTest {

    // hardcoded country names (bad practice)
    public static String INDIA = 'India';
    public static String GERMANY = 'Germany';
    public static String USA = 'United States';

    // helper method that mixes setup and test logic (bad practice)
    public static List<Lead> createTestLeads(){
        List<Lead> leads = new List<Lead>();
        leads.add(new Lead(FirstName='Test1', LastName='Lead', Company='ABC', Country=INDIA));
        leads.add(new Lead(FirstName='Test2', LastName='Lead', Company='ABC', Country=GERMANY));
        leads.add(new Lead(FirstName='Test3', LastName='Lead', Company='ABC', Country=USA));
        insert leads;
        return leads;
    }

    // not splitting into multiple test methods (bad practice)
    @isTest static void testAssignLeads(){
        // Setup test queues
        List<Group> queues = new List<Group>{
            new Group(Name='APAC_Leads', Type='Queue'),
            new Group(Name='EMEA_Leads', Type='Queue'),
            new Group(Name='AMER_Leads', Type='Queue')
        };
        insert queues;

        // Create test leads
        List<Lead> testLeads = createTestLeads();

        // Call method under test
        Test.startTest();
        LeadAutoAssigner.assignLeads(new List<Id>{
            testLeads[0].Id, testLeads[1].Id, testLeads[2].Id
        });
        Test.stopTest();

        // Fetch updated leads
        testLeads = [SELECT Id, OwnerId, Country FROM Lead WHERE Id IN :testLeads];

        // No real assertions on correctness (bad practice)
        System.debug('Updated Leads: ' + testLeads);

        // Cover getQueueId null branch
        Id missingQueue = LeadAutoAssigner.getQueueId('NonExistingQueue', queues);
        System.assertEquals(null, missingQueue);

        // Cover printBuffer method
        LeadAutoAssigner.printBuffer();

        // Cover legacyAssign method
        Lead legacyLead = new Lead(FirstName='Legacy', LastName='Lead', Company='XYZ', Country=INDIA);
        insert legacyLead;
        LeadAutoAssigner.legacyAssign(legacyLead);
    }
}
