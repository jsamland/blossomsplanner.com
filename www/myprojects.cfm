﻿<cfset me=entityLoadByPK("User",getAuthUser()) />
<cfoutput>Welcome, #me.getFName()#</cfoutput>
<br/><br/>
search:<br/>
<a href="myAccount.cfm">My account</a><br/>
<a href="logout.cfm">Logout</a><br/>
<br/>
<a href="weddingForm.cfm">Doomed Wedding 1</a><br/>
<a href="weddingForm.cfm">Happy Wedding 23</a><br/>