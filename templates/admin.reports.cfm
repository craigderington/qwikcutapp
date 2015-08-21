





			<cfinvoke component="apis.com.reports.reportservice" method="getreportfolders" returnvariable="reportfolders">



			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">				
					
					<!-- // include the page heading --->
					<cfinclude template="views/admin-reports-page-heading.cfm">						
					<cfoutput>	
						<div class="row">							
							<div class="ibox float-e-margins">
								<div class="ibox-title">
									<h5><i class="fa fa-archive"></i> Admin Reports Menu</h5>
									<span class="pull-right">										
										<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
										<a href="#application.root#admin.home" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-home"></i> Admin Home</a>
									</span>
								</div>
								
								<div class="ibox-content ibox-heading">
									<h5>Quick Access:</h5>
									<a href="#application.root##url.event#&reports=all" class="btn btn-xs btn-warning">All Reports</a>
									<a href="#application.root##url.event#&reports=system" class="btn btn-xs btn-danger">System</a>
									<a href="#application.root##url.event#&reports=film" class="btn btn-xs btn-info">Film Analytics</a>
									<a href="#application.root##url.event#&reports=user" class="btn btn-xs btn-default">Users</a>
								</div>
									
								<div class="ibox-content" <cfif structkeyexists( url, "reports" )><cfif trim( url.reports ) eq "all">style="min-height:1250px;"</cfif><cfelse>style="min-height:500px;"</cfif>>							
									<div class="col-lg-3">
										<div class="file-manager">								
											<h5>Report Folders</h5>
												<ul class="folder-list" style="padding: 0">
													<!--- // systemize report folder menu
													<li><a href="#application.root##url.event#&reports=teams"><i class="fa fa-folder"></i> Teams</a></li>
													<li><a href="#application.root##url.event#&reports=fields"><i class="fa fa-folder"></i> Fields</a></li>
													<li><a href="#application.root##url.event#&reports=games"><i class="fa fa-folder"></i> Games</a></li>
													<li><a href="#application.root##url.event#&reports=shooters"><i class="fa fa-folder"></i> Shooters</a></li>
													<li><a href="#application.root##url.event#&reports=film"><i class="fa fa-folder"></i> Game Films</a></li>
													<li><a href="#application.root##url.event#&reports=payroll"><i class="fa fa-folder"></i> Payroll</a></li>--->
													<cfloop query="reportfolders">
														<li><a href="#application.root##url.event#&reports=#slug#"><i class="fa fa-folder"></i> #reportfolder#</a></li>
													</cfloop>
												</ul>												
												
												<a href="" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-folder"></i> Add Folder</a>
												
											<div class="clearfix"></div>
										</div>													
									</div>               
									

									<cfparam name="thisreport" default="all">
									
									<div class="col-lg-9 animated fadeInRight">
										<div class="row">
											<cfif structkeyexists( url, "reports" )>
												
												<cfif structkeyexists( url, "reportid" )>
													
													<cfinclude template="views/reports/reports.template.cfm">
												
												<cfelse>
												
													<cfset thisreport = trim( url.reports ) />
														<cfif trim( thisreport ) eq "all">
															<cfinclude template="views/reports/reports.all.cfm">
														<cfelse>
															<cfinclude template="views/reports/reports.menu.cfm">
														</cfif>
												</cfif>
												
											<cfelse>
											
												<cfinclude template="views/reports/reports.index.cfm">
											
											</cfif>
										</div>
									</div>																
								</div>
							</div>
						</div>
					</cfoutput>
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
							