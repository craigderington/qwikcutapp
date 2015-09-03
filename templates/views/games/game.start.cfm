





				<cfoutput>
					<div class="row">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-play-circle"></i> Select Game Type</h5>
								<span class="pull-right">
									<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to Games Manager</a> 
								</span>
							</div>
							<div class="ibox-content" style="min-height:300px;">								
								<div class="col-md-4">
									<a href="#application.root##url.event#&fuseaction=game.add" class="btn btn-lg btn-success btn-outline m-b">
										<i class="fa fa-play-circle"></i> Conference Games (All Divisions)
									</a>
									<a href="#application.root##url.event#&fuseaction=game.custom" class="btn btn-lg btn-primary btn-outline m-b">
										<i class="fa fa-play-circle"></i> Conference Game (Custom Matchup)
									</a>								
									<a href="#application.root##url.event#&fuseaction=game.custom" class="btn btn-lg btn-danger btn-outline m-b">
										<i class="fa fa-play-circle"></i> Non-Conference Games (All Divisions)
									</a>
									<a href="#application.root##url.event#&fuseaction=game.custom.nc" class="btn btn-lg btn-default btn-outline m-b">
										<i class="fa fa-play-circle"></i> Non-Conference Game (Custom Matchup)
									</a>
								</div>
							</div>
						</div>
					</div>
				</cfoutput>