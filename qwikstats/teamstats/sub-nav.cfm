					
					
							<cfif IsUserLoggedIn()>
							
								<cfif structkeyexists( session, "teamid" )>
									<cfinvoke component="apis.com.qwikstats.dashboard" method="getheader" returnvariable="sHeader">
										<cfinvokeargument name="teamid" value="#session.teamid#">
									</cfinvoke>
							
									<cfoutput>	
										<nav class="navbar navbar-fixed-top" role="navigation">
											<div class="navbar-header">
												<button aria-controls="navbar" aria-expanded="false" data-target="##navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
													<i class="fa fa-reorder"></i>
												</button>
												<a href="#application.root#dashboard" class="navbar-brand"><i class="fa fa-soccer-ball-o"></i> QwikStats</a>
											</div>
							
												<div class="navbar-collapse collapse" id="navbar">
													<ul class="nav navbar-nav">														
														<li>
															<a aria-expanded="false" role="button" disabled class="text-success">
																#sHeader.teamname#
															</a>
														</li>
														<li>
															<a aria-expanded="false" role="button" disabled class="text-success">
																#sHeader.confname#
															</a>
														</li>
														<li <cfif structkeyexists( url, "event" ) and trim( url.event ) is "dashboard">class="active"</cfif>>
															<a aria-expanded="false" role="button" class="text-success" href="#application.root#dashboard">
																Stat Leaders
															</a>
														</li>
														<li <cfif structkeyexists( url, "event" ) and trim( url.event ) is "season.stats">class="active"</cfif>>
															<a aria-expanded="false" role="button" class="text-success" href="#application.root#season.stats">
																Season Stats
															</a>
														</li>
														<li <cfif structkeyexists( url, "event" ) and trim( url.event ) is "game.stats">class="active"</cfif>>
															<a aria-expanded="false" role="button" class="text-success" href="#application.root#game.stats">
																Game Stats
															</a>
														</li>
														<li <cfif structkeyexists( url, "event" ) and trim( url.event ) is "team.roster">class="active"</cfif>>
															<a aria-expanded="false" role="button" class="text-success" href="#application.root#team.roster">
																Team Roster
															</a>
														</li>
														<li>
															<a aria-expanded="false" role="button" class="text-success" href="http://qwikcut.cloudapp.net/qwikstats/lacrosse/" target="_blank">
																Conference Leaders
															</a>
														</li>											
													</ul>
													<ul class="nav navbar-right" style="margin-right:10px;float:right;">													
														<li><a href="#application.root#do.logout"><i class="fa fa-sign-out"></i> Logout</a></li>							
													</ul>
													
												</div>
										</nav>
									</cfoutput>
								<cfelse>
									<nav class="navbar navbar-fixed-top" role="navigation">
										<div class="navbar-header">
											<button aria-controls="navbar" aria-expanded="false" data-target="##navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
												<i class="fa fa-reorder"></i>
											</button>
											<a href="" class="navbar-brand"><i class="fa fa-soccer-ball-o"></i> QwikStats</a>
										</div>
							
										<div class="navbar-collapse collapse" id="navbar">
											<ul class="nav navbar-nav">
												<li class="text-danger">
													<i class="fa fa-warning"></i> TEAM INFO NOT FOUND.  CONTACT QWIKSTATS!		
												</li>																										
											</ul>
											<ul class="nav navbar-right" style="margin-right:10px;float:right;">												
												<li><a href=""><i class="fa fa-sign-out"></i> Logout</a></li>							
											</ul>													
										</div>
									</nav>
								</cfif>								
							</cfif>