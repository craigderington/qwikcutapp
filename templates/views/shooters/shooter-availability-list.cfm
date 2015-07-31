



				<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooterdates" returnvariable="shooterblockdates">
					<cfinvokeargument name="id" value="#numberformat( url.id, "99" )#">
				</cfinvoke>
		
					
				<cfoutput>	
					<div class="row">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-calendar"></i> Block Out Dates</h5>							
							</div>
							<div class="ibox-content">
								<cfif shooterblockdates.recordcount gt 0>								
									<div class="table-responsive">
										<table class="table table-striped" >
											<thead>
												<tr>												
													<th></th>
													<th>From Date</th>
													<th>To Date</th>													
												</tr>
											</thead>
											<tbody>
												<cfloop query="shooterblockdates">
													<tr class="small">
														<td><i class="fa fa-calendar"></i></td>
														<td>#dateformat( fromdate, "mm/dd/yyyy" )#</td>
														<td>#dateformat( todate, "mm/dd/yyyy" )#</td>														
													</tr>
												</cfloop>
											</tbody>
										</table>
									</div>
								<cfelse>
									<div class="alert alert-danger alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<p><i class="fa fa-warning"></i> <small>No block out dates found for this shooter...</small></p>								
									</div>
								</cfif>
							</div>
						</div>
					</div>
				</cfoutput>