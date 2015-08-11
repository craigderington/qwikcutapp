					
					
					
					
					
					<!--- // get the user activity --->
					<cfinvoke component="apis.com.activity.activityservice" method="getuseractivity" returnvariable="useractivity">
						<cfinvokeargument name="id" value="#session.userid#">
					</cfinvoke>
					
					
					
					
						
						
					<cfoutput>	
						<div class="row">						
							<div class="ibox collapsed">
								<div class="ibox-title">
									<h5><i class="fa fa-database"></i> Your Recent Activity</h5>
										<div class="ibox-tools">
											<a class="collapse-link">
												<i class="fa fa-chevron-up"></i>
											</a>																				
											<a class="close-link">
												<i class="fa fa-times"></i>
											</a>											
										</div>
								</div>
								<div class="ibox-content">
									<cfif useractivity.recordcount gt 0>
										<div class="table-responsive">
											<table class="table table-bordered table-hover">
												<thead>
													<tr>
														<th>Date</th>
														<th>Type</th>
														<th>Activity</th>
													</tr>
												</thead>
												<tbody>												
													<cfloop query="useractivity" startrow="1" endrow="15">
														<tr>
															<td>#dateformat( activitydate, "mm/dd/yyyy" )# at #timeformat( activitydate, "hh:mm tt" )#</td>
															<td>#activitytype#</td>
															<td>#firstname# #lastname# #trim( activitytext )#</td>
														</tr>
													</cfloop>												
												</tbody>
												<tfoot>
													<tr>
														<td colspan="3"><span class="pull-right"><i class="fa fa-th-list"></i> <cfif useractivity.recordcount GT 14>Showing 15 most recent records...<cfelse>Showing #useractivity.recordcount# record<cfif useractivity.recordcount gt 1>s</cfif></cfif>.</span></td>
													</tr>
												</tfoot>
											</table>
										</div>
									<cfelse>
										<div class="alert alert-danger">
											<p><i class="fa fa-warning"></i> <a class="alert-link" href="">No Records Found!</a></p>
											<p>There are no user activity records to display in this view...</p>
										</div>								
									</cfif>
								</div>
							</div>							
						</div>
					</cfoutput>