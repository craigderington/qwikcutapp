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
	
	
</cfcomponent>
