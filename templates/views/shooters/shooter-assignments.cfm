



					<cfinvoke component="apis.com.user.usershooterservice" method="getshooterassignments" returnvariable="shooterassignments">
						<cfinvokeargument name="userid" value="#session.userid#">
					</cfinvoke>
					
					<cfset today = now() />
					
					<cfoutput>	
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-check-circle-o"></i> New Assignments</h5>
								<span class="pull-right">
									<a href="#application.root#shooter.games" class="btn btn-xs btn-white"><i class="fa fa-briefcase"></i> View Assignment History</a>
								</span>
							</div>
							<div class="ibox-content">
								<cfif shooterassignments.recordcount gt 0>
									<div class="table-responsive">
										<table class="table table-striped table-hover">
											<thead>
												<tr class="small">													
													<th>Game Date</th>
													<th>Game</th>
													<th>Field</th>
													<th>Accept</th>
												</tr>
											</thead>
											<tbody>
												<cfloop query="shooterassignments">
													<tr class="small">														
														<td>#dateformat( gamedate, "mm-dd-yyyy" )# : #timeformat( gametime, "hh:mm tt" )#</td>
														<td>#hometeam# vs #awayteam#</td>
														<td>#fieldname# Field</td>
														<td><a href="#application.root#shooter.accept&saID=#shooterassignmentid#&vsid=#vsid#&acceptdate=#today#" class="btn btn-xs btn-primary"><i class="fa fa-check-circle-o"></i> Accept</a></td>
													</tr>
												</cfloop>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="4"><small class="help-block">* You must accept assignments to confirm your filming schedule.</small></td>
												</tr>
											</tfoot>
										</table>
									</div>
								<cfelse>
									<div class="alert alert-info">
										<p class="small"><i class="fa fa-clock-o"></i> You have no recent assignments.</p>
									</div>
								</cfif>
							</div>					
						</div>				
					</cfoutput>