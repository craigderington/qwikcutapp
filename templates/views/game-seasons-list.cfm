



							
							
							<cfinvoke component="apis.com.admin.gameadminservice" method="getgameseasons" returnvariable="gameseasons">
							</cfinvoke>
							
							<h4><i class="fa fa-calendar"></i> Game Seasons</h4>
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr class="small">										
											<th>Year</th>
											<th>Active</th>
										</tr>
									</thead>
									<tbody>
										<cfoutput query="gameseasons">
											<tr class="small">												
												<td><span class="label<cfif gameseasons.gameseasonactive eq 1> label-primary</cfif>">#gameseasons.gameseason#</span></td>
												<td><cfif gameseasons.gameseasonactive eq 1><i class="fa fa-check-circle-o text-primary"><cfelse><i class="fa fa-minus-circle text-danger"></i></cfif></i></td>												
											</tr>
										</cfoutput>
									</tbody>
								</table>
							</div>
											
							