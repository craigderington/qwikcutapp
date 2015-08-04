



				




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
											<cfinclude template="views/game-seasons-list.cfm">
										</div>
										
										<div class="col-md-4">
											<cfinclude template="views/field-options-list.cfm">										
										</div>
										
										<div class="col-md-4">
											<cfinclude template="views/pay-rates-list.cfm">										
										</div>							
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>