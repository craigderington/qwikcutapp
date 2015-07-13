						
						
						<div class="row">
							
								<div class="ibox float-e-margins">
									
									
									
									
									<cfoutput>
										<div class="ibox-title">
											<h5><i class="fa fa-database"></i> The database found #statelist.recordcount# state records.</h5>										
											<a href="#application.root#admin.states&fuseaction=state.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-plus"></i> Add State</a>
										</div>
									</cfoutput>
									
									
									
									
									<div class="ibox-content">									
										<div class="table-responsive">
											<table class="table table-striped">
												<thead>
													<tr>
														<cfif isuserinrole( "admin" )>
															<th>Actions</th>
														</cfif>
														<th>State ID</th>
														<th>State Name </th>
														<th>State Abbreviation </th>
														<th>Status</th>													
													</tr>
												</thead>
												<tbody>
													<cfoutput query="statelist">
														<tr>
															<cfif isuserinrole( "admin" )>
																<td>
																	<a class="btn btn-sm btn-primary" href="#application.root#admin.states&fuseaction=state.edit&stateid=#stateid#" title="Edit State"><i class="fa fa-edit"></i></a>
																	<a class="btn btn-sm btn-danger" href="#application.root#admin.states&fuseaction=state.delete&stateid=#stateid#" title="Delete State"><i class="fa fa-trash"></i></a>
																</td>
															</cfif>
															<td>#stateid#</td>
															<td><strong>#statename#</strong></td>
															<td>#stateabbr#</td>																										
															<td><a href="##" title="Active"><i class="fa fa-check text-navy"></i></a></td>
														</tr>
													</cfoutput>																			 
												</tbody>
											</table>
										</div>

									</div>
								</div>
							
						</div>