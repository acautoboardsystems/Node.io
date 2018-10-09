<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Close_Date_Has_Past_Email</fullName>
        <description>Close Date Has Past Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>greg@node.io</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Close_Date_Pass_on_Open_Opportunity</template>
    </alerts>
    <alerts>
        <fullName>Days_from_Initial_Meeting_Date_Email</fullName>
        <description>Days from Initial Meeting Date Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>greg@node.io</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Opp_Hasn_t_Been_Accepted_by_AE</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Greg_and_Falon</fullName>
        <description>Late Stage Email to Greg and Falon</description>
        <protected>false</protected>
        <recipients>
            <recipient>falon+sf@node.io</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>greg@node.io</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Late_Stage_Opportunity_Notification</template>
    </alerts>
    <alerts>
        <fullName>NO_Activity_on_Opp_Email</fullName>
        <description>NO Activity on Opp Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>greg@node.io</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/No_Activity_in_Last_7_Days</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_opportunity_owner</fullName>
        <description>Send email to opportunity owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Opportunity_Notification</template>
    </alerts>
    <alerts>
        <fullName>Stage_Hasn_t_Changed</fullName>
        <description>Stage Hasn&apos;t Changed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>greg@node.io</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Stage_Has_Not_Been_Changed_in_14_Days</template>
    </alerts>
    <alerts>
        <fullName>Update_Meeting_Reminder</fullName>
        <description>Update Meeting Reminder</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Update_Meeting_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Update_Meeting_Reminder_2_days</fullName>
        <description>Update Meeting Reminder</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Update_Meeting_Reminder</template>
    </alerts>
    <fieldUpdates>
        <fullName>Business_Case_To_Close</fullName>
        <description>Prints Track Changes field to solve for Business Case to Close Time</description>
        <field>Track_Changes__c</field>
        <formula>TODAY ()</formula>
        <name>Business Case To Close</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Created_by_Role_Static_Opp</fullName>
        <field>Created_by_Role_Static__c</field>
        <formula>CreatedBy.UserRole.Name</formula>
        <name>Created by Role (Static) - Opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Close_Date</fullName>
        <field>CloseDate</field>
        <formula>Today()</formula>
        <name>Update Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_Change_Date_to_Today</fullName>
        <field>Last_Stage_Change_Date__c</field>
        <formula>TODAY()</formula>
        <name>Update Stage Change Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Business Case Start Date</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>03 - Business Case</value>
        </criteriaItems>
        <description>The date when an opportunity has first advanced to Stage 03 - Business Case.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Close Date Pass on Open Opportunity Email</fullName>
        <actions>
            <name>Close_Date_Has_Past_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Days_from_Close_Date__c</field>
            <operation>equals</operation>
            <value>1,3,7</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>00 - Qualification,01 - Discovery,02 - Business Validation,03 - Customer Validation,04 - Manage to Close</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>New or Add-On</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Created by Role %28Static%29 - Opportunity</fullName>
        <actions>
            <name>Created_by_Role_Static_Opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISBLANK(Created_by_Role_Static__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email to Falon and Greg for Late Stage Opps</fullName>
        <actions>
            <name>Email_to_Greg_and_Falon</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Type</field>
            <operation>equals</operation>
            <value>New Customer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.AE_Accepted_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.ForecastCategoryName</field>
            <operation>equals</operation>
            <value>Best Case,Commit</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>No Activity on Opp Email</fullName>
        <actions>
            <name>NO_Activity_on_Opp_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Days_from_Last_Activity__c</field>
            <operation>equals</operation>
            <value>5,7,10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>New or Add-On</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Initial_Meeting_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notContain</operation>
            <value>00,Closed</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Opp Hasn%27t Been Accepted by AE Email</fullName>
        <actions>
            <name>Days_from_Initial_Meeting_Date_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Days_From_Initial_Meeting_Date__c</field>
            <operation>equals</operation>
            <value>1,3,7</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.AE_Accepted_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Initial_Meeting_Result__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>New or Add-On</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send email to Owner of new Opportunity</fullName>
        <actions>
            <name>Send_email_to_opportunity_owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>contains</operation>
            <value>00</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Stage Hasn%27t Changed Email</fullName>
        <actions>
            <name>Stage_Hasn_t_Changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Days_from_Last_Stage_Change__c</field>
            <operation>equals</operation>
            <value>14,21,28</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>New or Add-On</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Last Stage Change Date</fullName>
        <actions>
            <name>Update_Stage_Change_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(
ISNEW(),
ISCHANGED(StageName)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Meeting Reminder</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Initial_Meeting_Result__c</field>
            <operation>equals</operation>
            <value>Scheduled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Initial_Meeting_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>LAST 2 DAYS</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notEqual</operation>
            <value>04a - Closed Won,04b - Closed Lost</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Meeting_Reminder</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Initial_Meeting_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Meeting_Reminder_2_days</name>
                <type>Alert</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Meeting_Reminder_2_days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Initial_Meeting_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Opportunity Close Date</fullName>
        <actions>
            <name>Update_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>07a - Closed Won,07b - Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.CloseDate</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
