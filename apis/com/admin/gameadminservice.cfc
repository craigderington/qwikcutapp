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
	
	<cffunction name="gethometeam" access="public" returntype="query" output="false" hint="I get the home team organizations list.">
		<cfargument name="conferenceid" type="numeric" required="yes">
		<cfargument name="teamlevelid" type="numeric" required="no">
			<cfset var hometeam = "" />
			<cfquery name="hometeam">
				   select distinct(teamorgname)
					 from teams
					where confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
						<cfif structkeyexists( url, "fuseaction" )>
							<cfif trim( url.fuseaction ) contains "game.custom.nc">
								and teamlevelid = <cfqueryparam value="#arguments.teamlevelid#" cfsqltype="cf_sql_integer" />
							</cfif>
						</cfif>
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
		<cfargument name="conferenceid" type="numeric" required="yes" default="1">
			<cfset var teamlevels = "" />
			<cfquery name="teamlevels">
				select tl.teamlevelid, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype
				  from teamlevels tl
				 where tl.teamlevelconftype = <cfqueryparam value="#arguments.conferencetype#" cfsqltype="cf_sql_varchar" />
				   and tl.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
			  order by tl.teamlevelid asc
			</cfquery>
		<cfreturn teamlevels>
	</cffunction>
	
	<cffunction name="getversus" access="remote" output="false" hint="I get the game versus data.">
		<cfargument name="vsid" type="numeric" required="yes" default="#session.vsid#">
			<cfset var versus = "" />
			<cfquery name="versus">
				select v.vsid, v.hometeam, v.awayteam, v.gamedate, v.gametime, v.fieldid, f.fieldname, 
					   f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.stateid, f.regionid, s.stateabbr
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
					   g.gameoutcome, g.gamewinner, v.vsid, tl.teamlevelname,
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
				order by g.gameid asc, tl.teamlevelid asc
			</cfquery>
		<cfreturn games>
	</cffunction>
	
	<cffunction name="searchgames" access="remote" output="false" hint="I get the games.">
		<cfargument name="conferencid" type="numeric" required="no">
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
						<cfif isuserinrole( "confadmin" )>
							and c.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
						</cfif>
			  group by v.vsid, v.hometeam, v.awayteam, v.gamedate, c.confname 					  
			</cfquery>
		<cfreturn gamesearchresults>
	</cffunction>

	<cffunction name="getconferences" output="false" returntype="query" access="remote" hint="I get the list of conferences.">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		<cfargument name="conferencetype" type="any" required="yes" default="YF">
		<cfset var conferences = "" />
			<cfquery name="conferences">
			  select c.stateid, c.confid, c.confname, count(t.teamid) as teamscount       
			    from dbo.conferences c, dbo.states s, teams t
			   where c.stateid = s.stateid
			     and t.confid = c.confid        
			     and c.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
					 <cfif structkeyexists( url, "fuseaction" )>
						<cfif ( trim( url.fuseaction ) eq "game.add" ) or ( trim( url.fuseaction ) eq "game.custom" )>
							and c.conftype = <cfqueryparam value="#arguments.conferencetype#" cfsqltype="cf_sql_varchar" maxlength="2" />
						</cfif>
					 </cfif>
			group by c.stateid, c.confid, c.confname
			order by c.stateid, c.confname asc
			</cfquery>
		<cfreturn conferences>
	</cffunction>
	
	<cffunction name="getnonconferences" output="false" returntype="query" access="remote" hint="I get the list of conferences.">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		<cfargument name="conferencetype" type="any" required="yes">
		<cfargument name="conferenceid" type="numeric" required="yes">
		<cfset var nonconferences = "" />
			<cfquery name="nonconferences">
			  select c.stateid, c.confid, c.confname  
			    from dbo.conferences c, dbo.states s
			   where c.stateid = s.stateid			            
			     and c.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
				 and c.conftype = <cfqueryparam value="#arguments.conferencetype#" cfsqltype="cf_sql_varchar" maxlength="2" />
				 and c.confid <> <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />			
			order by c.stateid, c.confname asc
			</cfquery>
		<cfreturn nonconferences>
	</cffunction>
	
	<cffunction name="getnonconferenceawayteam" output="false" returntype="query" access="remote" hint="I get the non-conference away team list.">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">		
		<cfargument name="conferenceid" type="numeric" required="yes">
		<cfset var nonconferenceawayteam = "" />
			<cfquery name="nonconferenceawayteam">
			  select distinct(t.teamorgname)
					 from teams t, conferences c
					where t.confid = c.confid
					  and c.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
					  and c.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_varchar" />                      					  
				 order by t.teamorgname asc
			</cfquery>
		<cfreturn nonconferenceawayteam>
	</cffunction>
	
	<cffunction name="getteams" output="false" returntype="query" access="remote" hint="I get the list of teams for the games manager.">
		<cfargument name="confid" type="numeric" required="yes" default="#url.confid#">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		<cfset var teams = "" />
			<cfquery name="teams">
			    select t.teamid, t.teamname, t.teamorgname, tl.teamlevelid, tl.teamlevelname, t.teammascot, t.teamcity, s.stateabbr, c.confname,
				   count(g.gameid) as gamescount       
				   from dbo.teams t, teamlevels tl, conferences c, states s, versus v, games g
				  where t.confid = c.confid
					and c.stateid = s.stateid
                    and t.teamlevelid = tl.teamlevelid					
					and c.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
					and c.confid = <cfqueryparam value="#arguments.confid#" cfsqltype="cf_sql_integer" />
					and v.vsid = g.vsid
					and ( 
						t.teamid = g.hometeamid 
					     or 
						t.teamid = g.awayteamid 
						)
			   group by t.teamid, t.teamname, t.teamorgname, tl.teamlevelid, tl.teamlevelname, t.teammascot, t.teamcity, s.stateabbr, c.confname
			   order by t.teamorgname asc, tl.teamlevelid asc		
			</cfquery>
		<cfreturn teams>
	</cffunction>
	
	<cffunction name="getteamgames" output="false" returntype="query" access="remote" hint="I get the team game schedule.">
		<cfargument name="teamid" type="numeric" required="yes" default="#url.teamid#">
		<cfargument name="conferenceid" type="numeric" required="no">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		<cfset var teamgames = "" />
			<cfquery name="teamgames">
			    select g.gameid, g.hometeamid, g.awayteamid, g.gamedate, g.gamestart, g.gamestatus, 
						   t1.teamname as hometeam, 
						   t2.teamname as awayteam,
						   f.fieldname, v.fieldid, v.vsid,
						   c.confname, s.stateabbr, tl.teamlevelname
					from dbo.games g, dbo.teams t1, dbo.teams t2, dbo.fields f, dbo.versus v, dbo.conferences c, dbo.states s, dbo.teamlevels tl
					where (g.hometeamid = t1.teamid)
					and (g.awayteamid = t2.teamid)
					and g.vsid = v.vsid
					and f.fieldid = v.fieldid
					and t1.confid = c.confid
					and c.stateid = s.stateid
					and t1.teamlevelid = tl.teamlevelid
					and (
							t1.teamid = <cfqueryparam value="#arguments.teamid#" cfsqltype="cf_sql_integer" />
							
							or
							
							t2.teamid = <cfqueryparam value="#arguments.teamid#" cfsqltype="cf_sql_integer" />
						)
					<cfif isuserinrole( "confadmin" )>
					    and t1.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
					</cfif>
				order by g.gameid, g.gamedate asc
			</cfquery>					
		<cfreturn teamgames>
	</cffunction>
	
	<cffunction name="getteamhomefieldid" access="public" returntype="query" output="false" hint="I get the team home field id.">
		<cfargument name="hometeam" type="any" required="yes">		
		<cfset var homefieldid = "" />
			<cfquery name="homefieldid">
				select top 1 t.homefieldid
				  from teams t
				 where t.teamorgname = <cfqueryparam value="#arguments.hometeam#" cfsqltype="cf_sql_varchar" />
			</cfquery>	
		<cfreturn homefieldid>
	</cffunction>
	
	<cffunction name="getgameshooters" access="public" returntype="query" output="false" hint="I get the shooters assignments for each game.">
		<cfargument name="vsid" type="numeric" required="yes" default="#session.vsid#">		
		<cfset var gameshooters = "" />
			<cfquery name="gameshooters">
				select sa.shooterassignmentid, sa.vsid, sa.gameid, sa.shooterassignstatus, sa.shooterassigndate, sa.shooteracceptdate, sa.shooteracceptedassignment,
					   sa.shooterassignlastupdated, sh.shooterid, sh.shooterfirstname, sh.shooterlastname, sh.shooteremail, sh.userid, us.userprofileimagepath
				  from shooterassignments sa, shooters sh, usersettings us
				 where sa.shooterid = sh.shooterid
				   and sh.userid = us.userid
				   and sa.vsid = <cfqueryparam value="#arguments.vsid#" cfsqltype="cf_sql_integer" />
			</cfquery>	
		<cfreturn gameshooters>
	</cffunction>
	
	<cffunction name="getshooterfields" access="public" returntype="query" output="false" hint="I get the shooter list for the assigned fields.">
		<cfargument name="regionid" type="numeric" required="yes">
		<cfargument name="assignedids" type="any" required="yes">
		<cfset var shooterfields = "" />
			<cfquery name="shooterfields">
				select sh.shooterid, sh.shooterfirstname, sh.shooterlastname
				  from shooters sh, users u, shooterregions sr, regions r
				 where sh.userid = u.userid
				   and sh.shooterid = sr.shooterid
                   and sr.regionid = r.regionid
				   and sh.shooterisactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				   and sh.shooterid not in(<cfqueryparam value="#arguments.assignedids#" cfsqltype="cf_sql_integer" list="yes" />)
                   and r.regionid = <cfqueryparam value="#arguments.regionid#" cfsqltype="cf_sql_integer" />
				   and u.useractive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				order by sh.shooterlastname, sh.shooterfirstname asc		
			</cfquery>	
		<cfreturn shooterfields>
	</cffunction>
	
	<cffunction name="getgamedetail" access="public" returntype="query" output="false" hint="I get the game detail.">
		<cfargument name="id" type="numeric" required="yes">		
		<cfset var gamedetail = "" />
			<cfquery name="gamedetail">
				select g.gameid, g.fieldid, g.confid, g.hometeamid, g.awayteamid, g.gamedate, g.gamestart, g.gameend,
				       g.gamestatus, g.gameoutcome, g.gamewinner, t1.teamorgname as hometeam, 
					   t2.teamorgname as awayteam, tl.teamlevelname
				  from games g, teams t1, teams t2, teamlevels tl
				 where g.hometeamid = t1.teamid
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and g.gameid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>	
		<cfreturn gamedetail>
	</cffunction>
	
	<cffunction name="chkDeleteGames" access="public" output="false" returntype="struct" hint="I get the struct value for allowing games to be deleted from the Games Admin.">
		<cfargument name="id" type="numeric" required="yes" default="#session.vsid#">
		<cfset var allowDeleteGames = structnew() />
		
		<cfquery name="getGamesList">
			select gameid 
			  from games
			 where vsid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfset gamesList = valuelist( getGamesList.gameid ) />
		
		<cfquery name="chkShooterAssignments">
			select shooterassignstatus
			  from shooterassignments
			 where vsid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
			<cfquery name="chkGameStatus">
				select gamestatusid, gameid
				  from gamestatus
				 where gameid IN( <cfqueryparam value="#gamesList#" cfsqltype="cf_sql_integer" list="yes" /> )
			</cfquery>
		
			<cfif chkShooterAssignments.recordcount gt 0>
				<cfset shooterstatus = structinsert( allowDeleteGames, "shooterassignstatus", chkShooterAssignments.shooterassignstatus ) />
			<cfelse>
				<cfset shooterstatus = structinsert( allowDeleteGames, "shooterassignstatus", 0 ) />
			</cfif>
		
			<cfif chkGameStatus.recordcount gt 0>
				<cfset gamestatus = structinsert( allowDeleteGames, "gamestatus", chkGameStatus.gamestatusid ) />
			<cfelse>
				<cfset gamestatus = structinsert( allowDeleteGames, "gamestatus", 0 ) />
			</cfif>
		<!---
		<cfset gamestatus = structinsert( allowDeleteGames, "gamestatus", 0 ) />
		<cfset shooterstatus = structinsert( allowDeleteGames, "shooterassignstatus", 0 ) />
		--->
		<cfreturn allowDeleteGames>	
		
	</cffunction>
	
	
	<cffunction name="getcustomgames" access="public" returntype="query" output="false" hint="I get the custom game list.">				
		<cfset var customgames = "" />
			<cfquery name="customgames">
				select top 15 g.gameid, g.vsid, g.fieldid, g.confid, g.hometeamid, g.awayteamid, g.gamedate, g.gamestart, g.gameend,
				       g.gamestatus, g.gameoutcome, g.gamewinner, t1.teamorgname as hometeam, 
					   t2.teamorgname as awayteam, tl.teamlevelname
				  from games g, teams t1, teams t2, teamlevels tl
				 where g.hometeamid = t1.teamid
				   and g.awayteamid = t2.teamid
				   and t1.teamlevelid = tl.teamlevelid
				   and g.customgame = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				   and g.gamestatus <> <cfqueryparam value="FINAL" cfsqltype="cf_sql_varchar" />
			</cfquery>	
		<cfreturn customgames>
	</cffunction>
	
	<cffunction name="searchconferencegames" access="public" returntype="query" output="false" hint="I get the new workflow shooter assignments list by conference and date.">
		<cfargument name="confid" type="numeric" required="yes">
		<cfargument name="gamedate" type="date" required="yes">
		<cfargument name="edate" type="date" required="yes">
		<cfset var gameresults = "" />
		<cfquery name="gameresults">
			  select distinct(v.vsid), v.gamedate, v.fieldid, v.gamestatus, f.fieldname, v.hometeam, v.awayteam,
				    (select count(sa.shooterid) from shooterassignments sa where sa.vsid = v.vsid) as totalshooters
				from versus v, games g, fields f
			   where v.vsid = g.vsid
				 and v.fieldid = f.fieldid
				 and ( v.gamedate between <cfqueryparam value="#arguments.gamedate#" cfsqltype="cf_sql_timestamp" /> 
				       and <cfqueryparam value="#arguments.edate#" cfsqltype="cf_sql_timestamp" />
					 )
				 and g.confid = <cfqueryparam value="#arguments.confid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn gameresults>
	</cffunction>

	<cffunction name="getgameinfo" access="public" returntype="query" output="false" hint="I get the new workflow shooter assignments list by conference and date.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">		
		<cfset var gameinfo = "" />
		<cfquery name="gameinfo">
			  select distinct(v.vsid), v.gamedate, v.fieldid, v.gamestatus, f.fieldname, v.hometeam, v.awayteam, c.confname,
				    (select count(sa.shooterid) from shooterassignments sa where sa.vsid = v.vsid) as totalshooters
				from versus v, games g, fields f, conferences c
			   where v.vsid = g.vsid
			     and g.confid = c.confid
				 and v.fieldid = f.fieldid
				 and v.vsid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn gameinfo>
	</cffunction>
	
</cfcomponent>