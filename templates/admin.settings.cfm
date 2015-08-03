



				<cfinvoke component="apis.com.admin.fieldadminservice" method="getfieldoptions" returnvariable="fieldoptions">
				</cfinvoke>




				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">				
					
					<!--- // include the page heading --->
					<cfinclude template="views/admin-settings-page-heading.cfm">						
						
						<div class="row">							
							<div class="ibox float-e-margins">
								<div class="ibox-title">
									<cfoutput>
										<h5><i class="fa fa-dashboard"></i> #session.username# | Admin Settings</h5>
										<span class="pull-right">											
											<a href="#application.root#admin.reports" class="btn btn-xs btn-info btn-outline"><i class="fa fa-archive"></i> Reports</a>
											<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
											<a href="#application.root#admin.home" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-home"></i> Admin Home</a>
										</span>
									</cfoutput>	
								</div>
								
								<div class="ibox-content ibox-heading">
									<h4 class="text-center"><i><strong>Administrative Settings</strong></i></h4>
								</div>
								
								<div class="ibox-content">
									<div class="row">
										<div class="col-md-4">
											<h4><i class="fa fa-table"></i> Field Options</h4>
											<div class="table-responsive">
												<table class="table table-hover">
													<thead>
														<tr class="small">
															<th>ID</th>
															<th>Description</th>
														</tr>
													</thead>
													<tbody>
														<cfoutput query="fieldoptions">
															<tr class="small">
																<td>#fieldoptionid#</td>
																<td>#fieldoptiondescr#</td>															
															</tr>
														</cfoutput>
													</tbody>
												</table>
											</div>
											
											<cfinclude template="views/field-options-form.cfm">
											
											
										</div>
										
										<div class="col-md-4">
											<h4><i class="fa fa-th-large"></i> Future Setting 2</h4>											
										</div>
										
										<div class="col-md-4">
											<h4><i class="fa fa-th-list"></i> Future Setting 3</h4>											
										</div>
										
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>