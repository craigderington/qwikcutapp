

	
	
	
			<!--- // get the user activity --->
			<cfinvoke component="apis.com.activity.activityservice" method="getuseractivity" returnvariable="useractivity">
				<cfinvokeargument name="id" value="#session.userid#">
			</cfinvoke>

				
			<cfoutput>	
				<div class="wrapper wrapper-content animated fadeInRight">
					<div class="row" style="margin-top:25px;">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-th-list"></i> #session.username# | User Activity</h5>
								<span class="pull-right">
									<a href="#application.root#user.home" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-dashboard"></i> Dashboard</a>
								</span>								
							</div>
							<div class="ibox-content">						
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class=""><a href="#application.root#user.profile"><i class="fa fa-user"></i> My Profile</a></li>
										<li class=""><a href="#application.root#user.settings"><i class="fa fa-cog"></i> Settings</a></li>
										<li class=""><a href="#application.root#user.image"><i class="fa fa-image"></i> Profile Image</a></li>
										<li class="active"><a href="#application.root#user.activity"><i class="fa fa-database"></i> User Activity</a></li>
									</ul>
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
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
																<cfloop query="useractivity">
																	<tr>
																		<td>#dateformat( activitydate, "mm/dd/yyyy" )# at #timeformat( activitydate, "hh:mm tt" )#</td>
																		<td>#activitytype#</td>
																		<td>#firstname# #lastname# #trim( activitytext )#</td>
																	</tr>
																</cfloop>												
															</tbody>
															<tfoot>
																<tr>
																	<td colspan="3"><span class="pull-right"><i class="fa fa-th-list"></i> Showing #useractivity.recordcount# record<cfif useractivity.recordcount gt 1>s</cfif>.</span></td>
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
								</div>
							</div>
						</div> 
					</div>
				</div>
			</cfoutput>