<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Account_Added_to_Sequence</fullName>
        <field>Account_Added_to_Sequence__c</field>
        <formula>NOW ()</formula>
        <name>Account Added to Sequence</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Out_of_to_Sequence</fullName>
        <field>Account_Out_of_Sequence__c</field>
        <formula>NOW ()</formula>
        <name>Account Out of to Sequence</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Status_change_Date</fullName>
        <field>Account_Status_Change_Date__c</field>
        <formula>TODAY ()</formula>
        <name>Account Status change Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Status_to_Customer</fullName>
        <field>Account_Status__c</field>
        <literalValue>Customer</literalValue>
        <name>Account Status to Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Status_to_Sales_Opportunity</fullName>
        <field>Account_Status__c</field>
        <literalValue>Sales Prospect - Has Open Opportunity</literalValue>
        <name>Account Status to Sales Opportunity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Created_by_Role_Static_Update_Account</fullName>
        <field>Created_by_Role_Static__c</field>
        <formula>CreatedBy.UserRole.Name</formula>
        <name>Created by Role Static Update Account</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethan_Carr</fullName>
        <field>OwnerId</field>
        <lookupValue>ethan@node.io</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Ethan Carr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Forest</fullName>
        <field>OwnerId</field>
        <lookupValue>forest@node.io</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Forest</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Status</fullName>
        <field>Account_Status__c</field>
        <literalValue>Sales Prospect - Actively Working</literalValue>
        <name>Update Account Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Status1</fullName>
        <field>Account_Status__c</field>
        <literalValue>Former Sales Prospect - Contacted and Disqualified</literalValue>
        <name>Update Account Status12</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Status_Act_in_Sequence</fullName>
        <field>Account_Status__c</field>
        <literalValue>Sales Prospect - Actively Working</literalValue>
        <name>Update Account Status - Act in Sequence</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Status_NoLngInSeq</fullName>
        <description>Account no longer in sequence</description>
        <field>Account_Status__c</field>
        <literalValue>Former Sales Prospect - Contacted and Disqualified</literalValue>
        <name>Update Account Status - NoLngInSeq</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Type_to_Customer</fullName>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <name>Update Account Type to Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_status_to_Customer</fullName>
        <description>Update Account status to Customer</description>
        <field>Account_Status__c</field>
        <literalValue>Customer</literalValue>
        <name>Update Account status to Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Account Added to Sequence</fullName>
        <actions>
            <name>Account_Added_to_Sequence</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Account_Status_Act_in_Sequence</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Contact_Count__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>Date the first contact was added to sequence.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Account Out of to Sequence</fullName>
        <actions>
            <name>Account_Out_of_to_Sequence</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Account_Status_NoLngInSeq</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Contact_Count__c</field>
            <operation>lessOrEqual</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Status__c</field>
            <operation>notEqual</operation>
            <value>Sales Prospect - Has Open Opportunity,Customer,Bad Data - No Longer in Business,Do Not Contact - Unsubscribed,Do Not Contact - Blacklisted,Marketing Qualified,Former Sales Prospect - Not in Target Market</value>
        </criteriaItems>
        <description>Date the last contact was removed from sequence.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Account Round Robin Assignment 1</fullName>
        <actions>
            <name>Ethan_Carr</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Account_New_RR_Assignmment_Id__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Assign_Manually__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Account Round Robin Assignment 2</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Account.Account_New_RR_Assignmment_Id__c</field>
            <operation>equals</operation>
            <value>2</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Assign_Manually__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Account Round Robin Assignment 4</fullName>
        <actions>
            <name>Forest</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Account_New_RR_Assignmment_Id__c</field>
            <operation>equals</operation>
            <value>4</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Assign_Manually__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Account Status Contacts In Sequence</fullName>
        <actions>
            <name>Update_Account_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Contact_Count__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Open_Opportunity_Count__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Status__c</field>
            <operation>notEqual</operation>
            <value>Customer</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Account Status Contacts In Sequence1</fullName>
        <actions>
            <name>Update_Account_Status1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Contact_Count__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Open_Opportunity_Count__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Status__c</field>
            <operation>equals</operation>
            <value>Sales Prospect - Actively Working</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Account Status change Date</fullName>
        <actions>
            <name>Account_Status_change_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Print Date on Account Status change</description>
        <formula>ISCHANGED( Account_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Account Status updated to Customer if</fullName>
        <actions>
            <name>Update_Account_status_to_Customer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Total_Won_Amount__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Total_Lost_Amount__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <description>Account Status updated to Customer if Total Won Amount is greater than 0.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Created by Role %28Static%29 - Account</fullName>
        <actions>
            <name>Created_by_Role_Static_Update_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISBLANK(Created_by_Role_Static__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Account Stage to Customer</fullName>
        <actions>
            <name>Account_Status_to_Customer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Customer_Won_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Status__c</field>
            <operation>notEqual</operation>
            <value>Customer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Customer_Won_Date__c</field>
            <operation>greaterThan</operation>
            <value>365 DAYS AGO</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Account Stage to Opportunity</fullName>
        <actions>
            <name>Account_Status_to_Sales_Opportunity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Open_Opportunity_Count__c</field>
            <operation>greaterOrEqual</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
