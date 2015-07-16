



									
						
						<div class="row">
							
								<cfoutput>
									<div class="ibox">
										<div class="ibox-title">
											<h5><i class="fa fa-search"></i> Filter Your Results</h5>
										</div>
										<div class="ibox-content m-b-sm border-bottom">
											<form name="data-filter" method="post" action="">
												<div class="row">
													<div class="col-sm-2">
														<div class="form-group">
															<label class="control-label" for="state">State</label>
															<select name="state" id="state" class="form-control" onchange="javascript:this.form.submit();">
																<option value="" selected>Filter by State</option>
																	<cfloop query="statelist">														
																		<option value="#stateid#"<cfif structkeyexists( form, "state" ) and trim( form.state ) neq ""><cfif statelist.stateid eq form.state>selected</cfif></cfif>>#statename#</option>
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
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label" for="product_name">Field Name</label>
															<input type="text" id="fieldname" name="fieldname" value="" placeholder="Search by Field Name" class="form-control">
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label" for="product_name">Zip Code</label>
															<input type="text" id="zipcode" name="zipcode" value="" placeholder="Search by Zip Code" class="form-control">
														</div>
													</div>
													<input name="filterresults" type="hidden" value="true" />													
													<!---<button type="submit" name="filterresults" class="btn btn-sm btn-primary"><i class="fa fa-search"></i> Filter Results</button>--->
													<cfif structkeyexists( form, "filterresults" )>
														<a style="margin-left:3px;margin-top:24px;" href="#application.root##url.event#" class="btn btn-md btn-success"><i class="fa fa-remove"></i> Reset Filters</a>
													</cfif>
												</div>
											</form>
										</div>
									</div>
								</cfoutput>
								
								<div class="ibox" style="margin-top:-15px;">								
									<cfoutput>
										<div class="ibox-title">
											<h5><i class="fa fa-database"></i> The database found #fieldlist.recordcount# game field<cfif ( fieldlist.recordcount eq 0 ) or ( fieldlist.recordcount gt 1 )>s</cfif>.</h5>										
											<cfif isuserinrole( "admin" )>
												<a href="#application.root##url.event#&fuseaction=field.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-plus"></i> Add Field</a>
											</cfif>
										</div>
									</cfoutput>						
									
									<div class="ibox-content">									
										<div class="table-responsive">
											
											<cfif fieldlist.recordcount gt 0>											
											
												<table class="table table-striped">
													<thead>
														<tr>
															<cfif isuserinrole( "admin" )>
																<th>Actions</th>
															</cfif>
															<th>State</th>														
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
																<td><strong><a href="#application.root#admin.fields&fuseaction=field.view&id=#fieldid#">#fieldname#</a></strong></td>
																<td><small>#fieldaddress1# <a href="" style="margin-left:5px;"><i class="fa fa-map-marker"></i></a><cfif fieldaddress2 neq ""><br />#fieldaddress2#</cfif><br />#fieldcity#, #fieldstate# #fieldzip#</small></td>
																<td><small>#fieldcontactname#<br />#fieldcontacttitle#<br />#fieldcontactnumber#</small></td>
																<td><a href="##" title="Active"><i class="fa fa-check text-navy"></i></a></td>
															</tr>
														</cfoutput>																			 
													</tbody>
												</table>
											
											<cfelse>
											
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<h5><i class="fa fa-warning"></i> NO RECORDS FOUND</h5>
														<p>The applied filter resulted in zero matching records.  Please reset the filter to continue...
												</div>
											
											</cfif>
										</div>

									</div>
								</div>
							
						</div>