<cfcomponent 
	displayname="qwikstatsservice"
	hint="I create an initialized instance of the qwikstatsservice.">
	
	<cffunction name="init" access="public" output="false" returntype="gameadminservice" hint="I return an initialized game admin service object.">
		<cfreturn this >
	</cffunction>
	
	<cffunction name="gettopgoals">		
		<cfset var goalleaderboard = "" />
		<cfquery name="goalleaderboard">
			select tr.playername, tr.playernumber, ls.teamname, sum(ls.goals) as total_goals
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.statdate between '1/1/2017' and '1/31/2017'
			   and ls.merged = 1
			   group by tr.playername, tr.playernumber, ls.teamname
			   order by total_goals DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn goalleaderboard>
	</cffunction>
	
	<cffunction name="gettopassists">		
		<cfset var assistsleaderboard = "" />
		<cfquery name="assistsleaderboard">
			select tr.playername, tr.playernumber, ls.teamname, sum(ls.assists) as total_assists
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.statdate between '1/1/2017' and '1/31/2017'
			   and ls.merged = 1
			   group by tr.playername, tr.playernumber, ls.teamname
			   order by total_assists DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn assistsleaderboard>
	</cffunction>
	
	<cffunction name="gettopshots">		
		<cfset var shotsleaderboard = "" />
		<cfquery name="shotsleaderboard">
			select tr.playername, tr.playernumber, ls.teamname, sum(ls.shots) as total_shots
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.statdate between '1/1/2017' and '1/31/2017'
			   and ls.merged = 1
			   group by tr.playername, tr.playernumber, ls.teamname
			   order by total_shots DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn shotsleaderboard>
	</cffunction>
	
	<cffunction name="gettopsaves">		
		<cfset var savesleaderboard = "" />
		<cfquery name="savesleaderboard">
			select tr.playername, tr.playernumber, ls.teamname, sum(ls.saves) as total_saves
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.statdate between '1/1/2017' and '1/31/2017'
			   and ls.merged = 1
			   group by tr.playername, tr.playernumber, ls.teamname
			   order by total_saves DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn savesleaderboard>
	</cffunction>
	
	<cffunction name="gettopgrounders">		
		<cfset var groundersleaderboard = "" />
		<cfquery name="groundersleaderboard">
			select tr.playername, tr.playernumber, ls.teamname, sum(ls.grounders) as total_grounders
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.statdate between '1/1/2017' and '1/31/2017'
			   and ls.merged = 1
			   group by tr.playername, tr.playernumber, ls.teamname
			   order by total_grounders DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn groundersleaderboard>
	</cffunction>
	
	<cffunction name="gettopturnovers">		
		<cfset var turnoversleaderboard = "" />
		<cfquery name="turnoversleaderboard">
			select tr.playername, tr.playernumber, ls.teamname, sum(ls.turnovers) as total_turnovers
			  from teamrosters tr inner join lacrosse_stats ls on tr.rosterid = ls.playerid
				   left join teams t on tr.teamid = t.teamid
			 where ls.statdate between '1/1/2017' and '1/31/2017'
			   and ls.merged = 1
			   group by tr.playername, tr.playernumber, ls.teamname
			   order by total_turnovers DESC, tr.playername, tr.playernumber, ls.teamname ASC
		</cfquery>
		<cfreturn turnoversleaderboard>
	</cffunction>
	
	
</cfcomponent>
