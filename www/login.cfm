<cfif structKeyExists(form,"username") and structKeyExists(form,"password")>
	<cfquery name="getUser" dbtype="hql">
		from User
		where email=<cfqueryparam value="#form.userName#" />
		and password=<cfqueryparam value="#form.password#" />
	</cfquery>
	
	<cfif arraylen(getUser) eq 0>
		Invalid login!!!!
	<cfelse>
		<cflogin>
			<cfloginuser name="#getUser[1].getUserID()#" password="#getUser[1].getPassword()#" roles="" />
		</cflogin>
		<cflock timeout="10" scope="Session" >
			<cfset session.user={userid=getUser[1].getUserID()} />			
		</cflock>
		<cflocation url="./myprojects.cfm" addtoken="false" />
	</cfif>
	
</cfif>