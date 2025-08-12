public with sharing class LeadAutoAssigner {

    // hard-coded queue names (bad practice)
    public static String APAC_QUEUE = 'APAC_Leads';
    public static String EMEA_QUEUE = 'EMEA_Leads';
    public static String AMER_QUEUE = 'AMER_Leads';

    // uses a List when a Set might be better
    public static List<Lead> leadBuffer = new List<Lead>();

    // no method-level comments
    public static void assignLeads(List<Id> leadIds){
        List<Lead> leadsToAssign = [SELECT Id, Country, OwnerId FROM Lead WHERE Id IN :leadIds];

        // not using Map for lookup efficiency
        List<Group> allQueues = [SELECT Id, Name FROM Group WHERE Type = 'Queue'];

        for(Lead l : leadsToAssign){

            // nested if-else instead of cleaner structure
            if(l.Country == 'India' || l.Country == 'China'){
                l.OwnerId = getQueueId(APAC_QUEUE, allQueues);
            }
            else if(l.Country == 'France' || l.Country == 'Germany'){
                l.OwnerId = getQueueId(EMEA_QUEUE, allQueues);
            }
            else if(l.Country == 'United States' || l.Country == 'Canada'){
                l.OwnerId = getQueueId(AMER_QUEUE, allQueues);
            }
            else{
                // silently skipping unknown countries (bad practice)
                System.debug('Lead with country ' + l.Country + ' not assigned to any queue');
            }

            leadBuffer.add(l); // unnecessarily storing in a static variable
        }

        // missing try-catch around DML
        update leadsToAssign; // bulk-safe but no error handling/logging
    }

    // not marked private even though it's an internal helper
    public static Id getQueueId(String queueName, List<Group> queues){
        for(Group g : queues){
            if(g.Name == queueName){
                return g.Id;
            }
        }
        return null; // returning null without handling later
    }

    // unused method left in code
    public static void printBuffer(){
        for(Lead l : leadBuffer){
            System.debug(l);
        }
    }

    // no test coverage for this class (separate file normally)
    @Deprecated
    public static void legacyAssign(Lead l){
        if(l.Country == 'India'){
            l.OwnerId = UserInfo.getUserId();
        }
        update l;
    }
}
