@isTest
public class LeadAutoAssignerTest {

    @isTest
    static void testAssignLeads_AllBranches() {
        // Step 1: Create queues
        List<Group> queues = new List<Group>{
            new Group(Name = LeadAutoAssigner.APAC_QUEUE, Type = 'Queue'),
            new Group(Name = LeadAutoAssigner.EMEA_QUEUE, Type = 'Queue'),
            new Group(Name = LeadAutoAssigner.AMER_QUEUE, Type = 'Queue')
        };
        insert queues;

        // Step 2: Associate queues with Lead object
        List<QueueSobject> queueSobjects = new List<QueueSobject>();
        for (Group g : queues) {
            queueSobjects.add(new QueueSobject(QueueId = g.Id, SObjectType = 'Lead'));
        }
        insert queueSobjects;

        // Step 3: Create test leads for each branch
        List<Lead> leads = new List<Lead>{
            new Lead(LastName='APAC Lead', Company='Test Co', Country='India'), // APAC
            new Lead(LastName='EMEA Lead', Company='Test Co', Country='France'), // EMEA
            new Lead(LastName='AMER Lead', Company='Test Co', Country='United States'), // AMER
            new Lead(LastName='Other Lead', Company='Test Co', Country='Brazil') // No match
        };
        insert leads;

        Test.startTest();
        LeadAutoAssigner.assignLeads(new List<Id>{
            leads[0].Id, leads[1].Id, leads[2].Id, leads[3].Id
        });
        Test.stopTest();

        // Step 4: Verify OwnerId assignment for known countries
        Map<String, Id> countryToQueueId = new Map<String, Id>{
            'India' => queues[0].Id,
            'France' => queues[1].Id,
            'United States' => queues[2].Id
        };

        leads = [SELECT Id, Country, OwnerId FROM Lead WHERE Id IN :leads];
        for (Lead l : leads) {
            if (countryToQueueId.containsKey(l.Country)) {
                System.assertEquals(countryToQueueId.get(l.Country), l.OwnerId,
                    'Lead for ' + l.Country + ' should be assigned to correct queue.');
            } else {
                System.assertNotEquals(null, l.Id); // Just a sanity check for "other" branch
            }
        }

        // Step 5: Cover printBuffer() method
        LeadAutoAssigner.printBuffer();
    }

    @isTest
    static void testLegacyAssign() {
        // Create a test lead with India country for legacy method
        Lead legacyLead = new Lead(LastName='Legacy Lead', Company='Test Co', Country='India');
        insert legacyLead;

        Test.startTest();
        LeadAutoAssigner.legacyAssign(legacyLead);
        Test.stopTest();

        // Verify that the owner is now the current user
        legacyLead = [SELECT OwnerId FROM Lead WHERE Id = :legacyLead.Id];
        System.assertEquals(UserInfo.getUserId(), legacyLead.OwnerId,
            'Legacy assign should set owner to current user.');
    }

    @isTest
    static void testGetQueueId_NoMatch() {
        // Create a queue unrelated to LeadAutoAssigner constants
        Group unrelatedQueue = new Group(Name='UnrelatedQueue', Type='Queue');
        insert unrelatedQueue;

        List<Group> queues = [SELECT Id, Name FROM Group WHERE Id = :unrelatedQueue.Id];

        // Should return null since name doesn't match
        Id result = LeadAutoAssigner.getQueueId('NonExistingQueue', queues);
        System.assertEquals(null, result, 'Should return null if no queue matches.');
    }
}
