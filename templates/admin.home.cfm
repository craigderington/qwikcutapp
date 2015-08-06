

	
			<cfif not isuserinrole( "admin" )>
				<cflocation url="#application.root#user.home&accessdenied=1" addtoken="yes">
			</cfif>
			
			
			<cfinvoke component="apis.com.admin.admindashboardservice" method="getadmindashboard" returnvariable="admindashboard"></cfinvoke>
			<cfinvoke component="apis.com.activity.activityservice" method="getsystemactivity" returnvariable="systemactivity"></cfinvoke>
			
		
			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">				
					
					<!-- // include the page heading --->
					<cfinclude template="views/admin-page-heading.cfm">
						
						
						<div class="row">							
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<h5><i class="fa fa-dashboard"></i> Admin Dashboard</h5>
										<span class="pull-right">
											<cfoutput>
											<a href="#application.root#admin.reports" class="btn btn-xs btn-info btn-outline"><i class="fa fa-archive"></i> Reports</a>
											<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
											<a href="#application.root#admin.payroll" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-money"></i> Payroll</a>
											</cfoutput>
										</span>
									</div>
									
									<div class="ibox-content ibox-heading">
										<cfoutput>
											<div class="row">
												<div class="col-lg-3">
													<a href="#application.root#admin.states">
														<div class="widget style1 blue-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-building-o fa-3x"></i>
																</div>
																<div class="col-xs-9 text-right">
																	<h2 class="font-bold">#numberformat( admindashboard.statestotal, "999" )#</h2>
																	 <small>States</small>
																</div>
															</div>
														</div>
													</a>
												</div>
												<div class="col-lg-3">
													<a href="#application.root#admin.conferences">
														<div class="widget style1 navy-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-shield fa-3x"></i>
																</div>
																<div class="col-xs-9 text-right">
																	<h2 class="font-bold">#numberformat( admindashboard.conferencestotal, "999" )#</h2>
																	 <small>Conferences</small>
																</div>
															</div>
														</div>
													</a>
												</div>
												<div class="col-lg-3">
													<a href="#application.root#admin.teams">
														<div class="widget style1 navy-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-trophy fa-3x"></i>
																</div>
																<div class="col-xs-9 text-right">
																	<h2 class="font-bold">#numberformat( admindashboard.teamstotal, "999" )#</h2>
																	 <small>Teams</small>
																</div>
															</div>
														</div>
													</a>
												</div>
												<div class="col-lg-3">
													<a href="#application.root#admin.fields">
														<div class="widget style1 blue-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-stop fa-3x"></i>
																</div>
																<div class="col-xs-9 text-right">
																	<h2 class="font-bold">#numberformat( admindashboard.fieldstotal, "999" )#</h2>
																	 <small>Fields</small>
																</div>
															</div>
														</div>
													</a>
												</div>
												<div class="col-lg-3">
													<a  href="#application.root#admin.games">
														<div class="widget style1 blue-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-play fa-3x"></i>
																</div>
																<div class="col-xs-9 text-right">
																	<h2 class="font-bold">#numberformat( admindashboard.gamestotal, "999" )#</h2>
																	 <small>Games</small>
																</div>
															</div>
														</div>
													</a>
												</div>
												<div class="col-lg-3">
													<a href="#application.root#admin.shooters">
														<div class="widget style1 navy-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-video-camera fa-3x"></i>
																</div>
																<div class="col-xs-9 text-right">
																	<h2 class="font-bold">#numberformat( admindashboard.shooterstotal, "999" )#</h2>
																	 <small>Shooters</small>
																</div>
															</div>
														</div>
													</a>
												</div>
												<div class="col-lg-3">
													<a href="#application.root#admin.users">
														<div class="widget style1 blue-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-users fa-3x"></i>
																</div>
																<div class="col-xs-9 text-right">
																	<h2 class="font-bold">#numberformat( admindashboard.userstotal )#</h2>
																	 <small>Users</small>
																</div>
															</div>
														</div>
													</a>
												</div>												
											</div>
										</cfoutput>
									
									</div>
								</div>
							
						</div>	
							
						<div class="row">
							
								<div class="ibox border-bottom">
									<div class="ibox-title">
										<h5><i class="fa fa-database"></i> Recent System Activity</h5>
											<div class="ibox-tools">
														<a class="collapse-link">
															<i class="fa fa-chevron-up"></i>
														</a>
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															<i class="fa fa-wrench"></i>
														</a>															
														<a class="close-link">
															<i class="fa fa-times"></i>
														</a>															
											</div>
									</div>
																		
									<div class="ibox-content">
										
										<cfif systemactivity.recordcount gt 0>
										
												<!--- // pagination --->
												<cfparam name="url.startRow" default="1" >
												<cfparam name="url.rowsPerPage" default="10" >
												<cfparam name="currentPage" default="1" >
												<cfparam name="totalPages" default="0" >
										
											<div class="table-responsive">
												<table class="table table-striped table-bordered table-hover dataTables-example" >
													<thead>
														<tr>
															<th><i class="fa fa-table"></i></th>
															<th>Activity Type</th>
															<th>Activity Date</th>
															<th>Activity</th>																												
														</tr>
													</thead>
													<tbody>													
														<cfoutput query="systemactivity" startrow="#url.startrow#" maxrows="#url.rowsperpage#">
															<tr class="gradeX">
																<td><i class="fa fa-table"></i></td>
																<td>#dateformat( activitydate, "mm/dd/yyyy" )# at #timeformat( activitydate, "hh:mm tt" )#</td>
																<td>#trim( activitytype )#</td>
																<td>#firstname# #lastname# #trim( activitytext )#</td>
															</tr>
														</cfoutput>																																	
													</tbody>				
													
													
													<!--- // pagination conditionals --->
													<cfset totalRecords = systemactivity.recordcount />
													<cfset totalPages = totalRecords / rowsPerPage />
													<cfset endRow = (startRow + rowsPerPage) - 1 />													

														<!--- If the endrow is greater than the total, set the end row to to total --->
														<cfif endRow GT totalRecords>
															<cfset endRow = totalRecords />
														</cfif>

														<!--- Add an extra page if you have leftovers --->
														<cfif (totalRecords MOD rowsPerPage) GT 0 >
															<cfset totalPages = totalPages + 1 />
														</cfif>

														<!--- Display all of the pages --->
														<cfif totalPages gte 2>												
															<cfoutput>
																<tfoot>
																	<tr>
																		<td colspan="8" class="footable-visible">
																			<ul class="pagination pull-right">
																				<cfloop from="1" to="#totalPages#" index="i">
																					<cfset startRow = (( i - 1 ) * rowsPerPage ) + 1 />
																					<cfif currentPage neq i>
																						<li class="footable-page active"><a href="#application.root##url.event#&startRow=#startRow#&currentPage=#i#">#i#</a></li>
																					<cfelse>
																						<li class="footable-page"><a href="javascript:;">#i#</a></li>
																					</cfif>													
																				</cfloop>																																				
																			</ul>
																		</td>
																	</tr>
																</tfoot>
															</cfoutput>														
														</cfif>			
																	
												</table>				
											</div>
										
										<cfelse>
											
											<div class="alert alert-info alert-dismissable">
												<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
												<i class="fa fa-warning"></i> There are no system activity records to display in this view.
											</div>
										
										</cfif>
									</div>
									
								</div>
							
						</div>
								
							
							
							
						
						
						
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
		
