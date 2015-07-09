

	
			
			
			
			<cfinvoke component="apis.com.admin.admindashboardservice" method="getadmindashboard" returnvariable="admindashboard"></cfinvoke>
		
		
		
			<div class="wrapper wrapper-content">
				<div class="container">				
					<!-- // include the page heading --->
					<cfinclude template="views/admin-page-heading.cfm">
						
						
						<div class="row">
							
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<h5><i class="fa fa-dashboard"></i> Admin Dashboard</h5>
									</div>
									
									<div class="ibox-content">
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
														<div class="widget style1 red-bg">
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
														<div class="widget style1 red-bg">
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
														<div class="widget style1 yellow-bg">
															<div class="row vertical-align">
																<div class="col-xs-3">
																	<i class="fa fa-camera fa-3x"></i>
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
							
								<div class="ibox">
									<div class="ibox-title">
										<h5><i class="fa fa-database"></i> Recent System Activity</h5>
											<div class="ibox-tools">
														<a class="collapse-link">
															<i class="fa fa-chevron-up"></i>
														</a>
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															<i class="fa fa-wrench"></i>
														</a>
															<!--
															<ul class="dropdown-menu dropdown-user">
																<li><a href="#">Config option 1</a>
																</li>
																<li><a href="#">Config option 2</a>
																</li>
															</ul>
															<a class="close-link">
																<i class="fa fa-times"></i>
															</a>
															-->
											</div>
									</div>
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover dataTables-example" >
																<thead>
																	<tr>
																		<th>Rendering engine</th>
																		<th>Browser</th>
																		<th>Platform(s)</th>
																		<th>Engine version</th>
																		<th>CSS grade</th>
																	</tr>
																</thead>
																<tbody>
																	<tr class="gradeX">
																		<td>Trident</td>
																		<td>Internet
																			Explorer 4.0
																		</td>
																		<td>Win 95+</td>
																		<td class="center">4</td>
																		<td class="center">X</td>
																	</tr>
																	<tr class="gradeC">
																		<td>Trident</td>
																		<td>Internet
																			Explorer 5.0
																		</td>
																		<td>Win 95+</td>
																		<td class="center">5</td>
																		<td class="center">C</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Trident</td>
																		<td>Internet
																			Explorer 5.5
																		</td>
																		<td>Win 95+</td>
																		<td class="center">5.5</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Trident</td>
																		<td>Internet
																			Explorer 6
																		</td>
																		<td>Win 98+</td>
																		<td class="center">6</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Trident</td>
																		<td>Internet Explorer 7</td>
																		<td>Win XP SP2+</td>
																		<td class="center">7</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Trident</td>
																		<td>AOL browser (AOL desktop)</td>
																		<td>Win XP</td>
																		<td class="center">6</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Gecko</td>
																		<td>Firefox 1.0</td>
																		<td>Win 98+ / OSX.2+</td>
																		<td class="center">1.7</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Gecko</td>
																		<td>Firefox 1.5</td>
																		<td>Win 98+ / OSX.2+</td>
																		<td class="center">1.8</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Gecko</td>
																		<td>Firefox 2.0</td>
																		<td>Win 98+ / OSX.2+</td>
																		<td class="center">1.8</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Gecko</td>
																		<td>Firefox 3.0</td>
																		<td>Win 2k+ / OSX.3+</td>
																		<td class="center">1.9</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Gecko</td>
																		<td>Camino 1.0</td>
																		<td>OSX.2+</td>
																		<td class="center">1.8</td>
																		<td class="center">A</td>
																	</tr>
																	<tr class="gradeA">
																		<td>Gecko</td>
																		<td>Camino 1.5</td>
																		<td>OSX.3+</td>
																		<td class="center">1.8</td>
																		<td class="center">A</td>
																	</tr>
																	
																																
																</tbody>
																
															</table>				
										</div>
									</div>
								</div>
							
						</div>
								
							
							
							
						
						
						
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
		
