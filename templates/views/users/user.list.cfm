


						<div class="row">
						
							<cfoutput>
									<div class="ibox">
										<div class="ibox-title">
											<h5><i class="fa fa-search"></i> Filter Your Results</h5>
										</div>
										<div class="ibox-content m-b-sm border-bottom">
											<form name="data-filter" method="post" action="#application.root##url.event#">
												<div class="row">
													<div class="col-sm-2">
														<div class="form-group">
															<label class="control-label" for="state">Type</label>
															<select name="usertype" id="usertype" class="form-control" onchange="javascript:this.form.submit();">
																<option value="" selected>Filter by Type</option>
																<cfif isuserinrole( "admin" )>
																<option value="admin"<cfif structkeyexists( form, "usertype" )><cfif trim( form.usertype ) eq "admin">selected</cfif></cfif>>Admin</option>
																</cfif>
																<option value="shooter"<cfif structkeyexists( form, "usertype" )><cfif trim( form.usertype ) eq "shooter">selected</cfif></cfif>>Shooter</option>
																<option value="data"<cfif structkeyexists( form, "usertype" )><cfif trim( form.usertype ) eq "data">selected</cfif></cfif>>Data & Analytics</option>
																<option value="future-use" disabled>Future Use</option>																
															</select>
														</div>
													</div>
													<!---
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
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label" for="product_name">Zip Code</label>
															<input type="text" id="fieldzipcode" name="fieldzipcode" placeholder="Search by Zip Code" class="form-control" <cfif structkeyexists( form, "fieldzipcode" )>value="#trim( form.fieldzipcode )#"</cfif> onchange="javascript:this.form.submit();" />
														</div>
													</div>
													--->
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
						
						
						
						
						
						
							
								<div class="ibox float-e-margins">
									
									
									<cfoutput>
										<div class="ibox-title">
											<h5><i class="fa fa-database"></i> The database found #userlist.recordcount# user records.   <cfif not structkeyexists( form, "filterresults" )><span style="margin-left:15px;" class="help-text"><small><i class="fa fa-exclamation-triangle"></i> Only admin users are displayed in the default view.  To manage other user types, select the filter <i>type</i>.</small></span></cfif></h5>										
											<a href="#application.root#admin.users&fuseaction=user.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-user-plus"></i> Add User</a>
										</div>
									</cfoutput>
									
									
									
									
									<div class="ibox-content">									
										
										<cfif userlist.recordcount gt 0>
										
											<div class="table-responsive">
												<table class="table table-striped">
													<thead>
														<tr>
															<cfif isuserinrole( "admin" )>
																<th>Actions</th>
															</cfif>
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
																<cfif isuserinrole( "admin" )>
																	<td>
																		<a class="btn btn-sm btn-primary" href="#application.root#admin.users&fuseaction=user.edit&id=#userid#" title="Edit User"><i class="fa fa-edit"></i></a>
																		<a class="btn btn-sm btn-danger" href="#application.root#admin.users&fuseaction=user.delete&id=#userid#" title="Delete User"><i class="fa fa-trash"></i></a>
																	</td>
																</cfif>
																<td><strong>#username#</strong></td>
																<td>#firstname#</td>
																<td>#lastname#</td>																										
																<td>#email#</td>
																<td>#userrole#</th>
																<td><i class="fa fa-check text-primary"></i> <small>#dateformat( lastlogindate, "mm/dd/yyyy" )#</small></td>
															</tr>
														</cfoutput>																			 
													</tbody>
												</table>
											</div>
										
										<cfelse>
										
											<div class="alert alert-danger alert-dismissable">
												<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
												<p><i class="fa fa-check-circle-o"></i> No Records Found</p>								
											</div>										
											
										</cfif>
									</div>
								</div>
							
						</div>