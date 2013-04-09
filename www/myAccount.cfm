<cfset me=entityLoadByPK("User",session.user.userid) />

<cfdump var="#me#" />