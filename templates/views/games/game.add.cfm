						
						
						
						
						
						
						




						<cfoutput>
							<div class="ibox">				
								<div class="ibox-title">
									<h5><i class="fa fa-search"></i> Create Game Schedules</h5>
									<span class="pull-right">																				
										<a href="#application.root##url.event#" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-play-circle"></i> Game Admin Home</a>
										<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=teams.view" class="btn btn-xs btn-success btn-outline"><i class="fa fa-trophy"></i> Conference Standings</a>
										<a style="margin-right:5px;" href="#application.root#user.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-dashboard"></i> Dashboard</a>
									</span>
								</div>
								<div class="ibox-content ibox-heading border-bottom" style="min-height:200px;">									
									<cfinclude template="game-form-add.cfm">
								</div>			
							</div>
						</cfoutput>




	