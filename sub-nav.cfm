					
					
							<cfif IsUserLoggedIn()>
								<cfoutput>	
									<nav class="navbar navbar-fixed-top" role="navigation">
										<div class="navbar-header">
											<button aria-controls="navbar" aria-expanded="false" data-target="##navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
												<i class="fa fa-reorder"></i>
											</button>
											<a href="#application.root#user.home" class="navbar-brand"><i class="fa fa-upload"></i> QwikCut</a>
										</div>
						
											<div class="navbar-collapse collapse" id="navbar">
												<ul class="nav navbar-nav">
													<li class="active">
														<a aria-expanded="false" role="button" href="#application.root#user.home"> Game Video &amp; Analytics <cfif structkeyexists( url, "event" ) and trim( url.event ) eq "user.home">| Dashboard</cfif></a>
													</li>
												</ul>	
													<!---
													<li class="dropdown">
														<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-trophy"></i> Conferences <span class="caret"></span></a>
															<ul role="menu" class="dropdown-menu">
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
															</ul>
													</li>
													<li class="dropdown">
														<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-users"></i> Teams <span class="caret"></span></a>
															<ul role="menu" class="dropdown-menu">
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
															</ul>
													</li>
													<li class="dropdown">
														<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-calendar-o"></i> Game Schedules <span class="caret"></span></a>
															<ul role="menu" class="dropdown-menu">
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
																<li><a href="">Menu item</a></li>
															</ul>
													</li>												
													--->
												<ul class="nav navbar-right">
													
													<!---
													<li class="dropdown">
														<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-gear"></i> Administration <span class="caret"></span></a>
															<ul role="menu" class="dropdown-menu">
																<li><a href="#application.root#admin.states">States</a></li>
																<li><a href="#application.root#admin.conferences">Conferences</a></li>
																<li><a href="#application.root#admin.teams">Teams</a></li>
																<li><a href="#application.root#admin.fields">Fields</a></li>
																<li><a href="#application.root#admin.shooters">Shooters</a></li>
																<li><a href="#application.root#admin.users">Users</a></li>
															</ul>
													</li>
													--->
													
												
													<li class="dropdown">
														<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-gears"></i> #GetAuthUser()# <span class="caret"></span></a>
															<ul role="menu" class="dropdown-menu">
																<cfif isuserinrole( "admin" )><li><a href="#application.root#admin.home"><i class="fa fa-cog"></i> Administration</a></li></cfif>
																<li><a href=""><i class="fa fa-user"></i> My Profile</a></li>
																<li><a href=""><i class="fa fa-gears"></i> Settings</a></li>
																<li><a href=""><i class="fa fa-calendar-o"></i> Reminders</a></li>
																<li><a href="#application.root#user.logout"><i class="fa fa-sign-out"></i> Log Out</a></li>																								
															</ul>
													</li>
												</ul>
												
											</div>
									</nav>
								</cfoutput>
							</cfif>