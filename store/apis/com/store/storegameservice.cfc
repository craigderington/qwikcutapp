<cfcomponent displayname="storegameservice">
	<cffunction name="init" access="public" returntype="storegameservice" output="false" hint="I create an initialized store game service object.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getconferences" output="false" returntype="query" access="remote" hint="I get the list of conferences.">
		<cfargument name="stateid" type="numeric" required="yes" default="#url.sid#">
		<cfset var conferencelist = "" />
			<cfquery name="conferencelist">
					select c.stateid, c.confid, c.confname, c.conftype, c.confactive, 
					       s.statename, s.stateabbr					       
					  from dbo.conferences c, dbo.states s
					 where c.stateid = s.stateid
					   and c.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
					   and c.confactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				  order by c.stateid, c.confname asc
			</cfquery>
		<cfreturn conferencelist>
	</cffunction>
	
	<cffunction name="getconference" output="false" returntype="query" access="remote" hint="I get the conference name.">
		<cfargument name="conferenceid" type="numeric" required="yes" default="#url.cid#">
		<cfset var conferencename = "" />
			<cfquery name="conferencename">
					select c.stateid, c.confid, c.confname, c.conftype, c.confactive, 
					       s.statename, s.stateabbr					       
					  from dbo.conferences c, dbo.states s
					 where c.stateid = s.stateid
					   and c.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
					   and c.confactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				  order by c.stateid, c.confname asc
			</cfquery>
		<cfreturn conferencename>
	</cffunction>
	
	<cffunction name="getteams" access="remote" output="false" hint="I get the list of teams.">
		<cfargument name="stateid" type="numeric" required="no">
		<cfargument name="conferenceid" type="numeric" required="yes" default="0">
		<cfset var teamlist = "" />
		<cfquery name="teamlist">
			select distinct(t.teamorgname), count(t.teamid) as totalteams
			  from teams t, conferences c, states s, teamlevels tl
			 where t.confid = c.confid
			   and c.stateid = s.stateid
			   and t.teamlevelid = tl.teamlevelid
			   and c.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
		   group by t.teamorgname
		   order by t.teamorgname
		</cfquery>
		<cfreturn teamlist>
	</cffunction>
	
	<cffunction name="searchgames" access="remote" output="false" hint="I get the game search results.">		
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
							and datepart( "m", v.gamedate ) = <cfqueryparam value="#datepart( 'm', arguments.searchvar )#" cfsqltype="cf_sql_varchar" />
							and datepart( "d", v.gamedate ) = <cfqueryparam value="#datepart( 'd', arguments.searchvar )#" cfsqltype="cf_sql_varchar" />							
							and datepart( "yyyy", v.gamedate ) = <cfqueryparam value="#datepart( 'yyyy', arguments.searchvar )#" cfsqltype="cf_sql_varchar"/>
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
	
	<cffunction name="getgames" access="remote" output="false" hint="I get the games.">
		<cfargument name="vsid" type="numeric" required="yes" default="#session.vsid#">
			<cfset var games = "" />
			<cfquery name="games">
				select gs.gameseason, g.gameid, f.fieldid, f.fieldname, c.conftype, c.confname, g.gamedate, g.gamestart, g.gamestatus, 
					   g.gameoutcome, g.gamewinner, v.vsid, tl.teamlevelname,
					   t1.teamorgname as hometeam, t2.teamorgname as awayteam,
					   t1.teammascot as hometeammascot, t2.teammascot as awayteammascot,
					   t1.teamid as hometeamid, t2.teamid as awayteamid
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
				order by g.gameid asc, tl.teamlevelid asc
			</cfquery>
		<cfreturn games>
	</cffunction>
	
	<cffunction name="getgamedetail" access="public" returntype="query" output="false" hint="I get the game detail.">
		<cfargument name="gameid" type="numeric" required="yes">		
		<cfset var gamedetail = "" />
			<cfquery name="gamedetail">
				select g.gameid, g.fieldid, g.confid, g.hometeamid, g.awayteamid, g.gamedate, g.gamestart, g.gameend,
				       g.gamestatus, g.gameoutcome, g.gamewinner, t1.teamorgname as hometeam, 
					   t2.teamorgname as awayteam, tl.teamlevelname
				  from games g, teams t1, teams t2, teamlevels tl
				 where g.hometeamid = t1.teamid
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and g.gameid = <cfqueryparam value="#arguments.gameid#" cfsqltype="cf_sql_integer" />
			</cfquery>	
		<cfreturn gamedetail>
	</cffunction>
	
	<cffunction name="getconferencedivision" access="public" returntype="query" output="false" hint="I get the game info.">
		<cfargument name="gameid" type="numeric" required="yes" default="#session.vsid#">		
		<cfset var gameinfo = "" />
			<cfquery name="gameinfo">
				select g.confid, c.confname, tl.teamlevelname
				  from games g, conferences c, teams t1, teams t2, teamlevels tl
				 where g.hometeamid = t1.teamid
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and t1.confid = c.confid
				   and g.vsid = <cfqueryparam value="#arguments.gameid#" cfsqltype="cf_sql_integer" />
			</cfquery>	
		<cfreturn gameinfo>
	</cffunction>
	
	<cffunction name="getteamsbyname" access="public" returntype="query" output="false" hint="I get the team divisions by team org name.">
		<cfargument name="teamorgname" type="any" required="yes">		
		<cfset var teams = "" />
			<cfquery name="teams">
				select t.teamid, t.teamorgname, t.teammascot, t.teamname, t.teamlevelid, tl.teamlevelname
				  from teams t, teamlevels tl
				 where t.teamlevelid = tl.teamlevelid				  
				   and t.teamorgname = <cfqueryparam value="#arguments.teamorgname#" cfsqltype="cf_sql_varchar" />
				order by tl.teamlevelid asc
			</cfquery>	
		<cfreturn teams>
	</cffunction>
	
	<cffunction name="getteambyid" access="public" returntype="query" output="false" hint="I get the team name by id.">
		<cfargument name="teamid" type="numeric" required="yes">		
		<cfset var teaminfo = "" />
			<cfquery name="teaminfo">
				select t.teamname, t.teamorgname, tl.teamlevelname
				  from teams t, teamlevels tl
				 where t.teamlevelid = tl.teamlevelid		   
				   and t.teamid =  <cfqueryparam value="#arguments.teamid#" cfsqltype="cf_sql_integer" />			
			</cfquery>	
		<cfreturn teaminfo>
	</cffunction>
	
	<cffunction name="getgamesbyteam" access="public" returntype="query" output="false" hint="I get the team divisions by team org name.">
		<cfargument name="teamid" type="numeric" required="yes">		
		<cfset var teamgames = "" />
			<cfquery name="teamgames">
				select g.gameid, g.vsid, g.gamedate, g.hometeamid, g.awayteamid,
				       t1.teamorgname as hometeam, t2.teamorgname as awayteam,
					   vs.vsid, vs.fieldid, tl.teamlevelname, f.fieldname
				  from games g, versus vs, teams t1, teams t2, teamlevels tl, fields f
				 where g.gameid = vs.vsid
				   and g.hometeamid = t1.teamid
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and vs.fieldid = f.fieldid
				   and ( g.hometeamid = <cfqueryparam value="#arguments.teamid#" cfsqltype="cf_sql_integer" />
				        or 
						g.awayteamid =  <cfqueryparam value="#arguments.teamid#" cfsqltype="cf_sql_integer" />
						)						
				order by g.gameid asc
			</cfquery>	
		<cfreturn teamgames>
	</cffunction>
	
	
	
	
	
	

</cfcomponent>