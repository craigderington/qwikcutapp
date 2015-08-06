





							
				
				
							<div class="ibox">
				
								<div class="ibox-title">
									<h5><i class="fa fa-search"></i> Filter Your Results</h5>
								</div>

									<div class="ibox-content m-b-sm border-bottom">
										<div class="row">
												
										</div>
									</div>
							</div>
							
								
							<cfoutput>	
								<div class="ibox" style="margin-top:-15px;">								
									
									<div class="ibox-title">									
										<h5><i class="fa fa-database"></i> The database found #gameslist.recordcount# scheduled games<cfif gameslist.recordcount gt 0>s</cfif>.</h5>										
										<span class="pull-right">
											<a href="#application.root##url.event#&fuseaction=game.add" class="btn btn-xs btn-primary"><i class="fa fa-clock-o"></i> Schedule Games </a>										
											<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=teams.view" class="btn btn-xs btn-success"><i class="fa fa-trophy"></i> Conference Standings</a>
										</span>
									</div>
									
									<div class="ibox-content ibox-heading bottom-border">
										<h3 class="text-center"><i>GAMES IN DEVELOPMENT</i></h3>
									</div>
									
									<div class="ibox-content">										
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
												<h5><i class="fa fa-warning"></i> This section is currently under development....</h5>													
												<p>Please check back soon.</p>
										</div>
									</div>
								</div>
							</cfoutput>
								
								
								
						