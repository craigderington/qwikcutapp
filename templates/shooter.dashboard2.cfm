

					<cfif structkeyexists( session, "userid" ) and structkeyexists( url, "gameid" ) and structkeyexists( url, "do" )>
						<cfif isnumeric( url.gameid ) and trim( url.do ) eq "game">
							<cfset session.vsid = url.gameid />
							<cflocation url="#application.root#shooter.game" addtoken="yes" />
						</cfif>
					</cfif>

				
				
				
					
				
				
					<cfoutput>
						<div class="row" style="margin-top:15px;">						
							<h5><i class="fa fa-video-camera"></i> Welcome #session.username#</h5>
							<div class="wrapper wrapper-content">
								<div class="middle-box text-center animated fadeInRightBig">
									<div class="col-lg-12 white-bg">                        
										<p>&nbsp;</p>
										<button type="button" class="btn btn-success btn-lg btn-block"><i class="fa fa-arrow-circle-right"></i> View Game Assignments</button>
										<button type="button" class="btn btn-primary btn-lg btn-block"><i class="fa fa-soccer-ball-o"></i> View Completed Games</button> 
										<button type="button" class="btn btn-info btn-lg btn-block"><i class="fa fa-play-circle"></i> Game Check In</button>                        
										<button type="button" class="btn btn-danger btn-lg btn-outline btn-block"><i class="fa fa-user"></i> Update Your Profile</button>                        
										<button type="button" class="btn btn-default btn-outline btn-lg btn-block"><i class="fa fa-sign-out"></i> Logout</button>
										<p>&nbsp;</p>
									</div>
								</div>
							</div>							
						</div>				
					</cfoutput>
				
				
				
				
				
				
				
				
				