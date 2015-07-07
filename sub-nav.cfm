					
					
					
							<cfoutput>	
								<nav class="navbar navbar-static-top" role="navigation">
									<div class="navbar-header">
										<button aria-controls="navbar" aria-expanded="false" data-target="##navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
											<i class="fa fa-reorder"></i>
										</button>
										<a href="#application.root#page.index" class="navbar-brand"><i class="fa fa-upload"></i> QwikCut</a>
									</div>
					
										<div class="navbar-collapse collapse" id="navbar">
											<ul class="nav navbar-nav">
												<li class="active">
													<a aria-expanded="false" role="button" href="#application.root#page.index"> Game Video &amp; Analytics | Dashboard</a>
												</li>
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
												
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-gear"></i> Administration <span class="caret"></span></a>
														<ul role="menu" class="dropdown-menu">
															<li><a href="#application.root#states">States</a></li>
															<li><a href="#application.root#conferences">Conferences</a></li>
															<li><a href="#application.root#teams">Teams</a></li>
															<li><a href="#application.root#fields">Fields</a></li>
															<li><a href="#application.root#shooters">Shooters</a></li>
														</ul>
												</li>
											</ul>
												
											<ul class="nav navbar-right">
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-gears"></i> #getauthuser()# <span class="caret"></span></a>
														<ul role="menu" class="dropdown-menu">
															<li><a href=""><i class="fa fa-user"></i> My Profile</a></li>
															<li><a href=""><i class="fa fa-gears"></i> Settings</a></li>
															<li><a href=""><i class="fa fa-calendar-o"></i> Reminders</a></li>
															<li><a href="#application.root#page.logout"><i class="fa fa-sign-out"></i> Log Out</a></li>																								
														</ul>
												</li>
											</ul>
											
										</div>
								</nav>
							</cfoutput>