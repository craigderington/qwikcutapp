


					




						<cfinvoke component="apis.com.user.usershooterservice" method="getcompletedgames" returnvariable="gamescomplete">




						<cfoutput>	
							<div class="ibox">
								<div class="ibox-title">
									<h5><i class="fa fa-check-square text-primary"></i> Games Completed</h5>
									<span class="pull-right">
										<a href="#application.root#shooter.games" class="btn btn-xs btn-white"><i class="fa fa-film"></i> View Game History</a>
									</span>
								</div>
								<div class="ibox-content">
									<cfif gamescomplete.recordcount gt 0>
										<div class="table-responsive">
											<small>
												<table class="table table-hover">
													<thead>
														<tr>
															<th>Game ID</th>
															<th>Teams</th>
															<th>Date</th>
															<th>Status</th>
														</tr>
													</thead>
													<tbody>
														<cfloop query="gamescomplete" maxrows="10">
															<tr>
																<td><a href="#application.root##url.event#&do=game&gameid=#vsid#" class="label label-success">#vsid#</a></td>
																<td>#awayteam# <i>vs.</i> <strong>#hometeam#</strong></td>
																<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>
																<td><i title="Game Completed" class="fa fa-circle text-navy"></i></td>
															</tr>
														</cfloop>
													</tbody>
													<tfoot>
														<tr>
															<td colspan="4">Showing #gamescomplete.recordcount# game<cfif gamescomplete.recordcount gt 1>s</cfif> completed...</td>
														</tr>
													</tfoot>
												</table>
											</small>
										</div>
									<cfelse>
										<div class="alert alert-warning">
											<h5><i class="fa fa-warning"></i> No Records Found</h5>
											<p>There are no completed games to show.</p>
											<p>&nbsp;</p>
											<p>In order for items to display in this list, you must accept game assignments, check-in on Game Day at the field, complete game status updates and then close out all games and Checkout.</p>
										</div>
									</cfif>
								</div>
							</div>				
						</cfoutput>