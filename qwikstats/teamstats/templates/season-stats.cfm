

	
	
				<cfinvoke component="apis.com.qwikstats.dashboard" method="getgameseason" returnvariable="gameseason">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="getgameseasons" returnvariable="gameseasons">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="getseasonstats" returnvariable="seasonstats">
				</cfinvoke>
				
				<cfparam name="teamtotalgoals" default="0">
				<cfparam name="teamtotalshots" default="0">
				<cfparam name="teamtotalassists" default="0">
				<cfparam name="teamtotalsaves" default="0">
				<cfparam name="teamtotalgrounders" default="0">
				<cfparam name="teamtotalturnovers" default="0">
				<cfparam name="teamtotalforced" default="0">
				<cfparam name="teamtotalpenalties" default="0">
				
				
				
				<div class="wrapper wrapper-content animated fadeIn">					
						
					<cfoutput>					
							
						<div class="row" style="margin-top:20px;">							
							<div class="ibox">
								<div class="ibox-title">
									<i class="fa fa-trophy"></i> #gameseason.gameseason# Season Statistics for #session.teamname#
								</div>
								<div class="ibox-content">
									
									<form class="form-inline" method="post" name="gameseason" action="#application.root#season.stats">
										<div class="form-group">
											<label class="sr-only" for="exampleInputAmount">Filter Game Season</label>
											<div class="input-group">
												<select class="form-control" name="gameseason" onchange="javascript:this.form.submit();">
													<cfloop query="gameseasons">
														<option value="#gameseason#"<cfif gameseasonactive eq 1>selected<cfelse>disabled</cfif>>#gameseason#</option>
													</cfloop>
												</select>
											</div>
											<button type="submit" class="btn btn-primary">Filter Season</button>
										</div>
									</form>							
									
									<cfif gameseason.recordcount gt 0>
										<div class="table-responsive" style="margin-top:15px;">									
											<table class="table table-striped">
												<thead>
													<tr class="info">										
														<th>Player Name</th>
														<th>Position</th>
														<th>Number</th>
														<th>Goals</th>
														<th>Shots</th>
														<th>Assists</th>
														<th>Saves</th>
														<th>Grounders</th>
														<th>Turnovers</th>
														<th>Forced Turnovers</th>
														<th>Penalties</th>
														<th>Status</th>
													</tr>
												</thead>
												<tbody>
													<cfloop query="seasonstats">
														<cfswitch expression="#playerposition#">
															<cfcase value="M">
																<cfset position = "Midfielder" />
															</cfcase>
															<cfcase value="A">
																<cfset position = "Attacker" />
															</cfcase>
															<cfcase value="D">
																<cfset position = "Defender" />
															</cfcase>
															<cfcase value="G">
																<cfset position = "Goalie" />
															</cfcase>
															<cfcase value="LSM">
																<cfset position = "Long-Stick Midfielder" />
															</cfcase>																	
															<cfdefaultcase>
																<cfset position = #playerposition# />
															</cfdefaultcase>
														</cfswitch>										
													
														<tr>
															<td><strong>#playername#</strong></td>
															<td><span class="label label-primary">#position#</span></td>
															<td><span class="badge badge-success">#playernumber#</span></td>
															<td>#totalgoals#</td>
															<td>#totalshots#</td>
															<td>#totalassists#</td>
															<td>#totalsaves#</td>
															<td>#totalgrounders#</td>
															<td>#totalturnovers#</td>
															<td>#totalforced#</td>
															<td>#totalpenalties#</td>
															<td><i class="fa fa-check-circle text-success"></i></td>
														</tr>
														
														<!--- // set our team total vars for the table footer --->
														<cfset teamtotalgoals = teamtotalgoals + totalgoals />
														<cfset teamtotalshots = teamtotalshots + totalshots />
														<cfset teamtotalassists = teamtotalassists + totalassists />
														<cfset teamtotalsaves = teamtotalsaves + totalsaves />
														<cfset teamtotalgrounders = teamtotalgrounders + totalgrounders />
														<cfset teamtotalturnovers = teamtotalturnovers + totalturnovers />
														<cfset teamtotalforced = teamtotalforced + totalforced />
														<cfset teamtotalpenalties = teamtotalpenalties + totalpenalties />														
														
													</cfloop>
													
													<tr class="danger">
														<td class="default" colspan="3"><strong>Team Totals:</strong></td>
														<td>#teamtotalgoals#</td>
														<td>#teamtotalshots#</td>
														<td>#teamtotalassists#</td>
														<td>#teamtotalsaves#</td>
														<td>#teamtotalgrounders#</td>
														<td>#teamtotalturnovers#</td>
														<td>#teamtotalforced#</td>
														<td>#teamtotalpenalties#</td>
														<td>&nbsp;</td>
													</tr>
													
												</tbody>												
												<tfoot>
													<tr class="warning">
														<td colspan="6"><small><i class="fa fa-info-circle"></i> #seasonstats.recordcount# player game statistics found.</small></td>
														<td colspan="6"><span class="pull-right"><small><i class="fa fa-check-circle text-success"></i> Active Player</small></span></td>
													</tr>
												</tfoot>
											</table>
										</div>
									<cfelse>
										
										<div class="alert alert-box alert-danger alert-dismissable" role="alert">
											<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											<h4><i class="fa fa-warning"></i> No Stats Found
											<p>There are no stats found for the selected team in the current game season.
										</div>
									
									</cfif>
								</div>
								<div class="ibox-footer">
									footer
								</div>
							</div>
						</div>				
							
					</cfoutput>			
					
				</div><!-- /.wrapper-content -->