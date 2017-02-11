


				<cfinvoke component="apis.com.qwikstats.dashboard" method="getteamroster" returnvariable="teamroster">
					<cfinvokeargument name="id" value="#session.teamid#">
				</cfinvoke>


				<div class="wrapper wrapper-content animated fadeIn">
					
						
						<cfoutput>	
							
							
							
							<div class="row" style="margin-top:20px;">							
								<div class="ibox">
									<div class="ibox-title">
										<i class="fa fa-trophy"></i> #session.teamname# Team Roster
									</div>
									<div class="ibox-content">									
										<cfif teamroster.recordcount gt 0>
											<h5><i class="fa fa-th-list"></i> #teamroster.recordcount# player<cfif teamroster.recordcount neq 1>s</cfif> found.</h5>
												<div class="table-responsive">									
													<table class="table table-striped">
														<thead>
															<tr>										
																<th>Name</th>
																<th>Position</th>
																<th>Number</th>
																<th>Status</th>
															</tr>
														</thead>
														<tbody>
															<cfloop query="teamroster">
																
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
																		<cfcase value="LSM">
																			<cfset position = "Long-Stick Midfielder" />
																		</cfcase>																	
																		<cfdefaultcase>
																			<cfset position = #playerposition# />
																		</cfdefaultcase>
																	</cfswitch>
																
																	<tr>														
																		<td><i class="fa fa-user"></i> <a href="">#playername#</a></td>
																		<td>#position#</td>
																		<td>#playernumber#</td>
																		<td><cfif playerstatus eq 1><i title="Active" class="fa fa-check-circle text-success"></i><cfelse><i title="Inactive" class="fa fa-ban text-danger"></cfif></td>
																	</tr>
																</cfloop>
															</tbody>
															<tfoot>
																<tr><td colspan="5"><small><i class="fa fa-info-circle"></i> Click the player name to view individual stats. <span class="pull-right"><i class="fa fa-check-circle text-success"></i> Active Player</span></td></small></tr>
															</tfoot>
														</table>
												</div>
										<cfelse>
											<div class="alert alert-danger alert-box">
												<h5><i class="fa fa-warning"></i> Team Roster Not Found. </h5> 
													<p>No Team Roster Found!</p>
												</div>
										</cfif>					
									</div>
									
								</div>
							</div>
							
							
							
							
						</cfoutput>					
							
												
							
						
					
				</div><!-- /.wrapper-content -->