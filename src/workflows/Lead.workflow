<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Update_Owner_when_HubSpot_Lifecycle_Stage_c_is_Marketing_Qualified</fullName>
        <description>Update Owner when HubSpot_Lifecycle_Stage__c is Marketing Qualified</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/LeadsNewassignmentnotification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Contact_Contacted_and_Disqualified_Unr</fullName>
        <field>Current_Prospect_Stage__c</field>
        <formula>TEXT ( Status )</formula>
        <name>Contact Contacted and Disqualified - Unr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Conversion_and_New_Opp_Creation</fullName>
        <field>Qualified_Lead_to_Contact_Mapping__c</field>
        <literalValue>Contacted and Sales Qualified - New Opportunity</literalValue>
        <name>Conversion and New Opp Creation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Created_by_Role_Static_Update_Lead</fullName>
        <field>Created_by_Role_Static__c</field>
        <formula>CreatedBy.UserRole.Name</formula>
        <name>Created by Role Static Update Lead</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Current_Sequence_Start_Date_lead_c</fullName>
        <description>Updates field when lead is actively being sequenced in Outreach</description>
        <field>Current_Sequence_Start_Date__c</field>
        <formula>NOW()</formula>
        <name>Current Sequence Start Date - Lead</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Status_to_MQL</fullName>
        <field>Status</field>
        <literalValue>MQL</literalValue>
        <name>Lead Status to MQL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Marketing_Qualified_to_Sales_Ready</fullName>
        <field>Status</field>
        <literalValue>Sales Ready - Not in Sequence</literalValue>
        <name>Marketing Qualified to Sales Ready</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_really_active_in_sequence</fullName>
        <description>Lead not active</description>
        <field>Status</field>
        <literalValue>Contacted and Disqualified - Unresponsive</literalValue>
        <name>Not really active in sequence</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Out_of_Sequence_Date</fullName>
        <field>Out_of_Sequence_Date__c</field>
        <formula>NOW()</formula>
        <name>Out of Sequence Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Re_assign_Junk_leads_to_Archive</fullName>
        <field>OwnerId</field>
        <lookupValue>Archive</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Re-assign Junk leads to Archive</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Rejected_Status_Update</fullName>
        <field>Status</field>
        <literalValue>Not Contacted and Disqualified - Not in Target Market</literalValue>
        <name>Sales Rejected Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_Added_to_Existing_Account</fullName>
        <field>Qualified_Lead_to_Contact_Mapping__c</field>
        <literalValue>Added to Existing Account - Not in Sequence</literalValue>
        <name>Status to Added to Existing Account</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Added to Account Convert Status Update</fullName>
        <actions>
            <name>Status_to_Added_to_Existing_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Added to Existing Account - Not in Sequence</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto-Delete Node Internal Lead</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead.OwnerId</field>
            <operation>equals</operation>
            <value>License Management App</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Created by Role %28Static%29 - Lead</fullName>
        <actions>
            <name>Created_by_Role_Static_Update_Lead</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISBLANK(Created_by_Role_Static__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Current Sequence Start</fullName>
        <actions>
            <name>Current_Sequence_Start_Date_lead_c</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Actively_Being_Sequenced__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Create a Timestamp for the date prospect was sequenced in Outreach making the “Actively Being Sequenced” True</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status to MQL on Timing - Future Opportunity</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Timing - Future Opportunity</value>
        </criteriaItems>
        <description>Lead Status to MQL on Timing - Future Opportunity</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Lead_Status_to_MQL</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Lead.Follow_Up_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>MQL Status Update</fullName>
        <actions>
            <name>Marketing_Qualified_to_Sales_Ready</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4</booleanFilter>
        <criteriaItems>
            <field>Lead.Salesforce_User__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Email</field>
            <operation>notContain</operation>
            <value>gmail.com,yahoo.com,hotmail.com,aol.com,mac.com,outlook.com,msn.com,yandex.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.nde__Node_Employee_Size__c</field>
            <operation>notEqual</operation>
            <value>1 - 10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Marketing Qualified</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Marketing Qualified Lead</fullName>
        <actions>
            <name>Update_Owner_when_HubSpot_Lifecycle_Stage_c_is_Marketing_Qualified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED( HubSpot_Lifecycle_Stage__c ),  ISPICKVAL(HubSpot_Lifecycle_Stage__c, &apos;Marketing Qualified Lead&apos;) ,
NOT (ISPICKVAL( LeadSource , &apos;SFDC-IN|Node.io&apos;)     )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Not Really Active in Sequence - Lead</fullName>
        <actions>
            <name>Not_really_active_in_sequence</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Lead.Actively_Being_Sequenced__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Current_Prospect_Stage__c</field>
            <operation>contains</operation>
            <value>In Sequence</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Sales Ready - In Sequence,Contacted - In Sequence</value>
        </criteriaItems>
        <description>Lead Not Really Active in Sequence</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Out of Sequence Date</fullName>
        <actions>
            <name>Out_of_Sequence_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Actively_Being_Sequenced__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Create a Timestamp for the date prospect was sequenced in Outreach making the “Actively Being Sequenced” False</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Prospect Stage Update Not active in sequence - Lead</fullName>
        <actions>
            <name>Contact_Contacted_and_Disqualified_Unr</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted and Disqualified - Unresponsive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Current_Prospect_Stage__c</field>
            <operation>notEqual</operation>
            <value>Contacted and Disqualified - Unresponsive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>notEqual</operation>
            <value>Marketing Qualified</value>
        </criteriaItems>
        <description>Prospect Stage Update Not active in sequence - Lead</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Re-assign Junk Leads to Archive</fullName>
        <actions>
            <name>Re_assign_Junk_leads_to_Archive</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Unqualified_Reason__c</field>
            <operation>equals</operation>
            <value>Junk/Bad Lead</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sales Rejected Status Update</fullName>
        <actions>
            <name>Sales_Rejected_Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Lead.Salesforce_User__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Email</field>
            <operation>contains</operation>
            <value>gmail.com,yahoo.com,hotmail.com,aol.com,mac.com,outlook.com</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Converted Status to Qualified Status</fullName>
        <actions>
            <name>Conversion_and_New_Opp_Creation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted and Sales Qualified - New Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
