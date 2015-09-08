								
								
								
								<!--- // clean up some of our vars --->
								
								<cfif structkeyexists( session, "vsid" )>
									<cfset temp_vs = structdelete( session, "vsid" ) />
								</cfif>
								
								<cfif structkeyexists( session, "teamname" )>
									<cfset temp_tn = structdelete( session, "teamname" ) />
								</cfif>
								
								
								<cfif structkeyexists( url, "fuseaction" )>
									<cfif trim( url.fuseaction ) eq "games.filter">
										<cfif not structkeyexists( session, "vsid" )>
											<cfif structkeyexists( url, "vsid" ) and url.vsid neq 0>
												<cfset session.vsid = numberformat( url.vsid, "99" )>
												<cflocation url="#application.root#admin.games&fuseaction=games.mgr" addtoken="no">
											</cfif>
										</cfif>
									<cfelseif trim( url.fuseaction ) eq "get.games">
										<cfif structkeyexists( url, "team_org_name" ) and team_org_name neq "">
											<cfset session.teamname = trim( url.team_org_name )>
											<cflocation url="#application.root#team.games" addtoken="no">
										</cfif>
									</cfif>
								</cfif>
								
								
								
								<!--- show for conference admins user role --->						
								<cfinvoke component="apis.com.user.userservice" method="getuserprofile" returnvariable="userprofile">
									<cfinvokeargument name="id" value="#session.userid#">
								</cfinvoke>
								
								<cfinvoke component="apis.com.admin.conferenceadminservice" method="getadminconferencename" returnvariable="conference">
									<cfinvokeargument name="id" value="#userprofile.confid#">
								</cfinvoke>
								
								
								
								
								
								<cfoutput>
									<div class="row" style="margin-top:25px;">							
										<div class="ibox float-e-margins">
											<div class="ibox-title">
												<h5><i class="fa fa-dashboard"></i> #conference.confname# Conference Admin Dashboard</h5>
											</div>
											<div class="ibox-content" style="min-height:1500px;">
												<div class="col-md-1">
													<button type="button" id="loading-example-btn" class="btn btn-success btn-sm btn-outline" onclick="location.href='#application.root##url.event#'">
														<i class="fa fa-refresh"></i> Reset
													</button>
												</div>
													
												<div class="col-md-11">										
													<form class="form-horizontal m-b" name="searchgames" method="post" action="#application.root##url.event#">
														<fieldset>
															<div class="input-group">
																<input type="text" placeholder="Search for Games by Team or Game Dates" name="search" class="input-sm form-control" onblur="javascript:this.form.submit();" <cfif structkeyexists( form, "search" )>value="#trim( form.search )#"</cfif>> 
																<span class="input-group-btn">
																	<button type="submit" name="dosearch" class="btn btn-sm btn-primary"> Go!</button> 
																</span>
															</div>
														</fieldset>
													</form>										
												</div>
												
												
												<cfif structkeyexists( form, "search" )>
													<cfif trim( form.search ) neq "">
														<cfif isdate( form.search )>
															<cfset searchvartype = "date" />
															<cfset searchvar = dateformat( form.search ) />
														<cfelse>
															<cfset searchvartype = "teams" />
															<cfset searchvar = trim( form.search ) />
														</cfif>
											
														<cfinvoke component="apis.com.admin.gameadminservice" method="searchgames" returnvariable="gamesearchresults">
															<cfinvokeargument name="conferenceid" value="#userprofile.confid#">
															<cfinvokeargument name="searchvartype" value="#searchvartype#">
															<cfinvokeargument name="searchvar" value="#searchvar#">
														</cfinvoke>
											
														<cfif gamesearchresults.recordcount gt 0>
															<div class="col-md-12">
																<div class="row" style="margin-top:20px;">												
																	<div class="table-responsive">													
																		<h4 class="text-success"><i class="fa fa-th-list"></i> Search Results | #gamesearchresults.recordcount# game<cfif gamesearchresults.recordcount gt 1>s</cfif> found.  Click Go to View Details.</h4>
															
																		<table class="table table-bordered table-hover table-striped">
																			<thead>
																				<tr>
																					<th class="text-center">Go</th>
																					<th>Teams</th>
																					<th>Conference</th>
																					<th>Date</th>
																					<th>Game Count</th>
																				</tr>
																			</thead>
																			<tbody>
																				<cfoutput query="gamesearchresults">
																					<tr>
																						<td class="text-center text-primary"><a href="#application.root##url.event#&fuseaction=games.filter&vsid=#vsid#"><i class="fa fa-play-circle fa-2x"></i></a></td>
																						<td>#trim( awayteam )# <i>vs.</i> <strong>#trim( hometeam )#</strong></td>
																						<td>#confname#</td>
																						<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>
																						<td><span class="label label-warning">#totalgames#</span></td>
																					</tr>
																				</cfoutput>													
																			</tbody>
																			<tfoot>
																				<tr>
																					<td colspan="5"><span class="help-block"><i class="fa fa-exclamation-circle"></i><small> Home teams shown in bold.</small></span></td>
																				</tr>
																			</tfoot>
																		</table>
																	</div>
																</div>
															</div>
														<cfelse>												
															<br />
															<div style="padding:20px;" style="margin-top:25px;">
																<div class="alert alert-danger alert-dismissable">
																	<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																	<p><i class="fa fa-exclamation-circle"></i> <a class="alert-link" href="">Sorry!</a>  Your search for <i>#trim( form.search )#</i> did not match any currently scheduled games in the database.  Search Options are team name or game dates.  Contact your Administrator to create new game schedules.</p>
																	<p><strong>Please try again...</strong>
																</div>
															</div>
												
														</cfif>
													
													<cfelse>
														<br />
														<div style="padding:20px;" style="margin-top:25px;">
															<div class="alert alert-danger alert-dismissable">
																<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																<p><i class="fa fa-exclamation-circle"></i> <a class="alert-link" href="">Ops!  You broke it.</a>  You can't search for an empty string.  Options are team names and game dates.</p>
																<p><strong>Please try again...</strong>
															</div>
														</div>
													
													</cfif>
												
												</cfif>
												
												<cfif not structkeyexists( form, "search" )>
												
														<cfinvoke component="apis.com.admin.teamadminservice" method="getconferenceteams" returnvariable="conferenceteamlist">
															<cfinvokeargument name="conferenceid" value="#userprofile.confid#">
														</cfinvoke>
														
														
															<div class="col-md-12">
																<div class="table-responsive">
																	<table class="table table-striped">
																		<thead>
																			<tr>
																				<th><i class="fa fa-gear text-navy text-center"></i></th>
																				<th>Organization</th>
																				<th>Team Count</th>
																				<th>Status</th>
																			</tr>
																		</thead>
																		<tbody>
																			<cfloop query="conferenceteamlist">
																				<tr>																					
																					<td><a href="#application.root##url.event#&fuseaction=get.games&team_org_name=#urlencodedformat( teamorgname )#"><i class="fa fa-play-circle fa-2x"></i></a></td>
																					<td>#teamorgname#</td>
																					<td>#totalteams#</td>
																					<td><i class="fa fa-check-circle-o text-primary text-center"></i></td>
																				</tr>
																			</cfloop>
																		</tbody>
																		<tfoot>
																			<tr>
																				<td colspan="4"><small><i class="fa fa-info-sign"></i> Showing #conferenceteamlist.recordcount# teams.</small></td>
																			</tr>
																		</tfoot>
																	</table>															
																</div>
															</div>
														
												
												</cfif>		
												
												
											</div>
										</div>							
									</div>
								</cfoutput>