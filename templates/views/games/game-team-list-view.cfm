









						<cfoutput>
							<div class="row">
								<div class="ibox-title">
									<h5><i class="fa fa-mobile"></i> Team Games</h5>
									<span class="pull-right">
										<a href="" class="btn btn-xs btn-primary"><i class="fa fa-refresh"></i> Reschedule</a>
									</span>
								</div>
								
								<div class="ibox-content ibox-heading text-center border-bottom">
									<small>#games.recordcount# game scheduled</small>
								</div>
								
								<div class="ibox-content">
									<div class="feed-activity-list">										
										<cfloop query="games">
											<div class="feed-element">
												<div>
													<small class="pull-right text-navy">#timeformat( gamestart, "hh:mm tt" )#</small>
													<strong>#teamlevelname#</strong>
													<div><small>#awayteam# vs.</i> #hometeam#</small></div>												
													<small class="text-muted">#gamestatus#</small>
												</div>
											</div>										
										</cfloop>
									</div>
								</div>			
							
							</div>
						</cfoutput>