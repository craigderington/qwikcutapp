

					<cfif structkeyexists( session, "userid" ) and structkeyexists( url, "gameid" ) and structkeyexists( url, "do" )>
						<cfif isnumeric( url.gameid ) and trim( url.do ) eq "game">
							<cfset session.vsid = url.gameid />
							<cflocation url="#application.root#shooter.game" addtoken="yes">
						</cfif>
					</cfif>

				
				
				
					
				
				
					<cfoutput>
						<div class="row" style="margin-top:15px;">						
							<div class="ibox">
								<div class="ibox-title">
									<h5><i class="fa fa-video-camera"></i> Welcome #session.username#</h5>
									<span class="pull-right">
										<a href="#application.root#shooter.games" class="btn btn-xs btn-success btn-outline"><i class="fa fa-play-circle"></i> My Games</a>
										<a href="#application.root#user.profile" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-user"></i> My Profile</a>
										<a href="#application.root#user.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cog"></i> My Settings</a>
									</span>								
								</div>							
								<div class="ibox-content" style="min-height:600px;">									
									<div class="col-md-6">
										<cfinclude template="views/shooters/shooter-assignments.cfm">
									</div>									
									<div class="col-md-6">
										<cfinclude template="views/shooters/shooter-games.cfm">
									</div>								
								</div>
							</div>
						</div>				
					</cfoutput>
				
				
				
				
				
				
				
				
				