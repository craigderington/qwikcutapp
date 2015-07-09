




									
						
						<div class="row">
							
								<cfoutput>
									<div class="ibox">
										<div class="ibox-title">
											<h5><i class="fa fa-search"></i> Filter Your Results</h5>
										</div>
										<div class="ibox-content m-b-sm border-bottom">
											<div class="row">
												<div class="col-sm-2">
													<div class="form-group">
														<label class="control-label" for="state">State</label>
														<select name="state" id="state" class="form-control">
															<option value="" selected>Filter by State</option>
																<cfloop query="statelist">														
																	<option value="#stateid#">#statename#</option>
																</cfloop>
														</select>
													</div>
												</div>											
												<div class="col-sm-2">
													<div class="form-group">
														<label class="control-label" for="">Type</label>
														<select name="conferencetype" id="conferencetype" class="form-control">
															<option value="" selected>Filter by Type</option>
															<option value="HS">High School Football</option>
															<option value="YF">Youth Football</option>
														</select>
													</div>
												</div>											
												<div class="col-sm-4">
													<div class="form-group">
														<label class="control-label" for="product_name">Conference Name</label>
														<input type="text" id="conferencename" name="conferencename" value="" placeholder="Search by Conference Name" class="form-control">
													</div>
												</div>									
												<div class="col-sm-2">
													<div class="form-group">
														<label class="control-label" for="status">Status</label>
														<select name="status" id="status" class="form-control">
															<option value="" selected>Filter by Status</option>
															<option value="1">Active</option>
															<option value="0">Inactive</option>
														</select>
													</div>
												</div>
											</div>
										</div>
									</div>
								</cfoutput>
								
								<div class="ibox" style="margin-top:-15px;">								
									<cfoutput>
										<div class="ibox-title">
											<h5><i class="fa fa-database"></i> The database found #conferencelist.recordcount# conferences.</h5>										
											<a href="#application.root#admin.conferences&fuseaction=conference.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-plus"></i> Add Conference</a>
										</div>
									</cfoutput>						
									
									<div class="ibox-content">									
										<div class="table-responsive">
											<table class="table table-striped">
												<thead>
													<tr>
														<th>Actions</th>														
														<th>State</th>
														<th>Conference Type </th>
														<th>Conference</th>
														<th>Status</th>
													</tr>
												</thead>
												<tbody>
													<cfoutput query="conferencelist">
														<tr>
															<td><a class="btn btn-sm btn-primary" href="#application.root#admin.conferences&fuseaction=conference.edit&id=#confid#" title="Edit Conference"><i class="fa fa-edit"></i></a>
															    <a class="btn btn-sm btn-danger" href="#application.root#admin.conferences&fuseaction=conference.delete&id=#confid#" title="Delete Conference"><i class="fa fa-trash"></i></a>
															</td>															
															<td>#statename#</td>
															<td>#conftype#</td>	
															<td><strong>#confname#</strong></td>																																								
															<td><a href="##" title="Active"><i class="fa fa-check text-navy"></i></a></td>
														</tr>
													</cfoutput>																			 
												</tbody>
											</table>
										</div>

									</div>
								</div>
							
						</div>