<cfcomponent displayname="dashboard">

	<cffunction name="init" access="public" output="false" returntype="admindashboardservice" hint="I create an initialized admin dashboard service data object.">
		<cfreturn this >
	</cffunction>
	
	
	<cffunction name="getheader" access="remote" output="false" returntype="struct">
		<cfargument name="teamid" type="numeric" required="yes" default="#session.teamid#">
		<cfset sHeader = structnew() />
		<cfquery name="teaminfo">
			select t.teamorgname, c.confname
			  from teams t
				   inner join conferences c on t.confid = c.confid
			 where t.teamid = <cfqueryparam value="#arguments.teamid#" cfsqltype="cf_sql_integer" />			
		</cfquery>
		
		<cfquery name="roster">
			select count(rosterid) as rCount
			  from teamrosters
			 where teamid = <cfqueryparam value="#arguments.teamid#" cfsqltype="cf_sql_integer" />
		</cfquery>

			<cfscript>
				structinsert( sHeader, "teamname", teaminfo.teamorgname )
				structinsert( sHeader, "confname", teaminfo.confname )
				structinsert( sHeader, "totalplayers", roster.rCount )
			</cfscript>
			
		
		<cfreturn sHeader>
	</cffunction>
	
	<cffunction name="getteamroster" access="remote" output="false" hint="I get the team roster by player name.">
		<cfargument name="id" type="any" required="yes" default="#session.teamid#">		
		<cfset var teamroster = "" />
			<cfquery name="teamroster">
				select rosterid, teamid, playername, playernumber, playerposition, playerstatus
				  from teamrosters
				 where teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn teamroster>
	</cffunction>
	
	
	<cffunction name="gettopgoals">
		<cfargument name="id" type="any" required="yes" default="#session.teamid#">	
		<cfset var goalleaderboard = "" />
		<cfquery name="goalleaderboard">
			select tr.playername, tr.playernumber, tr.playerposition, ls.teamname, 
			       sum(ls.goals) as total_goals
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.merged = 1
			   and ls.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			   group by tr.playername, tr.playernumber, tr.playerposition, ls.teamname
			   order by total_goals DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn goalleaderboard>
	</cffunction>
	
	<cffunction name="gettopassists">
		<cfargument name="id" type="any" required="yes" default="#session.teamid#">	
		<cfset var assistsleaderboard = "" />
		<cfquery name="assistsleaderboard">
			select tr.playername, tr.playernumber, tr.playerposition, ls.teamname, 
			       sum(ls.assists) as total_assists
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.merged = 1
			   and ls.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			   group by tr.playername, tr.playernumber, tr.playerposition, ls.teamname
			   order by total_assists DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn assistsleaderboard>
	</cffunction>
	
	<cffunction name="gettopshots">
		<cfargument name="id" type="any" required="yes" default="#session.teamid#">	
		<cfset var shotsleaderboard = "" />
		<cfquery name="shotsleaderboard">
			select tr.playername, tr.playernumber, tr.playerposition, ls.teamname, 
			       sum(ls.shots) as total_shots
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.merged = 1
			   and ls.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			   group by tr.playername, tr.playernumber, tr.playerposition, ls.teamname
			   order by total_shots DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn shotsleaderboard>
	</cffunction>
	
	<cffunction name="gettopsaves">
		<cfargument name="id" type="any" required="yes" default="#session.teamid#">	
		<cfset var savesleaderboard = "" />
		<cfquery name="savesleaderboard">
			select tr.playername, tr.playernumber, tr.playerposition, ls.teamname, 
			       sum(ls.saves) as total_saves
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.merged = 1
			   and ls.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			   group by tr.playername, tr.playernumber, tr.playerposition, ls.teamname
			   order by total_saves DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn savesleaderboard>
	</cffunction>
	
	<cffunction name="gettopgrounders">
	<cfargument name="id" type="any" required="yes" default="#session.teamid#">		
		<cfset var groundersleaderboard = "" />
		<cfquery name="groundersleaderboard">
			select tr.playername, tr.playernumber, tr.playerposition, ls.teamname, 
			       sum(ls.grounders) as total_grounders
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.merged = 1
			   and ls.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			   group by tr.playername, tr.playernumber, tr.playerposition, ls.teamname
			   order by total_grounders DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn groundersleaderboard>
	</cffunction>
	
	<cffunction name="gettopturnovers">
		<cfargument name="id" type="any" required="yes" default="#session.teamid#">	
		<cfset var turnoversleaderboard = "" />
		<cfquery name="turnoversleaderboard">
			select tr.playername, tr.playernumber, tr.playerposition, ls.teamname, 
			       sum(ls.turnovers) as total_turnovers
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.merged = 1
			   and ls.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			   group by tr.playername, tr.playernumber, tr.playerposition, ls.teamname
			   order by total_turnovers DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn turnoversleaderboard>
	</cffunction>
	
	<cffunction name="getgameseasons" returntype="query" output="false" access="remote">
		<cfset var gameseasons = "" />
		<cfquery name="gameseasons">
			select gameseasonid, gameseason, gameseasonactive
			  from gameseasons
			order by gameseasonid desc
		</cfquery>		
		<cfreturn gameseasons>
	</cffunction>
	
	<cffunction name="getgameseason" returntype="query" output="false" access="remote">
		<cfset var gameseason = "" />
		<cfquery name="gameseason">
			select gameseasonid, gameseason
			  from gameseasons
			 where gameseasonactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />			
		</cfquery>		
		<cfreturn gameseason>
	</cffunction>
	
	<cffunction name="getseasonstats" access="remote" returntype="query" output="false" hint="I get the list of stats for the season.">
		<cfargument name="id" type="numeric" required="yes" default="#session.teamid#">
		<cfset var seasonstats = "" />
		<cfquery name="seasonstats">
			select tr.playername, tr.playernumber, tr.playerposition,
			   sum(ls.goals) as totalgoals,
			   sum(ls.shots) as totalshots,
			   sum(ls.assists) as totalassists,
			   sum(ls.saves) as totalsaves,
			   sum(ls.grounders) as totalgrounders,
			   sum(ls.turnovers) as totalturnovers,
			   sum(ls.forcedturnovers) as totalforced,
			   sum(ls.penalties) as totalpenalties
			  from teamrosters tr
				   inner join lacrosse_stats ls on tr.rosterid = ls.playerid
			 where tr.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			 group by tr.playername, tr.playernumber, playerposition
			 order by tr.playernumber asc
		</cfquery>
		<cfreturn seasonstats>
	</cffunction>
	
	<cffunction name="getteamgames" access="remote" returntype="query" output="false" hint="I get the list team games.">
		<cfargument name="id" type="numeric" required="yes" default="#session.teamid#">
		<cfset var teamgames = "" />
		<cfquery name="teamgames">
			select v.vsid, v.hometeam, v.awayteam, v.gamedate, g.gameid
			  from versus v
			       inner join games g on v.vsid = g.vsid
			 where ( 
			          g.hometeamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			          or 
					  g.awayteamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
					)
				order by g.gamedate asc
				   
		</cfquery>
		<cfreturn teamgames>
	</cffunction>

	<cffunction name="getgamestats" access="remote" returntype="query" output="false" hint="I get the list of stats for the game.">
		<cfargument name="id" type="numeric" required="yes" default="#session.teamid#">
		<cfargument name="gameid" type="numeric" required="yes">
		<cfset var gamestats = "" />
		<cfquery name="gamestats">
			select tr.playername, tr.playernumber, tr.playerposition,
			   sum(ls.goals) as totalgoals,
			   sum(ls.shots) as totalshots,
			   sum(ls.assists) as totalassists,
			   sum(ls.saves) as totalsaves,
			   sum(ls.grounders) as totalgrounders,
			   sum(ls.turnovers) as totalturnovers,
			   sum(ls.forcedturnovers) as totalforced,
			   sum(ls.penalties) as totalpenalties
			  from teamrosters tr
				   inner join lacrosse_stats ls on tr.rosterid = ls.playerid
			 where tr.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			   and ls.gameid = <cfqueryparam value="#arguments.gameid#" cfsqltype="cf_sql_integer" />
			 group by tr.playername, tr.playernumber, playerposition
			 order by tr.playernumber asc
		</cfquery>
		<cfreturn gamestats>
	</cffunction>	

</cfcomponent>