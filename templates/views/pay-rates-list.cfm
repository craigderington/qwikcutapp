



							
							
							<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooterpayrates" returnvariable="payrateslist">
							</cfinvoke>
							
							<h4><i class="fa fa-video-camera"></i> Shooter Pay Rates</h4>
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr class="small">											
											<th>Type</th>
											<th>Rate</th>
											<th>Games</th>
										</tr>
									</thead>
									<tbody>
										<cfoutput query="payrateslist">
											<tr class="small">
												<td>#paytype#</td>
												<td>#dollarformat( payrate )#</td>
												<td>#payratenumgames#</td>												
											</tr>
										</cfoutput>
									</tbody>
								</table>
							</div>
											
							