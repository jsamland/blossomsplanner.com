<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">

<cfif thisTag.executionMode is "start">
	<cfinclude template="/layout/navHeader.cfm"/>
<cfelse>
	<cfinclude template="/layout/navFooter.cfm"/>
</cfif>

<cfsetting enablecfoutputonly=false>