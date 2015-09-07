

					
					<!--- show for conference admins user role --->						
					<cfinvoke component="apis.com.user.userservice" method="getuserprofile" returnvariable="userprofile">
						<cfinvokeargument name="id" value="#session.userid#">
					</cfinvoke>
								
					<cfinvoke component="apis.com.admin.conferenceadminservice" method="getadminconferencename" returnvariable="conference">
						<cfinvokeargument name="id" value="#userprofile.confid#">
					</cfinvoke>				
								
					<cfif structkeyexists( url, "fuseaction" ) and trim( url.fuseaction ) eq "get.game">
						<cfif structkeyexists( url, "vsid" ) and url.vsid neq 0>
							<cfset session.vsid = numberformat( url.vsid, "99" )>
							<cflocation url="#application.root#admin.games&fuseaction=games.mgr" addtoken="no">									
						</cfif>
					</cfif>			
								
								
								
									
					
					


					<!--- // main wrapper --->
					<div class="wrapper wrapper-content animated fadeIn">
						<div class="container">
							
							<cfoutput>
								
								<div class="row" style="margin-top:25px;">							
									<div class="ibox float-e-margins">
										<div class="ibox-title">
											<h5><i class="fa fa-dashboard"></i> Team Games | #session.teamname#</h5>
											<span class="pull-right">
												<cfif structkeyexists( url, "fuseaction" )>
													<a href="#application.root##url.event#" style="margin-right:5px;" class="btn btn-xs btn-success btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to #session.teamname# Divisions</a>
												</cfif>
												<a href="#application.root#user.home" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-home"></i> Conference Admin Home</a>
											</span>
										</div>
										<div class="ibox-content">	
											<div class="table-responsive">
												
												
												<cfif structkeyexists( url, "fuseaction" ) and structkeyexists( url, "teamid" )>												
													<cfif isnumeric( url.teamid ) and trim( url.fuseaction ) eq "schedule">
														<cfset teamid = url.teamid />
														<cfinvoke component="apis.com.admin.gameadminservice" method="getteamgames" returnvariable="teamgames">
															<cfinvokeargument name="conferenceid" value="#userprofile.confid#">
															<cfinvokeargument name="teamid" value="#teamid#">
														</cfinvoke>
														
														
														<cfif teamgames.recordcount gt 0>
															
															<table class="table table-striped">
																<thead>
																	<tr>
																		<th><i class="fa fa-gear text-navy text-center"></i></th>															
																		<th>Division</th>
																		<th>Away Team</th>
																		<th>Home Team</th>
																		<th>Field</th>
																		<th>Game Date</th>
																		<th>Shooter</th>
																		<th>Status</th>
																	</tr>
																</thead>
																<tbody>
																	<cfloop query="teamgames">
																		<tr>																					
																			<td><a href="#application.root##url.event#&fuseaction=get.game&vsid=#vsid#"><i class="fa fa-play-circle fa-2x"></i></a></td>															
																			<td>#teamlevelname#</td>
																			<td>#awayteam#</td>
																			<td><strong>#hometeam#</strong></td>
																			<td>#fieldname# <a href=""><i style="margin-left:5px;" class="fa fa-map-marker"></i></a></td>															
																			<td>#dateformat( gamedate, "mm-dd-yyyy" )# #timeformat( gamedate, "hh:mm tt" )#</td>
																			<td><span class="label">{{ dev }}</label></td>
																			<td><i class="fa fa-check-circle-o text-primary"></i></td>
																		</tr>
																	</cfloop>
																</tbody>
																<tfoot>
																	<tr>
																		<td colspan="6"><small><i class="fa fa-info-sign"></i> Showing #teamgames.recordcount# games.</small></td>
																	</tr>
																</tfoot>
															</table>
															
															
														<cfelse>
															
															<div class="alert alert-danger">
																<h5>NO GAMES SCHEDULED</h5>
																<p>There are not games scheduled for the selected Division.</p>
															</div>	
														
														</cfif>
														
													
													<cfelse>
													
														<div class="alert alert-danger">
															<h5>INVALID TEAM ID</h5>
															<p>The Team ID should be an integer...  </p>
														</div>
														
													</cfif>									
												
												
												
												<cfelse>
												
													<cfinvoke component="apis.com.admin.teamadminservice" method="getteamsbyname" returnvariable="teamslist">
														<cfinvokeargument name="conferenceid" value="#userprofile.confid#">
														<cfinvokeargument name="teamname" value="#session.teamname#">
													</cfinvoke>
												
												
														<table class="table table-striped">
															<thead>
																<tr>
																	<th><i class="fa fa-gear text-navy text-center"></i></th>															
																	<th>Division</th>
																	<th>ID</th>
																	<th>Team Name/Mascot</th>
																	<th>Status</th>
																</tr>
															</thead>
															<tbody>
																<cfloop query="teamslist">
																	<tr>																					
																		<td><a href="#application.root##url.event#&teamid=#teamid#&fuseaction=schedule"><i class="fa fa-play-circle fa-2x"></i></a></td>															
																		<td>#teamlevelname#</td>
																		<td>#teamid#</td>
																		<td><a href="#application.root##url.event#&teamid=#teamid#&fuseaction=schedule">#teamname#</a> #teammascot#</td>															
																		<td><i class="fa fa-check-circle-o text-primary text-center"></i></td>
																	</tr>
																</cfloop>
															</tbody>
															<tfoot>
																<tr>
																	<td colspan="5"><small><i class="fa fa-info-sign"></i> Showing #teamslist.recordcount# teams.</small></td>
																</tr>
															</tfoot>
														</table>

												</cfif>

												
											</div>
										</div>
									</div>
								</div>
								
							</cfoutput>
						
						
						</div>						
					</div>