
			<!--- // get the user activity --->
			<cfinvoke component="apis.com.activity.activityservice" method="getuseractivity" returnvariable="useractivity">
				<cfinvokeargument name="id" value="#session.userid#">
			</cfinvoke>
		
	
			
			
			
			
			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">
					
					<cfoutput>
					
					
					<!--- // show message if user attempts to circumvent security settings --->
					<cfif structkeyexists( url, "accessdenied" )>
						<div class="row">
							<div class="alert alert-danger alert-dismissable">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
								<h3><i class="fa fa-lock fa-2x"></i>  You have attempted to access a restricted resource.  Access Denied.</h3>								
							</div>
						</div>
					</cfif>
					
					
					<div class="row" style="margin-top:20px;">
						<div class="ibox">							
							<div class="jumbotron">
								<h1>QC+</h1>
								<p>Game Video & Analytics</p>
								<p><a role="button" class="btn btn-primary btn-lg">Learn more</a></p>
							</div>							
						</div>
					</div>
						
						
						<div class="row">
							
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<h5><i class="fa fa-dashboard"></i> Your Dashboard</h5>
									</div>
									
									<div class="ibox-content">
										
										Your Dashboard Items
									
									</div>
								</div>
							
						</div>	
							
						<div class="row">						
							<div class="ibox">
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
								
							
							
							
						
						
				</cfoutput>		
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
		
