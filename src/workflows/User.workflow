<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Exceeded_250_owned_accounts</fullName>
        <description>Exceeded 250 owned accounts</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Sales_Development</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VP_Sales</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Exceeded_250_owned_accounts</template>
    </alerts>
    <rules>
        <fullName>Exceeded 250 owned accounts</fullName>
        <actions>
            <name>Exceeded_250_owned_accounts</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.AccountsCount__c</field>
            <operation>greaterOrEqual</operation>
            <value>250</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
