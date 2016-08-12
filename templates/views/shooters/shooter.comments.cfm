




				<cfoutput>
					<div class="row">
						<div class="ibox">					
							<div class="ibox-title">
								<h5><i class="fa fa-video-camera"></i> Shooter | Shooter Rating &amp; Comments | #shooter.shooterfirstname# #shooter.shooterlastname#   <cfif isuserinrole( "admin" )><a href="#application.root##url.event#&fuseaction=shooter.edit&id=#shooter.shooterid#" class="btn btn-xs btn-primary btn-outline" style="margin-left:15px;"><i class="fa fa-edit"></i> Edit Shooter</a></cfif></h5>
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
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>										
										<li class="active"><a href="#application.root##url.event#&fuseaction=shooter.comments&id=#url.id#"><i class="fa fa-comments"></i> Rating &amp; Comments</a></li>																							
									</ul>		
																					
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<div class="col-md-6">
													{{ Rating System }}
												</div>
												<div class="col-md-6">
													<!---
													<div class="social-feed-box">
														<div class="pull-right social-action dropdown">
															<button data-toggle="dropdown" class="dropdown-toggle btn-white">
																<i class="fa fa-angle-down"></i>
															</button>
															<ul class="dropdown-menu m-t-xs">
																<li><a href="">Config</a></li>
															</ul>
														</div>
														<div class="social-avatar">
															<a href="" class="pull-left">
																<img alt="image" src="img/a4.jpg">
															</a>
															<div class="media-body">
																<a href="">
																	Andrew Williams
																</a>
																<small class="text-muted">Today 4:21 pm - 12.06.2014</small>
															</div>
														</div>
														<div class="social-body">
															<p>
																 Packages and web page editors now use Lorem Ipsum as their
																default model text. Page editors now use Lorem Ipsum as their
																default model text.
															</p>
															<div class="btn-group">
																<button class="btn btn-white btn-xs"><i class="fa fa-thumbs-up"></i> Like this!</button>
																<button class="btn btn-white btn-xs"><i class="fa fa-comments"></i> Comment</button>
																<button class="btn btn-white btn-xs"><i class="fa fa-share"></i> Share</button>
															</div>
														</div>
														<div class="social-footer">


															<div class="social-comment">
																<a href="" class="pull-left">
																	<img alt="image" src="img/a8.jpg">
																</a>
																<div class="media-body">
																	<a href="">
																		Andrew Williams
																	</a>
																	Making this the first true generator on the Internet. It uses a dictionary of.
																	<br>
																	<a href="" class="small"><i class="fa fa-thumbs-up"></i> 11 Like this!</a> -
																	<small class="text-muted">10.07.2014</small>
																</div>
															</div>

															<div class="social-comment">
																<a href="" class="pull-left">
																	<img alt="image" src="img/a3.jpg">
																</a>
																<div class="media-body">
																	<textarea class="form-control" placeholder="Write comment..."></textarea>
																</div>
															</div>
														</div>
													</div>
													--->
												</div>												
											</div>
										</div>											
									</div><!-- / .tab-content -->
								</div><!-- / .tab-container -->	
							</div>					
						</div>				
					</div>
				</cfoutput>