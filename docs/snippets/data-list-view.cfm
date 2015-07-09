




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
													<input type="text" id="conferencename" name="conferencename" value="" placeholder="Search by Conference Name" class="form-control">
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
										<h5><i class="fa fa-database"></i> The database found.</h5>										
											<a href="#application.root#admin.shooters&fuseaction=shooter.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-user-plus"></i> Add Shooter</a>
									</div>
															
									<div class="ibox-content">									
										<div class="table-responsive">
											<table class="table table-striped">
												<thead>
													<tr>
															
													</tr>
												</thead>
												<tbody>
																																 
												</tbody>
											</table>
										</div>

									</div>
								</div>							
							</div>
						</cfoutput>