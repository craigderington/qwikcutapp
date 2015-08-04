<cfcomponent displayname="gameadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="gameadminservice" hint="I return an initialized game admin service object.">
		<cfreturn this >
	</cffunction>
	
	<cffunction name="getgameseasons" access="public" returntype="query" output="false">
		<cfset var gameseasons = "" />
		<cfquery name="gameseasons">
			select gs.gameseasonid, gs.gameseason, gs.gameseasonstartdate, gs.gameseasonenddate, gs.gameseasonactive
			  from gameseasons gs
		  order by gs.gameseasonid desc
		</cfquery>
		<cfreturn gameseasons>
	</cffunction>

	<cffunction name="getgameslist" access="remote" output="false" returntype="query" hint="I get the list of scheduled games.">
		<cfargument name="conferenceid" type="numeric" required="no" default="1">
		<cfset var gameslist = "" />
		<cfquery name="gameslist">
			select gs.gameseason, g.gameid, f.fieldid, f.fieldname, c.conftype, c.confname, g.gamedate, g.gamestart, g.gamestatus, 
			       g.gameoutcome, g.gamewinner, 
				   t1.teamname as hometeam, t2.teamname as awayteam
			  from games g, gameseasons gs, conferences c, states s, fields f, teamlevels tl, teams t1, teams t2
			 where g.gameseasonid = gs.gameseasonid
			   and g.confid = c.confid
			   and c.stateid = s.stateid
			   and g.fieldid = f.fieldid
			   and g.hometeamid = t1.teamid 
			   and g.awayteamid = t2.teamid
			   and t1.teamlevelid = tl.teamlevelid
			   and gs.gameseasonid = <cfqueryparam value="1" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn gameslist>
	</cffunction>
</cfcomponent>