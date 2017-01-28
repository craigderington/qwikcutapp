<cfcomponent displayname="admindashboardservice">		
	
	<cffunction name="init" access="public" output="false" returntype="admindashboardservice" hint="I create an initialized admin dashboard service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getadmindashboard" output="false" returntype="struct" access="remote" hint="I get the data for the admin dashboard.">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		
			<cfquery name="adminstates">
				select count(stateid) as totalstates
				  from states						 
			</cfquery>
			
			<cfquery name="adminconferences">
				select count(confid) as totalconferences
				  from dbo.conferences
				 where stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="adminteams">
				select count(t.teamid) as totalteams
				  from dbo.teams t, conferences c
				 where t.confid = c.confid
				   and c.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="adminfields">
				select count(fieldid) as totalfields
				  from dbo.fields 
				 where stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
				   and fieldid <> <cfqueryparam value="155" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="adminshooters">
				select count(shooterid) as totalshooters
				  from dbo.shooters
				 where shooterstateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="adminusers">
				select count(userid) as totalusers
				  from dbo.users
				 where stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="admingames">
				select count(gameid) as totalgames
				  from dbo.games g, fields f
				 where g.fieldid = f.fieldid
				   and f.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="alerts">
				select count(alertid) as totalalerts
				  from alerts				 
			</cfquery>

				<cfset admindashboard = structnew() />
				<cfset states = structinsert( admindashboard, "totalstates", adminstates.totalstates ) />
				<cfset conferences = structinsert( admindashboard, "totalconferences", adminconferences.totalconferences ) />
				<cfset teams = structinsert( admindashboard, "totalteams", adminteams.totalteams ) />
				<cfset games = structinsert( admindashboard, "totalgames", admingames.totalgames ) />
				<cfset fields = structinsert( admindashboard, "totalfields", adminfields.totalfields ) />
				<cfset shooters = structinsert( admindashboard, "totalshooters", adminshooters.totalshooters ) />
				<cfset users = structinsert( admindashboard, "totalusers", adminusers.totalusers ) />
				<cfset alerts = structinsert( admindashboard, "totalalerts", alerts.totalalerts ) />
			
		<cfreturn admindashboard>
	</cffunction>		
</cfcomponent>