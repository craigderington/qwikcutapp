<cfcomponent displayname="gameadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="gameadminservice" hint="I return an initialized game admin service object.">
		<cfreturn this >
	</cffunction>
	
	<cffunction name="getgameseasons" access="public" returntype="query" output="false" hint="I get the active game season.">
		<cfargument name="gameseason" required="no" type="numeric">
		<cfset var gameseasons = "" />
		<cfquery name="gameseasons">
			select gs.gameseasonid, gs.gameseason, gs.gameseasonstartdate, gs.gameseasonenddate, gs.gameseasonactive
			  from gameseasons gs
				   <cfif structkeyexists( arguments, "gameseason" )>
						where gs.gameseason = <cfqueryparam value="#arguments.gameseason#" cfsqltype="cf_sql_numeric" />
						  and gs.gameseasonactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				   </cfif>
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
	
	<cffunction name="getconferences" output="false" returntype="query" access="remote" hint="I get the list of conferences.">
		<cfargument name="conferencetype" type="any" required="yes">
		<cfset var conferencelist = "" />
			<cfquery name="conferencelist">
					select c.stateid, c.confid, c.confname, c.conftype, c.confactive, 
					       s.statename, s.stateabbr					       
					  from dbo.conferences c, dbo.states s
					 where c.stateid = s.stateid
					   and c.conftype = <cfqueryparam value="#form.conferencetype#" cfsqltype="cf_sql_varchar" />				   
				  order by c.stateid, c.confname asc
			</cfquery>
		<cfreturn conferencelist>
	</cffunction>
	
	<cffunction name="gethometeam" access="public" returntype="query" output="false" hint="I get the home team organizations list.">
		<cfargument name="conferenceid" type="numeric" required="yes">
			<cfset var hometeam = "" />
			<cfquery name="hometeam">
				   select distinct(teamorgname)
					 from teams
					where confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
				 order by teamorgname asc
			</cfquery>		
		<cfreturn hometeam>
	</cffunction>
	
	<cffunction name="getawayteam" access="public" returntype="query" output="false" hint="I get the away team organizations list.">
		<cfargument name="conferenceid" type="numeric" required="yes">
		<cfargument name="teamorgname" type="any" required="yes">
			<cfset var awayteam = "" />
			<cfquery name="awayteam">
				   select distinct(teamorgname)
					 from teams
					where confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
					  and teamorgname <> <cfqueryparam value="#arguments.teamorgname#" cfsqltype="cf_sql_varchar" /> 
				 order by teamorgname asc
			</cfquery>		
		<cfreturn awayteam>
	</cffunction>
	
	<cffunction name="getteamlevels" access="remote" output="false" hint="I get the team levels for the conference type.">
		<cfargument name="conferencetype" type="any" required="yes" default="#trim( form.conferencetype )#">
			<cfset var teamlevels = "" />
			<cfquery name="teamlevels">
				select tl.teamlevelid, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype
				  from teamlevels tl
				 where tl.teamlevelconftype = <cfqueryparam value="#arguments.conferencetype#" cfsqltype="cf_sql_varchar" />
			  order by tl.teamlevelid asc
			</cfquery>
		<cfreturn teamlevels>
	</cffunction>
	
	<cffunction name="getversus" access="remote" output="false" hint="I get the game versus data.">
		<cfargument name="vsid" type="numeric" required="yes" default="#session.vsid#">
			<cfset var versus = "" />
			<cfquery name="versus">
				select v.vsid, v.hometeam, v.awayteam, v.gamedate, v.gametime, v.fieldid, f.fieldname, 
					   f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.stateid, s.stateabbr
				  from versus v, fields f, states s
				 where v.fieldid = f.fieldid
				   and f.stateid = s.stateid
				   and v.vsid = <cfqueryparam value="#arguments.vsid#" cfsqltype="cf_sql_integer" />			  
			</cfquery>
		<cfreturn versus>
	</cffunction>
	
	<cffunction name="getgames" access="remote" output="false" hint="I get the games.">
		<cfargument name="vsid" type="numeric" required="yes" default="#session.vsid#">
			<cfset var games = "" />
			<cfquery name="games">
				select gs.gameseason, g.gameid, f.fieldid, f.fieldname, c.conftype, c.confname, g.gamedate, g.gamestart, g.gamestatus, 
					   g.gameoutcome, g.gamewinner, v.vsid,
					   t1.teamname as hometeam, t2.teamname as awayteam,
					   t1.teammascot as hometeammascot, t2.teammascot as awayteammascot
				  from games g, versus v, gameseasons gs, conferences c, states s, fields f, teamlevels tl, teams t1, teams t2
				 where g.vsid = v.vsid
				   and g.gameseasonid = gs.gameseasonid
				   and g.confid = c.confid
				   and c.stateid = s.stateid
				   and g.fieldid = f.fieldid
				   and g.hometeamid = t1.teamid 
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and g.vsid = <cfqueryparam value="#arguments.vsid#" cfsqltype="cf_sql_integer" />					  
			</cfquery>
		<cfreturn games>
	</cffunction>
	
	<cffunction name="searchgames" access="remote" output="false" hint="I get the games.">
		<cfargument name="searchvartype" type="any" required="yes">
		<cfargument name="searchvar" type="any" required="yes">
			<cfset var gamesearchresults = "" />
			<cfquery name="gamesearchresults">
				select v.vsid, v.hometeam, v.awayteam, v.gamedate, c.confname,
					   count(*) as totalgames
				  from versus v, games g, conferences c
				 where v.vsid = g.vsid
				   and g.confid = c.confid
					   <cfif trim( arguments.searchvartype ) eq "date">
							and v.gamedate = <cfqueryparam value="#arguments.searchvar#" cfsqltype="cf_sql_date" />
					   <cfelseif trim( arguments.searchvartype ) eq "teams">
						and 
							( v.hometeam LIKE <cfqueryparam value="#arguments.searchvar#%" cfsqltype="cf_sql_varchar" /> 
						     OR v.awayteam LIKE <cfqueryparam value="#arguments.searchvar#%" cfsqltype="cf_sql_varchar" />
							 )
						</cfif>
			  group by v.vsid, v.hometeam, v.awayteam, v.gamedate, c.confname 					  
			</cfquery>
		<cfreturn gamesearchresults>
	</cffunction>	
	
</cfcomponent>