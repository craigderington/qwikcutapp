

<!--- // kill all user session vars --->
<cfset mTeam = structdelete( session, "teamid" ) />
<cfset mUser = structdelete( session, "userid" ) />
<cfset mName = structdelete( session, "teamname" ) />
<cfset mCFID = structdelete( session, "CFID" ) />
<cflogout>
<cflocation url="#application.root#dashboard" addtoken="yes">