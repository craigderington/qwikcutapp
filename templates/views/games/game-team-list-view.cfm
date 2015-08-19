









						<cfoutput>
							<div class="row">
								<div class="ibox-title">
									<h5><i class="fa fa-play-circle"></i> Team Games</h5>
									<span class="pull-right">
										<cfif isuserinrole( "admin" )>
											<cfif structkeyexists( url, "manage" )>
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-xs btn-success"><i class="fa fa-times-circle"></i> Finished Rescheduling</a>
											<cfelse>
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=schedule" class="btn btn-xs btn-primary"><i class="fa fa-refresh"></i> Reschedule</a>
											</cfif>
										<cfelseif isuserinrole( "shooter" )>
											<cfif structkeyexists( session, "checkedinstatus" )>
												<cfif structkeyexists( url, "gamestatus" )>
													<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-xs btn-success"><i class="fa fa-times-circle"></i> Close Game Status</a>
												<cfelse>																		
													<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&gamestatus=update" class="btn btn-xs btn-primary"><i class="fa fa-refresh"></i> Record Game Status</a>
												</cfif>										
											</cfif>
										</cfif>
										
									</span>
								</div>
								
								<div class="ibox-content ibox-heading text-center border-bottom">
									<cfif structkeyexists( url, "manage" ) and isuserinrole( "admin" )>
										<small>Select an individual game to edit the game date or game time.</small>
									<cfelseif structkeyexists( url, "gamestatus" ) and isuserinrole( "shooter" )>
										<cfif structkeyexists( session, "checkedinstatus" )>
											<small>Select an individual game to update the game status.</small>
										</cfif>									
									<cfelse>
										<small>#games.recordcount# game<cfif ( games.recordcount gt 0 ) or ( games.recordcount eq 0 )>s</cfif> scheduled</small>									
									</cfif>
								</div>
								
								<div class="ibox-content">
									<div class="feed-activity-list">										
										<cfloop query="games">
											<div class="feed-element">
												<div>
													<small class="pull-right text-navy">#dateformat( gamedate, "mm-dd-yyyy" )#</small>													
													<strong>#teamlevelname#</strong>
													<cfif structkeyexists( url, "manage" ) and isuserinrole( "admin" )>
													<div><small class="pull-right"><a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#&id=#gameid#" class="btn btn-xs btn-default"><i class="fa fa-circle-o"></i> Edit Game</a></small></div>
													</cfif>
													<div><small>#awayteam# vs.</i> #hometeam#</small></div>												
													<small class="text-muted">#gamestatus#</small><small class="pull-right"><cfif structkeyexists( session, "checkedinstatus" ) and structkeyexists( session, "shooterid" )><cfif structkeyexists( url, "gamestatus" )>					
															<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=#url.fuseaction#&gamestatus=update&sgid=#gameid#"><i class="fa fa-play-circle fa-2x"></i></a>
														</cfif>													
													</cfif>


													#timeformat( gamestart, "hh:mm tt" )#</small>
												</div>
											</div>										
										</cfloop>
									</div>
								</div>		
							</div>	
						</cfoutput>