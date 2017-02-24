

					<cfif structkeyexists( session, "userid" ) and structkeyexists( url, "gameid" ) and structkeyexists( url, "do" )>
						<cfif isnumeric( url.gameid ) and trim( url.do ) eq "game">
							<cfset session.vsid = url.gameid />
							<cflocation url="#application.root#shooter.game" addtoken="yes" />
						</cfif>
					</cfif>

				
				
				
					
				
				
					<cfoutput>
						
								<div class="text-center animated fadeInRightBig" style="margin-top:15px;">
									<div class="col-lg-12 white-bg">                        
										<h3><i class="fa fa-video-camera"></i> Welcome #session.username#</h3>
										<button 
											type="button" 
											class="btn btn-success btn-lg btn-block"
											onclick="window.location.href='#application.root#shooter.assignments';">
											<i class="fa fa-arrow-circle-right"></i> 
											View Game Assignments
										</button>
										<button 
											type="button" 
											class="btn btn-primary btn-lg btn-block"
											onclick="window.location.href='#application.root#shooter.games';">
											<i class="fa fa-soccer-ball-o"></i> 
											View Games
										</button> 
										<button 
											type="button" 
											class="btn btn-info btn-lg btn-block"
											onclick="window.location.href='#application.root#shooter.games';">
											<i class="fa fa-play-circle"></i> 
											Game Check In
										</button>                        
										<button 
											type="button" 
											class="btn btn-danger btn-lg btn-outline btn-block"
											onclick="window.location.href='#application.root#user.profile';">
											<i class="fa fa-user"></i> 
											Update Your Profile
										</button>                        
										<button 
											type="button" 
											class="btn btn-default btn-outline btn-lg btn-block"
											onclick="window.location.href='#application.root#user.logout';">
											<i class="fa fa-sign-out"></i> 
											Logout
										</button>
										<p>&nbsp;</p>
									</div>
								</div>
										
					</cfoutput>
				
				
				
				
				
				
				
				
				