<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_on_contacts_Hubspot_lifecycle_stage_changed</fullName>
        <description>Email Alert on contacts Hubspot lifecycle stage changed</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <field>Accounts_Account_Development_Owner__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Hubspot_MQL_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Accounts_Account_Development_Owner</fullName>
        <field>Accounts_Account_Development_Owner__c</field>
        <formula>AADO__c</formula>
        <name>Accounts Account Development Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Actively_Being_Sequenced_c</fullName>
        <field>Contact_Sequenced_Date__c</field>
        <formula>TODAY()</formula>
        <name>Actively_Being_Sequenced__c</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_Contacted_and_Disqualified_Unr</fullName>
        <description>Contacted and Disqualified - Unresponsive for Current Prospect Stage</description>
        <field>Current_Prospect_Stage__c</field>
        <formula>TEXT (Contact_Status__c)</formula>
        <name>Contact Contacted and Disqualified - Unr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_Status_to_MQL</fullName>
        <field>Contact_Status__c</field>
        <literalValue>MQL</literalValue>
        <name>Contact Status to MQL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contacted_and_Disqualified_Unresponsiv</fullName>
        <description>Contacted and Disqualified - Unresponsive ---- No longer in Sequence</description>
        <field>Contact_Status__c</field>
        <literalValue>Contacted and Disqualified - Unresponsive</literalValue>
        <name>Contacted and Disqualified - Unresponsiv</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Created_by_Role_Static_Contact</fullName>
        <field>Created_by_Role_Static__c</field>
        <formula>CreatedBy.UserRole.Name</formula>
        <name>Created by Role (Static) - Contact</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Current_Sequence_Start_Date</fullName>
        <description>Updates field when contact is actively being sequenced in Outreach</description>
        <field>Current_Sequence_Start_Date__c</field>
        <formula>NOW()</formula>
        <name>Current Sequence Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Out_of_Sequence_Date</fullName>
        <description>Out of sequence date</description>
        <field>Out_of_Sequence_Date__c</field>
        <formula>NOW ()</formula>
        <name>Out of Sequence Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_Node_Company_Description</fullName>
        <field>Node_Company_Description__c</field>
        <formula>Account.nde__Node_Company_Description__c</formula>
        <name>update Node Company Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change Contact Status to MQL</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>equals</operation>
            <value>Timing - Future Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Contact_Status_to_MQL</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contact.Follow_Up_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Created by Role Static Update Contact</fullName>
        <actions>
            <name>Created_by_Role_Static_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISBLANK(Created_by_Role_Static__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Current Sequence Start - Conact</fullName>
        <actions>
            <name>Current_Sequence_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Actively_Being_Sequenced__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Create a Timestamp for the date prospect was sequenced in Outreach making the “Actively Being Sequenced” True</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email Alert on contacts Hubspot lifecycle stage changed</fullName>
        <actions>
            <name>Email_Alert_on_contacts_Hubspot_lifecycle_stage_changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This will send an email when Contact Hubspot Lifecycle is changed to &quot;Marketing Qualified&quot;</description>
        <formula>AND(   ISCHANGED( HubSpot_Lifecycle_Stage__c ),  ISPICKVAL(HubSpot_Lifecycle_Stage__c, &apos;Marketing Qualified Lead&apos;)    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Node Company Description</fullName>
        <actions>
            <name>update_Node_Company_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Node_Company_Description__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Update Contact: Node company description from Account:Node Company Description</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Not Really Active in Sequence - Contact</fullName>
        <actions>
            <name>Contacted_and_Disqualified_Unresponsiv</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Actively_Being_Sequenced__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>notEqual</operation>
            <value>Marketing Qualified</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>equals</operation>
            <value>Sales Ready - In Sequence,Contacted - In Sequence</value>
        </criteriaItems>
        <description>Contact Not Really Active in Sequence</description>
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
            <field>Contact.Actively_Being_Sequenced__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Out of Sequence Date - for Contact</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Prospect Stage Update Not active in sequence - Contact</fullName>
        <actions>
            <name>Contact_Contacted_and_Disqualified_Unr</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>equals</operation>
            <value>Contacted and Disqualified - Unresponsive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Current_Prospect_Stage__c</field>
            <operation>notEqual</operation>
            <value>Contacted and Disqualified - Unresponsive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>notEqual</operation>
            <value>Marketing Qualified</value>
        </criteriaItems>
        <description>Prospect Stage Update Not active in sequence</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Actively Being Sequenced Date</fullName>
        <actions>
            <name>Actively_Being_Sequenced_c</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Actively Being Sequenced Date</description>
        <formula>ISCHANGED( Actively_Being_Sequenced__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Email field to Account Development Owner</fullName>
        <actions>
            <name>Accounts_Account_Development_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Accounts_Account_Development_Owner__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>There is an email field created so that we can alert Account Development Owner on some event , this workflow updates the email field .</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
