

					<cfif structkeyexists( session, "vsid" )>
						<cfset tempr = structdelete( session, "vsid" )>
					<cfelseif not structkeyexists( session, "vsid" )>
						<cfif structkeyexists( url, "fuseaction" ) and trim( url.fuseaction ) eq "games.filter">
							<cfif structkeyexists( url, "vsid" ) and url.vsid neq 0>
								<cfset session.vsid = numberformat( url.vsid, "99" )>
								<cflocation url="#application.root##url.event#&fuseaction=games.mgr" addtoken="no">
							</cfif>
						</cfif>					
					</cfif>


					
					
					
					<cfoutput>
						<div class="row">
							
							<cfif not structkeyexists( url, "confid" ) and not structkeyexists( url, "teamid" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getconferences" returnvariable="conferences">
									<cfinvokeargument name="stateid" value="#session.stateid#">
								</cfinvoke>
							
									<!--- // list of conferences --->
							
							
									<div class="table-responsive">
										<table class="table table-striped">
											<thead>
												<tr>
													<th>Go</th>
													<th>Conference</th>
													<th>Teams</th>										
												</tr>
											</thead>
											<tbody>
												<cfloop query="conferences">
													<tr>
														<td><a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&confid=#confid#"><i class="fa fa-play-circle fa-2x text-primary"></i></a></td>
														<td><a style="font-weight:bold;" href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&confid=#confid#">#confname#</a></td>
														<td><span class="label label-info">#teamscount#</span></td>
													</tr>
												</cfloop>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="3"><i class="fa fa-trophy"></i> <small>Found #conferences.recordcount# conferences.</small></td>										
												</tr>
											</tfoot>
										</table>
									</div>

							<cfelseif structkeyexists( url, "confid" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getteams" returnvariable="teams">
									<cfinvokeargument name="confid" value="#url.confid#">
								</cfinvoke>
								
								<cfif teams.recordcount gt 0>
									<h4 style="margin-bottom:10px;"><i class="fa fa-trophy"></i> Conference: <span class="text-primary">#teams.confname#</span>  <span class="pull-right"><a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-refresh"></i> Reset Filter</a></span></h4>
																				
										<div class="table-responsive">
											<table class="table table-hover">
												<thead>
													<tr>
														<th>Go</th>
														<th>Team Name</th>
														<th>City, State</th>
														<th>Games</th>										
													</tr>
												</thead>
												<tbody>
													<cfloop query="teams" group="teamorgname">
														<tr style="background-color:##f2f2f2;">
															<td class="text-navy" colspan="4"><strong>#teamorgname#</strong></td>
														</tr>
														<cfloop>
															<tr>
																<td><a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&teamid=#teamid#"><i class="fa fa-play-circle fa-2x text-primary"></i></a></td>
																<td><a style="font-weight:bold;" href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&teamid=#teamid#">#teamname#</a> (#teamlevelname#)</td>
																<td>#teamcity#, #stateabbr#</td>
																<td><span class="label label-warning">#gamescount#</span></td>
															</tr>
														</cfloop>
													</cfloop>
												</tbody>
												<tfoot>
													<tr>
														<td colspan="4"><i class="fa fa-trophy"></i> <small>Found #teams.recordcount# teams.</small></td>										
													</tr>
												</tfoot>
											</table>
										</div>
								
									<cfelse>
										
										<div class="alert alert-danger">
											<h4><i class="fa fa-warning"></i> No games are scheduled or exist for the selected conference.</h4>
											<p>Please click here to <a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#">reset the filter</a>.</p>
										</div>
									
									</cfif>
							
							<cfelseif structkeyexists( url, "teamid" )>
								<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
									<cfinvokeargument name="id" value="#url.teamid#">
								</cfinvoke>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getteamgames" returnvariable="teamgames">
									<cfinvokeargument name="teamid" value="#url.teamid#">
								</cfinvoke>
							
								<cfif teamgames.recordcount gt 0>
									<h4 style="margin-bottom:10px;"><i class="fa fa-trophy"></i> Team: <span class="text-primary">#teamdetail.teamorgname#</span>  <span class="pull-right"><a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-refresh"></i> Reset Filter</a></span></h4>
																				
										<div class="table-responsive">
											<table class="table table-hover">
												<thead>
													<tr>
														<th class="text-center">Manage</th>
														<th>Home Team</th>
														<th>Away Team</th>
														<th>Field</th>
														<th>Game Date/Time</th>
														<th>Game Status</th>
													</tr>
												</thead>
												<tbody>
													<cfloop query="teamgames">														
														<tr>
															<td class="text-center"><a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&vsid=#vsid#"><i class="fa fa-play-circle fa-2x text-primary"></i></a></td>
															<td><a style="font-weight:bold;" href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&vsid=#vsid#">#hometeam#</a> (#teamlevelname#)</td>
															<td>#awayteam#</td>
															<td>#fieldname#</td>
															<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>
															<td>#gamestatus#</td>															
														</tr>
													</cfloop>													
												</tbody>
												<tfoot>
													<tr>
														<td colspan="6"><i class="fa fa-play-circle"></i> <small>Found #teamgames.recordcount# games.</small></td>										
													</tr>
												</tfoot>
											</table>
										</div>
								
								<cfelse>
										
										<div class="alert alert-danger">
											<h4><i class="fa fa-warning"></i> No games are scheduled or exist for the selected team.</h4>
											<p>Please click here to <a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#">reset the filter</a>.</p>
										</div>
									
								</cfif>
							
							<cfelse>
							
								<div class="alert alert-danger">
									<h3><i class="fa fa-warning"> System Error!</h3>
									<p>Invalid game filter structure.  <a href="#application.root##url.event#">Click here to go back</a></p>
								</div>
							
							
							</cfif>

						
						</div>
					</cfoutput>
					