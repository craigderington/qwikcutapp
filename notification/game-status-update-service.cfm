





			<!--- // get our list of games that need to be updated --->
			
			<cfinvoke component="apis.com.notifications.gamestatusupdateservice" method="getgameslist" returnvariable="gameStatusUpdateList">
				<cfinvokeargument name="recorded" value="0">
				<cfinvokeargument name="gamestatus" value="FINAL">
			</cfinvoke>
			
			
			<cfif gameStatusUpdateList.recordcount gt 0>
			
				<!--- // get the current game season --->
				<cfquery name="gameseason">
					select gameseasonid
					  from gameseasons
					 where gameseasonactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				</cfquery>
			
				<!---
				<cfdump var="#gameStatusUpdateList#" label="Games List">
				--->
			
				<cfloop query="gameStatusUpdateList">
				
					<!--- // get the game winning and losing teams and set up vars --->
					<cfif hometeamscore gt awayteamscore>
						<cfset gamewinner = hometeamid />
						<cfset gameloser = awayteamid />
					<cfelse>
						<cfset gamewinner = awayteamid />
						<cfset gameloser = hometeamid />
					</cfif>
					
					
					<!--- // record the winners and losers --->
					<cfquery name="recordWinningTeamGameStatus">
						insert into teamrecords(teamid, wins, losses, gameseasonid)
							values(
								  <cfqueryparam value="#gamewinner#" cfsqltype="cf_sql_integer" />,
								  <cfqueryparam value="1" cfsqltype="cf_sql_numeric" />,
								  <cfqueryparam value="0" cfsqltype="cf_sql_numeric" />,
								  <cfqueryparam value="#gameseason.gameseasonid#" cfsqltype="cf_sql_integer" />
								  );			
					</cfquery>
					
					<cfquery name="recordLosingTeamGameStatus">
						insert into teamrecords(teamid, wins, losses, gameseasonid)
							values(
								  <cfqueryparam value="#gameloser#" cfsqltype="cf_sql_integer" />,
								  <cfqueryparam value="0" cfsqltype="cf_sql_numeric" />,
								  <cfqueryparam value="1" cfsqltype="cf_sql_numeric" />,
								  <cfqueryparam value="#gameseason.gameseasonid#" cfsqltype="cf_sql_integer" />
								  );			
					</cfquery>

					<cfquery name="updateRecordedStatus">
						update gamestatus
						   set gamestatusrecorded = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
						 where gamestatusid = <cfqueryparam value="#gameStatusUpdateList.gamestatusid#" cfsqltype="cf_sql_integer" />
					</cfquery>
				
				
				</cfloop>
			
				<!--- // supress output for automation
				<cfoutput query="gameStatusUpdateList">
				
					<!--- // get the game winning and losing teams and set up vars --->
					<cfif hometeamscore gt awayteamscore>
						<cfset gamewinner = hometeamid />
						<cfset gameloser = awayteamid />
					<cfelse>
						<cfset gamewinner = awayteamid />
						<cfset gameloser = hometeamid />
					</cfif>
					
					<div style="padding:10px;">				
						#hometeam# (#hometeamid#) - #hometeamscore# vs. #awayteam# (#awayteamid#) - #awayteamscore#  &nbsp;&nbsp;   Winner: #gamewinner#  Loser: #gameloser#
					</div>
					
				</cfoutput>			
				--->
				
				<cfoutput>
					<div style="padding:75px;">
						<h3 style="fOnt-family:Verdana;font-size:18px;">
							#gameStatusUpdateList.recordcount# games successfully recorded...
						</h3>
					</div>
				</cfoutput>
				
				
				
			<cfelse>
			
				<div style="padding:75px;">
					<h3 style="fOnt-family:Verdana;font-size:18px;">
						THE SERVICE AUTOMATION FOUND ZERO GAMES TO UPDATE!
					</h3>
				</div>
			
			</cfif>
			