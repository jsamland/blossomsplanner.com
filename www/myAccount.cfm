
<cfset me=entityLoadByPK("User",session.user.userid) />

<cfif StructKeyExists(form,'submit')>
	<cftransaction action="begin">
		<cfscript>
			if( len(trim(form.password)) and form.password eq form.password2 )
				me.setPassword(hash(form.password));
			me.setFName(form.FName);
			me.setLName(form.LName);
			me.setEmail(form.Email);
		</cfscript>
	</cftransaction>
</cfif>

<cfoutput>
<form method="post">

First Name: <input type="text" name="fname" value="#me.getFName()#"/><br/>
Last Name: <input type="text" name="lname" value="#me.getLName()#"/><br/>
Email: <input type="text" name="email" value="#me.getEmail()#"/><br/>
Change Password: <input type="password" name="password"/><br/>
Password Confirm: <input type="password" name="password2"/><br/><br/>

<input type="submit" name="submit"/>

</form>
</cfoutput>