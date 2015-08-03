





			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">				
					
					<!-- // include the page heading --->
					<cfinclude template="views/admin-reports-page-heading.cfm">						
						
						<div class="row">							
							<div class="ibox float-e-margins">
								<div class="ibox-title">
									<h5><i class="fa fa-archive"></i> Admin Reports Menu</h5>
									<span class="pull-right">
										<cfoutput>
											<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
											<a href="#application.root#admin.home" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-home"></i> Admin Home</a>
										</cfoutput>
									</span>
								</div>
								
								<div class="ibox-content ibox-heading">
									<h5>Quick Access:</h5>
									<a href="#" class="btn btn-xs btn-warning">All Reports</a>
									<a href="#" class="btn btn-xs btn-danger">System</a>
									<a href="#" class="btn btn-xs btn-info">Film Analytics</a>
									<a href="#" class="btn btn-xs btn-default">Users</a>
								</div>
									
								<div class="ibox-content" style="min-height:500px;">							
									<div class="col-lg-3">
										<div class="file-manager">								
											<h5>Report Folders</h5>
												<ul class="folder-list" style="padding: 0">
													<li><a href=""><i class="fa fa-folder"></i> Teams</a></li>
													<li><a href=""><i class="fa fa-folder"></i> Fields</a></li>
													<li><a href=""><i class="fa fa-folder"></i> Games</a></li>
													<li><a href=""><i class="fa fa-folder"></i> Shooters</a></li>
													<li><a href=""><i class="fa fa-folder"></i> Game Films</a></li>
													<li><a href=""><i class="fa fa-folder"></i> Payroll</a></li>													
												</ul>												
												
												<a href="" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-folder"></i> Add Folder</a>
												
											<div class="clearfix"></div>
										</div>													
									</div>               
													
									<div class="col-lg-9 animated fadeInRight">
										<div class="row">
											<div class="col-lg-12">
												<div class="file-box">
													<div class="file">
														<a href="">
															<span class="corner"></span>
															<div class="icon">
																<i class="fa fa-table"></i>
															</div>
															<div class="file-name">
																Report_2C_2015
																<br>
																<small>Added: June 11, 2015</small>
															</div>
														</a>
													</div>
												</div>                   
																
												<div class="file-box">
													<div class="file">
														<a href="#">
															<span class="corner"></span>
																<div class="icon">
																	<i class="fa fa-table"></i>
																</div>
																<div class="file-name">
																	Report_1B_2015
																	<br>
																	<small>Added: July 30, 2015</small>
																</div>
														</a>
													</div>
												</div>
																
												<div class="file-box">
													<div class="file">
														<a href="#">
															<span class="corner"></span>
																<div class="icon">
																	<i class="fa fa-file"></i>
																</div>
																<div class="file-name">
																	Report_1A_2015
																	<br>
																	<small>Added: July 23, 2015</small>
																</div>
														</a>
													</div>
												</div>
											</div>
										</div>
									</div>																
								</div>
							</div>
						</div>
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
							