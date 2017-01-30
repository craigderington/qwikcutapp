


			<cfquery name="getstat">
				select top 1 statid, teamname, statdate, playernumber
				  from lacrosse_stats
				  where playerid = <cfqueryparam value="0" cfsqltype="cf_sql_integer" />
				    and gameid = <cfqueryparam value="0" cfsqltype="cf_sql_integer" />
					and teamid = <cfqueryparam value="0" cfsqltype="cf_sql_integer" />
					and merged = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
			</cfquery>
			<!---
			<cfdump var="#getstat#" label="Stat">
			--->
			<cfif getstat.recordcount eq 1>
			
				<cfquery name="getteam">
					select top 1 teams.teamid, teams.teamorgname, teamlevels.teamlevelname
					  from teams, teamlevels
					 where teams.teamlevelid = teamlevels.teamlevelid
					   and teams.teamorgname LIKE <cfqueryparam value="#getstat.teamname#" cfsqltype="cf_sql_varchar" />
					   and teams.teamlevelid in (97, 98)					 
				</cfquery>
				<!---
				<cfdump var="#getteam#" label="Team ID">
				--->
				<cfif getteam.recordcount eq 1>
					<cfset gamedate1 = dateadd( "d", -1, getstat.statdate ) />
					<cfset gamedate2 = dateadd( "d", 1, gamedate1 ) />
					<cfquery name="getgame">
						select gameid, gamedate
						  from games
						 where (
								hometeamid = <cfqueryparam value="#getteam.teamid#" cfsqltype="cf_sql_integer" />
								or awayteamid = <cfqueryparam value="#getteam.teamid#" cfsqltype="cf_sql_integer" />
								)
						   and (
								gamedate between <cfqueryparam value="#gamedate1#" cfsqltype="cf_sql_timestamp" /> 
										 and <cfqueryparam value="#gamedate2#" cfsqltype="cf_sql_timestamp" />
							   )
					</cfquery>
					<!---
					<cfdump var="#getgame#" label="Game Info">
					--->
					<cfquery name="getplayer">
						select rosterid
						  from teamrosters
						  where teamid = <cfqueryparam value="#getteam.teamid#" cfsqltype="cf_sql_integer" />
							and playernumber = <cfqueryparam value="#getstat.playernumber#" cfsqltype="cf_sql_integer" />
					</cfquery>
					<!---
					<cfdump var="#getplayer#" label="Player Info">
					--->
					<cfif getgame.recordcount eq 1 and getplayer.recordcount eq 1>	
					
						<cfquery name="updatestat">
							update lacrosse_stats
							   set teamid = <cfqueryparam value="#getteam.teamid#" cfsqltype="cf_sql_integer" />,
								   playerid = <cfqueryparam value="#getplayer.rosterid#" cfsqltype="cf_sql_integer" />,
								   gameid = <cfqueryparam value="#getgame.gameid#" cfsqltype="cf_sql_integer" />,
								   merged = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
							 where statid = <cfqueryparam value="#getstat.statid#" cfsqltype="cf_sql_integer" /> 
						</cfquery>				
						<p>
						1 STAT RECORD UPDATED SUCCESSFULLY!<br />
						-----------------------------------<br />
						<cfoutput>
						Stat ID: #getstat.statid#<br />
						Team ID: #getteam.teamid#<br />
						Player ID: #getplayer.rosterid#<br />
						Game ID: #getgame.gameid#<br />
						Game Date: #getgame.gamedate#<br />
						Stat Date: #getstat.statdate#<br />
						</cfoutput>
						</p>
					<cfelse>
						
						<!--- update the merged flag and follow up in reporting --->
						<cfquery name="updatestat">
							update lacrosse_stats
							   set merged = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
							 where statid = <cfqueryparam value="#getstat.statid#" cfsqltype="cf_sql_integer" /> 
						</cfquery>
						<p>
						PLAYER, GAME, TEAM NOT FOUND<br />
						STAT RECORD FLAGGED AS 'ERROR'<br />
						CONTINUING MERGE PROCESS...
						</p>
					</cfif>
				
				<cfelse>
				
					<!--- update the merged flag and follow up in reporting --->
					<cfquery name="updatestat">
						update lacrosse_stats
						   set merged = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
						       teamid = <cfqueryparam value="-1" cfsqltype="cf_sql_integer" />
						 where statid = <cfqueryparam value="#getstat.statid#" cfsqltype="cf_sql_integer" /> 
					</cfquery>
				
					NO TEAMS MATCHING STATS TEAM NAME.  ABORTING!
				
				</cfif>
				
				
			<cfelse>
			
				ZERO STATS IN DATABASE MERGE LIST
			
			</cfif>