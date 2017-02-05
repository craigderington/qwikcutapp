

								<cfinvoke component="apis.com.admin.conferenceadminservice" method="getconferences" returnvariable="conferencelist">
								</cfinvoke>					
								
								
								
								
								<cfoutput>
									<div class="row">
										<div class="ibox">
											<div class="ibox-title">
												<h5><i class="fa fa-video-camera"></i> Assign Shooters</h5>
											</div>								
											<div class="ibox-content">										
												<div class="col-md-2">
													<button type="button" id="loading-example-btn" class="btn btn-success btn-sm btn-outline" onclick="location.href='#application.root##url.event#&fuseaction=#url.fuseaction#'">
														<i class="fa fa-refresh"></i> Reset
													</button>
												</div>											
																							
												<div class="col-md-10">											
													<form class="form-inline" name="searchgames" method="post" action="">
														<fieldset>
															<div class="form-group">
																<select name="confid" class="form-control">
																	<option value="" selected>Select Conference</option>
																	<cfloop query="conferencelist">
																		<option value="#confid#"<cfif structkeyexists( form, "confid" ) and form.confid eq conferencelist.confid>selected<cfelseif structkeyexists( session, "confid" )><cfif session.confid eq conferencelist.confid>selected</cfif></cfif>>#confname#</option>
																	</cfloop>
																</select>
															</div>
															<div class="form-group" id="data_1">
																<label class="sr-only" for="gamedate">Game Date</label>
																<div class="input-group date">
																	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																	<input type="text" class="form-control" name="gamedate" placeholder="Game Date" <cfif structkeyexists( form, "gamedate" )>value="#dateformat( form.gamedate, "mm/dd/yyyy" )#"</cfif><cfif structkeyexists( session, "gamedate" )>value="#dateformat( session.gamedate, "mm/dd/yyyy" )#"</cfif> />													
																</div>														
															</div>
															<div class="form-group">
																<button type="submit" name="getgames" class="btn btn-sm btn-primary">
																	<i class="fa fa-search"></i> Get Games
																</button>				
															</div>
														</fieldset>
													</form>																						
												</div>
											</div>
										</div>
									</div>
								
							
							
							
									<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "getgames" )>
										<cfparam name="confid" default="">
										<cfparam name="gamedate" default="">
										<cfparam name="edate" default="">
										<cfif trim( form.confid ) neq "" and isnumeric( form.confid )>
											<cfif isdate( form.gamedate ) and form.gamedate neq "">
												<cfset session.gamedate = createdatetime( year( form.gamedate ), month( form.gamedate ), day( form.gamedate ), 06, 00, 00 ) />
												<cfset session.confid = form.confid />											
												<cfset session.edate = createdatetime( year( form.gamedate ), month( form.gamedate ), day( form.gamedate ), 23, 59, 00 ) />
												
												<cfinvoke component="apis.com.admin.gameadminservice" method="searchconferencegames" returnvariable="gameresults">
													<cfinvokeargument name="confid" value="#session.confid#">
													<cfinvokeargument name="gamedate" value="#session.gamedate#">
													<cfinvokeargument name="edate" value="#session.edate#">
												</cfinvoke>
											
												<cfif gameresults.recordcount gt 0>
											
													<div class="row" style="margin-top:20px;">												
														<div class="table-responsive">													
															<h4 class="text-success"><i class="fa fa-th-list"></i> Search Results | #gameresults.recordcount# game<cfif gameresults.recordcount gt 1>s</cfif> found.  Click Assign Shooter.</h4>
															
															<table class="table table-bordered table-hover table-striped">
																	<thead>
																		<tr>
																			<th class="text-center">Assign</th>
																			<th>Teams</th>
																			<th>Field</th>
																			<th>Date</th>
																			<th>Shooters Assigned</th>
																		</tr>
																	</thead>
																	<tbody>
																		<cfoutput query="gameresults">																			
																			<tr>
																				<td class="text-center text-primary"><cfif gameresults.totalshooters lte 3><a data-toggle="modal" class="btn btn-xs btn-primary" href="##" onclick="window.open('templates/views/games/game-info.cfm?id=#vsid#','','toolbar=no,width=600, height=600');"><i class="fa fa-video-camera"></i></a><cfelse><i class="fa fa-video-camera text-navy"></i></cfif></td>
																				<td>#trim( awayteam )# <i>vs.</i> <strong>#trim( hometeam )#</strong></td>																				
																				<td>#fieldname# field</td>
																				<td>#dateformat( gamedate, "mm-dd-yyyy" )# @ #timeformat( gamedate, "hh:mm tt")#</td>
																				<td><span class="label <cfif gameresults.totalshooters eq 0>label-danger<cfelse>label-primary</cfif>">#totalshooters#</span></td>
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
											
												<cfelse>
											
													<div style="padding:20px;">
														<div class="alert alert-danger alert-dismissable">
															<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<p><i class="fa fa-exclamation-circle"></i> <a class="alert-link" href="">Sorry!</a>  Your game search for <i>#dateformat( form.gamedate, "mm-dd-yyyy" )#</i> and Conference ID: #form.confid# did not match any results in the database.</p>
															<p><strong>Please try again...</strong>
														</div>
													</div>
											
												</cfif>
											
											<cfelse>
												
												<div style="padding:20px;">
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<a class="alert-link" href="">Please select a game date and conference to get started....</a>
													</div>
												</div>
											
											</cfif>
											
										<cfelse>
											<div style="padding:20px;">
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
													<a class="alert-link" href="">You must select a conference and game date...</a>
												</div>
											</div>
											
										</cfif>										
									
									</cfif>		
									
										
									
									
									
									
								</cfoutput>
											