





				<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooterregions" returnvariable="shooterregionslist">
					<cfinvokeargument name="id" value="#numberformat( url.id, "99" )#">
				</cfinvoke>
				
				
				<cfoutput>
					<div class="row">
						<div class="ibox">
							<div class="ibox-title">
								<h5>Regions - Shooter Works These Areas</h5>							
							</div>
							<div class="ibox-content">
							
								<!--- // system messages --->
								<cfif structkeyexists( url, "scope" )>
									<cfif url.scope eq 1>
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<p><i class="fa fa-check-circle-o"></i> Region Assignment Added</p>								
										</div>
									<cfelseif url.scope eq 2>						
										<div class="alert alert-info alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<p><i class="fa fa-check"></i> Region Assignment Deleted</p>							
										</div>									
									</cfif>					
								</cfif>
							
							
								<cfif shooterregionslist.recordcount gt 0>
									<div class="table-responsive">
										<table class="table table-striped table-bordered table-hover" >
											<thead>
												<tr>
													<th><i class="fa fa-trash"></i></th>
													<th>Region Name</th>													
													<th>Status</th>
												</tr>
											</thead>
											<tbody>
												<cfloop query="shooterregionslist">
													<tr class="gradeX">
														<td><a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&srid=#shooterregionid#"><i class="fa fa-trash"></i></a></td>
														<td>#region_name#</td>														
														<td><i class="fa fa-check text-primary"></td>
													</tr>
												</cfloop>
											</tbody>
										</table>
									</div>
								<cfelse>
									<div class="alert alert-danger alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<p><i class="fa fa-warning"></i> No assigned regions found for this shooter...</p>								
									</div>
								</cfif>
							</div>
						</div>				
					</div>
				</cfoutput>


