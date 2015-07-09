




						<cfoutput>
							<div class="row">							
								<div class="ibox">
									<div class="ibox-title">
										<h5><i class="fa fa-search"></i> Filter Your Results</h5>
									</div>
									<div class="ibox-content m-b-sm border-bottom">
										<div class="row">																					
											<div class="col-sm-4">
												<div class="form-group">
													<label class="control-label" for="product_name">Shooter Name</label>
													<input type="text" id="name" name="name" value="" placeholder="Search by Shooter Name" class="form-control">
												</div>
											</div>
											<div class="col-sm-2">
												<div class="form-group">
													<label class="control-label" for="status">Fields Assigned</label>
													<select name="status" id="status" class="form-control">
														<option value="" selected>Filter by Fields</option>
														<option value="1">Field 1</option>
														<option value="0">Field 2</option>
													</select>
												</div>
											</div>
											<div class="col-sm-2">
												<div class="form-group">
													<label class="control-label" for="status">Shooter Status</label>
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
							</div>
							<div class="row">
								<div class="ibox" style="margin-top:-15px;">								
									<div class="ibox-title">
										<h5><i class="fa fa-database"></i> The database found XX records.</h5>										
											<a href="#application.root#admin.shooters&fuseaction=shooter.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-user-plus"></i> Add Shooter</a>
									</div>
															
									<div class="ibox-content">									
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<th>Col One</th>
														<th>Col Two</th>
														<th>Col Three</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Data 1</td>
														<td>Data 2</td>
														<td>Data 3</td>
													</tr>
												</tbody>
											</table>
										</div>

									</div>
								</div>							
							</div>
						</cfoutput>