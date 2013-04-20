<cfset me=entityLoadByPK("User",getAuthUser()) />
<cfoutput>

Welcome, #me.getFName()#
<br/><br/>
search:<br/>
<br/>


<cfloop array="#request.orderList#" index="order">
	<a href="/index.cfm/order/#order.getOrderID()#">#order.getOrderName()#</a><br/>
</cfloop>

<br/>

<cfquery dbtype="hql" name="getForms">
from Form
where <!---ShopID=<cfqueryparam value="#session.user.ShopID#" cfsqltype="cf_sql_integer" />
	or---> ShopID is null
</cfquery>
<cfdump var="#getForms#"/>

</cfoutput>