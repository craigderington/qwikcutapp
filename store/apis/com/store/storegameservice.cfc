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
	
	
	
	
	
	

</cfcomponent>