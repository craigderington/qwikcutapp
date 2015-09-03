






				
													
						
						
						
						
						
						




						<cfoutput>
							<div class="ibox">				
								<div class="ibox-title">
									<h5><i class="fa fa-play-circle"></i> Create Custom Non-Conference Game Matchups</h5>
									<span class="pull-right">									
										<a href="#application.root##url.event#&fuseaction=game.schedule" class="btn btn-xs btn-success btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to Game Scheduler</a>
										<a href="#application.root##url.event#" style="margin-right:5px;margin-left:5px;" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-play-circle"></i> Game Admin Home</a>
										<a href="#application.root#user.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-dashboard"></i> Dashboard</a>
									</span>
								</div>
								<div class="ibox-content border-bottom" style="min-height:600px;">									
									<div class="col-md-6">
										<cfinclude template="game-custom-nc-schedule-form.cfm">
									</div>
									<div class="col-md-6">
										<cfinclude template="game-custom-schedule.cfm">
									</div>
								</div>			
							</div>
						</cfoutput>




	