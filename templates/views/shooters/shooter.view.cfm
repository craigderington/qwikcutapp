




				<cfoutput>
					<div class="row">
						<div class="ibox">					
							<div class="ibox-title">
								<h5><i class="fa fa-video-camera"></i> View Shooter | #shooter.shooterfirstname# #shooter.shooterlastname#   <cfif isuserinrole( "admin" )><a href="#application.root##url.event#&fuseaction=shooter.edit&id=#shooter.shooterid#" class="btn btn-xs btn-primary btn-outline" style="margin-left:15px;"><i class="fa fa-edit"></i> Edit Shooter</a></cfif></h5>
								<span class="pull-right">
									<a href="#application.root#admin.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-cog"></i> Admin Home</a>
									<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline" style="margin-left:5px;"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
								</span>
							</div>
							<div class="ibox-content">
								
								<!--- // system messages --->
								<cfif structkeyexists( url, "scope" )>									
									<cfif numberformat( url.scope, "99" ) eq 2>						
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<p><i class="fa fa-check-circle-o"></i> Shooter Details Saved...</p>								
										</div>									
									</cfif>					
								</cfif>
							
									
							
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="##tab-1"><i class="fa fa-video-camera"></i> Shooter Details</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.regions&id=#url.id#"><i class="fa fa-map-marker"></i> Regions</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.dates&id=#url.id#"><i class="fa fa-calendar"></i> Availability</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>										
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.comments&id=#url.id#"><i class="fa fa-comments"></i> Rating &amp; Comments</a></li>																							
									</ul>			
											
																					
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<div class="col-md-1">
													<cfif trim( shooter.userprofileimagepath ) neq "">														
														<img class="img-circle m-t-xs img-responsive" src="#shooter.userprofileimagepath#" alt="image" width="90">
													<cfelse>
														<i class="fa fa-video-camera fa-4x text-primary"></i>
													</cfif>
												</div>
												<div class="col-md-4">
													<div class="form-group">														
														<div class="col-lg-10">
															<h3 class="form-control-static">#shooter.shooterfirstname#  #shooter.shooterlastname#  <cfif shooter.shooterisactive eq 0><span class="label label-danger"><i class="fa fa-warning"></i> INACTIVE</span></span><cfelse><span class="label label-primary"><i class="fa fa-check-circle"></i> ACTIVE</cfif></h3>
															<cfif shooter.shooteraddress1 neq "" and shooter.shootercity neq "">
																<p class="form-control-static">#shooter.shooteraddress1#</p>															
																<cfif shooter.shooteraddress2 neq "">
																<p class="form-control-static">#shooter.shooteraddress2#</p>
																</cfif>
																<p class="form-control-static">#shooter.shootercity#, #shooter.stateabbr#  #shooter.shooterzip#</p>
															</cfif>
														</div>														
													</div>													
													<div class="form-group">														
														<div class="col-lg-10"><p class="form-control-static">#shooter.shooteremail#</p></div>														
													</div>
													<div class="form-group">														
														<div class="col-lg-10"><p class="form-control-static">#shooter.shootercellphone#</p></div>														
													</div>
													<div class="form-group">														
														<div class="col-lg-10"><p class="form-control-static">#shooter.shooteralertpref#</p></div>														
													</div>
												</div>
												<div class="col-md-6">
													<div class="ibox ">																														
														<div class="ibox-content">																
															<div class="row">
																<div class="col-sm-2">
																	<i class="fa fa-video-camera fa-2x text-success"></i><small><span class"label label-success">Rating</span></small>
																</div>
																<div class="col-sm-4">
																	<i class="fa fa-star fa-2x text-warning"></i>
																	<i class="fa fa-star fa-2x text-warning"></i>
																	<i class="fa fa-star fa-2x text-warning"></i>
																	<i class="fa fa-star fa-2x text-warning"></i>
																</div>
															</div>
															<div class="row" style="margin-top:25px;">
																<div class="col-sm-5">
																	<p><i class="fa fa-play-circle-o"></i> Games Completed</p>
																	<p><i class="fa fa-times-circle"></i> Missed Games</p>
																	<p><i class="fa fa-calendar"></i> Availability</p>
																	<p><i class="fa fa-envelope"></i> Shooter Invitation</p>
																</div>
																<div class="col-sm-7">
																	<p>0</p>
																	<p>0</p>
																	<p>No blockout dates</p>
																	<p><a href="#application.root##url.event#&fuseaction=shooter.invite&id=#shooter.shooterid#">[ Resend Invite ]</a>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>											
									</div><!-- / .tab-content -->
								</div><!-- / .tab-container -->	
							</div>					
						</div>				
					</div>
				</cfoutput>