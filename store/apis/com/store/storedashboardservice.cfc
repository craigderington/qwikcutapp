<cfcomponent displayname="">
	<cffunction name="init" access="public" returntype="storedashboardservice" output="false" hint="I initialize the store dashboard objects.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getrecentgames" access="public" returntype="query" output="false" hint="I get the list of random recent games">
		<cfargument name="sdate" type="date" required="yes">
		<cfargument name="edate" type="date" required="yes">
		<cfset var recentgames = "" />
			<cfquery name="recentgames">
				select top 5 g.gameid, g.vsid, g.gamedate, g.gamestart, t1.teamorgname as hometeam, t2.teamorgname as awayteam, tl.teamlevelname, f.fieldname
				  from games g, teams t1, teams t2, teamlevels tl, fields f
				 where g.hometeamid = t1.teamid
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and g.fieldid = f.fieldid 
				   and ( g.gamedate between <cfqueryparam value="#arguments.sdate#" cfsqltype="cf_sql_timestamp" />
				         and <cfqueryparam value="#arguments.edate#" cfsqltype="cf_sql_timestamp" />
						)
				order by newid()
			</cfquery>
		<cfreturn recentgames>
	</cffunction>
	
	<cffunction name="getlatestuploads" access="public" returntype="query" output="false" hint="I get the list of random latest uploads.">
		<cfargument name="sdate" type="date" required="yes">
		<cfargument name="edate" type="date" required="yes">
		<cfset var latestuploads = "" />
			<cfquery name="latestuploads">
				select top 5 g.gameid, g.vsid, g.gamedate, g.gamestart, t1.teamorgname as hometeam, t2.teamorgname as awayteam, tl.teamlevelname, f.fieldname
				  from games g, teams t1, teams t2, teamlevels tl, fields f
				 where g.hometeamid = t1.teamid
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and g.fieldid = f.fieldid 
				   and ( g.gamedate between <cfqueryparam value="#arguments.sdate#" cfsqltype="cf_sql_timestamp" />
				         and <cfqueryparam value="#arguments.edate#" cfsqltype="cf_sql_timestamp" />
						)
				order by newid()
			</cfquery>
		<cfreturn latestuploads>
	</cffunction>


</cfcomponent>