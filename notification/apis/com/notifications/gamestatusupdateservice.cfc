<cfcomponent displayname="gamestatusupdateservice">
	<cffunction name="init" access="public" returntype="gamestatusupdateservice" output="false" hint="I initialize the game status update service object.">
		<cfreturn this>
	</cffunction>

	<cffunction name="getgameslist" returntype="query" access="public" output="false" hint="I get the list of games for update.">
		<cfargument name="gamestatus" type="any" required="yes">
		<cfargument name="recorded" type="boolean" required="yes">		
		<cfset var gameStatusUpdateList = "" />
		<cfquery name="gameStatusUpdateList">
			select gs.gamestatusid, gs.gamestatus, gs.hometeamscore, gs.awayteamscore, gs.gamestatusrecorded,
				   t1.teamid as hometeamid, t1.teamorgname as hometeam, 
				   t2.teamid as awayteamid, t2.teamorgname as awayteam
			  from gamestatus gs,  games g, teams t1, teams t2
			 where gs.gameid = g.gameid
			   and t1.teamid = g.hometeamid
			   and t2.teamid = g.awayteamid
			   and gs.gamestatus = <cfqueryparam value="#arguments.gamestatus#" cfsqltype="cf_sql_varchar" />
			   and gs.gamestatusrecorded = <cfqueryparam value="#arguments.recorded#" cfsqltype="cf_sql_bit" />
			order by gs.gamestatusid asc
		</cfquery>		
		<cfreturn gameStatusUpdateList>
	</cffunction>
		
</cfcomponent>