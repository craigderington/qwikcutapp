



									
						
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
														<label class="control-label" for="">Conference</label>
														<select name="conference" id="conference" class="form-control">
															<option value="" selected>Filter by Conference</option>
															<option value="">List of Conferences</option>
														</select>
													</div>
												</div>									
												<div class="col-sm-4">
													<div class="form-group">
														<label class="control-label" for="product_name">Field Name</label>
														<input type="text" id="fieldname" name="fieldname" value="" placeholder="Search by Field Name" class="form-control">
													</div>
												</div>
											</div>
										</div>
									</div>
								</cfoutput>
								
								<div class="ibox" style="margin-top:-15px;">								
									<cfoutput>
										<div class="ibox-title">
											<h5><i class="fa fa-database"></i> The database found #fieldlist.recordcount# game field<cfif fieldlist.recordcount gt 1>s</cfif>.</h5>										
											<a href="#application.root#admin.conferences&fuseaction=conference.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-plus"></i> Add Field</a>
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
														<th>State</th>														
														<th>Conference</th>
														<th>Field Name</th>
														<th>Address</th>
														<th>Field Contact</th>
														<th>Status</th>
													</tr>
												</thead>
												<tbody>
													<cfoutput query="fieldlist">
														<tr>
															<cfif isuserinrole( "admin" )>
																<td>
																	<a class="btn btn-sm btn-primary" href="#application.root#admin.fields&fuseaction=field.edit&id=#fieldid#" title="Edit Field Details"><i class="fa fa-edit"></i></a>
																	<a class="btn btn-sm btn-danger" href="#application.root#admin.fields&fuseaction=field.delete&id=#fieldid#" title="Delete Field Details"><i class="fa fa-trash"></i></a>
																</td>
															</cfif>
															<td>#statename#</td>
															<td>#confname#</td>
															<td><strong><a href="#application.root#admin.fields&fuseaction=field.view&id=#fieldid#">#fieldname#</a></strong></td>
															<td><small>#fieldaddress1# <a href="" style="margin-left:5px;"><i class="fa fa-map-marker"></i></a><cfif fieldaddress2 neq ""><br />#fieldaddress2#</cfif><br />#fieldcity#, #fieldstate# #fieldzip#</small></td>
															<td><small>#fieldcontactname#<br />#fieldcontacttitle#<br />#fieldcontactnumber#</small></td>
															<td><a href="##" title="Active"><i class="fa fa-check text-navy"></i></a></td>
														</tr>
													</cfoutput>																			 
												</tbody>
											</table>
										</div>

									</div>
								</div>
							
						</div>