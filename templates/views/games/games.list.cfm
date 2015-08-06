


						<cfif structkeyexists( session, "vsid" )>
							<cfset tempvs = structdelete( session, "vsid" ) />
						</cfif>


							
						<cfoutput>
				
							<div class="ibox">				
								<div class="ibox-title">					

									<h5><i class="fa fa-play-circle"></i> #session.username# | Manage Team Game Schedules</h5>
									<span class="pull-right">																				
										<a style="margin-right:5px;" href="#application.root#admin.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-home"></i> Admin Home</a>
										<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=teams.view" class="btn btn-xs btn-success btn-outline"><i class="fa fa-trophy"></i> Conference Standings</a>									
										<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=game.add" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-plus-square"></i> Create Game Schedules</a>
									</span>
								</div>
								<div class="ibox-content ibox-heading">
									<h4 class="text-center"><strong>MANAGE TEAM GAME SCHEDULES</strong></h4>
										<cfif structkeyexists( url, "gvs" )>
											<cfif url.gvs eq 1>
												<div class="text-center">
													<span style="margin-top:10px;padding:5px;" class="label label-danger"><i class="fa fa-warning"></i> Error Retrieving Game Information.  </span>
												</div>
											</cfif>
										</cfif>						
								</div>						
								
								<div class="ibox-content">
									<div class="tabs-container">
										<ul class="nav nav-tabs">
											<li class="active"><a href="##tab-1"><i class="fa fa-search"></i> Search</a></li>
											<li class=""><a href="#application.root##url.event#&fuseaction=games.filter"><i class="fa fa-th-list"></i> Games By Conference</a></li>
										</ul>
										
											<div class="tab-content">
												<div id="tab-1" class="tab-pane active">
													<div class="panel-body">								
														<cfinclude template="games-form-search.cfm">									
													</div>						
												</div>
											</div>
									</div>
								</div>
							
						</cfoutput>
