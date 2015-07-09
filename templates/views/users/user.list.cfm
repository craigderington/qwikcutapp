


						<div class="row">
							
								<div class="ibox float-e-margins">
									
									
									<cfoutput>
										<div class="ibox-title">
											<h5><i class="fa fa-database"></i> The database found #userlist.recordcount# user records.</h5>										
											<a href="#application.root#admin.users&fuseaction=user.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-user-plus"></i> Add User</a>
										</div>
									</cfoutput>
									
									
									
									
									<div class="ibox-content">									
										<div class="table-responsive">
											<table class="table table-striped">
												<thead>
													<tr>
														<th>Actions</th>														
														<th>Username </th>
														<th>First Name </th>
														<th>Last Name</th>
														<th>Email</th>
														<th>Role</th>
														<th>Status</th>
													</tr>
												</thead>
												<tbody>
													<cfoutput query="userlist">
														<tr>
															<td><a class="btn btn-sm btn-primary" href="#application.root#admin.users&fuseaction=user.edit&id=#userid#" title="Edit User"><i class="fa fa-edit"></i></a>
															    <a class="btn btn-sm btn-danger" href="#application.root#admin.users&fuseaction=user.delete&id=#userid#" title="Delete User"><i class="fa fa-trash"></i></a>
															</td>
															<td><strong>#username#</strong></td>
															<td>#firstname#</td>
															<td>#lastname#</td>																										
															<td>#email#</td>
															<td>#userrole#</th>
															<td><i class="fa fa-check text-navy"></i> <small>#dateformat( lastlogindate, "mm/dd/yyyy" )#</small></td>
														</tr>
													</cfoutput>																			 
												</tbody>
											</table>
										</div>

									</div>
								</div>
							
						</div>