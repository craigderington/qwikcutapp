





					<cfinvoke component="apis.com.admin.teamadminservice" method="getteamlevels" returnvariable="teamlevels">						
					</cfinvoke>
					
					
					<cfoutput>
						<div class="row">
							<div class="ibox">
								<div class="ibox-title">
									<h5><i class="fa fa-cog"></i> Manage System Team Levels</h5>
									<span class="pull-right">
										<a href="#application.root#admin.home" class="btn btn-xs btn-outline btn-primary"><i class="fa fa-cog"></i> Admin Home</a>									
										<a style="margin-left:5px;" href="#application.root##url.event#" class="btn btn-xs btn-outline btn-default"><i class="fa fa-arrow-circle-left"></i> Teams List</a>
									</span>
									<!---
									<div class="ibox-tools">
										<a class="collapse-link">
											<i class="fa fa-chevron-up"></i>
										</a>
										<a class="dropdown-toggle" data-toggle="dropdown" href="">
											<i class="fa fa-wrench"></i>
										</a>									
									</div>
									--->									
								</div>
								<div class="ibox-content">
									<div class="panel-body">
										<div class="col-md-12">
											<div class="col-md-7">
												<cfinclude template="team-levels-list.cfm">
											</div>
											<div class="col-md-5">
												<cfinclude template="team-levels-form.cfm">
											</div>
										</div>
									</div>
								</div>
							</div>				
						</div>
					</cfoutput>