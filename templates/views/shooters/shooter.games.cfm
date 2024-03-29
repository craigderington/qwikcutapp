
					
					
				
				
				<cfif structkeyexists( url, "id" )>
					<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooterassignments" returnvariable="shooterassignments">
						<cfinvokeargument name="shooterid" value="#url.id#">
					</cfinvoke>
				<cfelse>
					<cflocation url="#application.root##url.event#" addtoken="yes">
				</cfif>
				
				
				
				
				
				<cfoutput>
					<div class="row">
						<div class="ibox">					
							<div class="ibox-title">
								<h5><i class="fa fa-video-camera"></i> Shooter | Scheduled Games |  #shooter.shooterfirstname# #shooter.shooterlastname#   <cfif isuserinrole( "admin" )><a href="#application.root##url.event#&fuseaction=shooter.edit&id=#shooter.shooterid#" class="btn btn-xs btn-primary btn-outline" style="margin-left:15px;"><i class="fa fa-edit"></i> Edit Shooter</a></cfif></h5>
								<span class="pull-right">
									<a href="#application.root#admin.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-cog"></i> Admin Home</a>
									<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline" style="margin-left:5px;"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
								</span>
							</div>
							<div class="ibox-content">								
							
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.view&id=#url.id#"><i class="fa fa-video-camera"></i> Shooter Details</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.regions&id=#url.id#"><i class="fa fa-map-marker"></i> Regions</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.dates&id=#url.id#"><i class="fa fa-calendar"></i> Availability</a></li>
										<li class="active"><a href="#application.root##url.event#&fuseaction=shooter.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.account&id=#url.id#"><i class="fa fa-money"></i> Account</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.comments&id=#url.id#"><i class="fa fa-comments"></i> Rating &amp; Comments</a></li>																							
									</ul>			
											
																					
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<cfif shooterassignments.recordcount gt 0>
													<div class="table-responsive">
														<table class="table table-striped table-bordered table-hover" >
															<thead>
																<tr>
																	<th>Actions</th>
																	<th>Game Date</th>
																	<th>Field</th>
																	<th>Teams</th>
																	<th>Status</th>
																	<th>Last Updated</th>
																</tr>
															</thead>
															<tbody>
																<cfloop query="shooterassignments">
																	<tr>
																		<td><i class="fa fa-check-circle text-success"></i> <i class="fa fa-times-circle text-success"></i></td>
																		<td>#dateformat( gamedate, "mm/dd/yyyy" )# @ #timeformat( gamedate, "hh:mm tt" )#</td>
																		<td>#fieldname#</td>
																		<td>#hometeam# vs. #awayteam#</td>
																		<td><label class="label label-<cfif shooterassignstatus eq "accepted">success<cfelseif shooterassignstatus eq "assigned">danger<cfelseif shooterassignstatus eq "completed">success</cfif>">#shooterassignstatus#</span></td>
																		<td><cfif shooterassignstatus eq "accepted">#dateformat( shooteracceptdate, "mm/dd/yyyy" )#<cfelse><span class="label label-danger">Not Accepted</span></cfif></td>
																	</tr>
																</cfloop>
															</tbody>
														</table>
														<tfoot>
															<tr>
																<td colspan="6">
																	<i class="fa fa-info-circle"></i> #shooterassignments.recordcount# shooter assignment record<cfif shooterassignments.recordcount neq 1>s</cfif> found.
																</td>
															</tr>
														</tfoot>
													</div>
												
												<cfelse>												
												
													<div class="col-lg-12">
														<div class="alert alert-danger alert-dismissable">
															<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<p><i class="fa fa-warning"></i> No scheduled games found for this shooter...</p>								
														</div>
													</div>

												</cfif>
											</div>
										</div>											
									</div><!-- / .tab-content -->
								</div><!-- / .tab-container -->	
							</div>					
						</div>				
					</div>
				</cfoutput>