<cfcomponent displayname="admindashboardservice">		
	
	<cffunction name="init" access="public" output="false" returntype="admindashboardservice" hint="I create an initialized admin dashboard service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getadmindashboard" output="false" returntype="query" access="remote" hint="I get the data for the admin dashboard.">
		<cfset var admindfashboard = "" />
			<cfquery name="admindashboard">
					select count(stateid) as statestotal,
						 (select count(confid) from dbo.conferences ) as conferencestotal,
						 (select count(teamid) from dbo.teams) as teamstotal,
						 (select count(fieldid) from dbo.fields) as fieldstotal,
						 (select count(shooterid) from dbo.shooters) as shooterstotal,
						 (select count(gameid) from dbo.games) as gamestotal,
						 (select count(userid) from dbo.users) as userstotal
						 from dbo.states
			</cfquery>
		<cfreturn admindashboard>
	</cffunction>			
			
</cfcomponent>