

			
			
			
			
			
				<cfinclude template="header.cfm">


				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
						<div class="row" style="margin-top:25px;">
							<div class="ibox">
								<div class="ibox-title">
									<h5><i class="fa fa-play-circle"></i> QC+ Game Status Update Service</h5>
								</div>
								
								<div class="ibox-content ibox-heading text-center text-navy">								
									<strong>QC+ Game Status Update Service | Processing Game Statuses</strong>								
								</div>	
									
								<div class="ibox-content">
								
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
											<div class="alert alert-success">
												<h3><i class="fa fa-check-circle-o"></i> 
													#gameStatusUpdateList.recordcount# games successfully recorded...
												</h3>
											</div>
										</cfoutput>
										
										
										
									<cfelse>
									
										<div class="alert alert-danger">
											<h3><i class="fa warning"></i> 
												THE SERVICE AUTOMATION FOUND ZERO GAMES TO UPDATE!
											</h3>
										</div>
									
									</cfif>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<cfinclude template="footer.cfm">