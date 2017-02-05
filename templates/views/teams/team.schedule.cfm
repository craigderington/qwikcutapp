

	
	
	
				<!--- // if the game manager session id exists, kill it --->
				<cfif structkeyexists( session, "vsid" )>
					<cfset tempr = structdelete( session, "vsid" )>								
				</cfif>
				
				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>
				<cfinvoke component="apis.com.admin.gameadminservice" method="getteamgames" returnvariable="teamgames">
					<cfinvokeargument name="teamid" value="#url.id#">
				</cfinvoke>

				<cfif teamgames.recordcount gte 15>
					<cfset thisminheight = "min-height: 1280px;" />
				<cfelseif teamgames.recordcount lt 15 and teamgames.recordcount gte 10>
					<cfset thisminheight = "min-height: 960px;" />
				<cfelseif teamgames.recordcount lt 10 and teamgames.recordcount gte 5>
					<cfset thisminheight = "min-height: 600px;" />
				<cfelse>
					<cfset thisminheight = "min-height: 400px;" />
				</cfif>
									
					
				<cfoutput>	
					
					<div class="ibox" style="margin-top:-15px;">								
								
						<div class="ibox-title">
							<h5><i class="fa fa-group"></i> #teamdetail.teamorgname# Game Schedule</h5>
								<span class="pull-right">
									<a class="btn btn-xs btn-success" href="#application.root#&event=#url.event#&fuseaction=team.view&id=#url.id#"><i class="fa fa-arrow-circle-left"></i> Return to Team Detail</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-warning" href="#application.root#&event=#url.event#"><i class="fa fa-th-list"></i> Return to Team List</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-default" href="#application.root#admin.home"><i class="fa fa-home"></i> Admin Home</a>
								</span>							
						</div>								
								
						<div class="ibox-content" style="#thisminheight#">									
							
								<ul class="nav nav-tabs">
									<li><a href="#application.root##url.event#&fuseaction=team.view&id=#url.id#"><i class="fa fa-check-circle"></i> Team Details</a></li>
									<li><a href="#application.root##url.event#&fuseaction=team.roster&id=#url.id#"><i class="fa fa-soccer-ball-o"></i> Team Roster</a></li>
									<li><a href="#application.root##url.event#&fuseaction=team.contacts&id=#url.id#"><i class="fa fa-briefcase"></i> Team Contacts</a></li>
									<li class="active"><a href="#application.root##url.event#&fuseaction=team.schedule&id=#url.id#"><i class="fa fa-clock-o"></i> Team Schedule</a></li>
									<!---
									<li><a href="">Menu 2</a></li>
									<li><a href="">Menu 2</a></li>
									--->
								</ul>
								<div class="tab-content" style="margin-top:25px;">
								    <div id="teamschedule" class="tab-pane fade in active">						
										<div class="col-lg-12">								
											<cfif teamgames.recordcount gt 0>
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
																		<td class="text-center"><a href="#application.root#admin.games&fuseaction=games.filter&vsid=#vsid#"><i class="fa fa-play-circle fa-2x text-primary"></i></a></td>
																		<td><a style="font-weight:bold;" href="#application.root#admin.games&fuseaction=games.filter&vsid=#vsid#">#hometeam#</a> (#teamlevelname#)</td>
																		<td>#awayteam#</td>
																		<td>#fieldname# Field</td>
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
										</div>										
									</div>
								</div>
						</div>
					</div>
					
					
					
					
								
							
								
					
					
					
					
					
					
					
					
					
					
					
					
					
				</cfoutput>
							
						