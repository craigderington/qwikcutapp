


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
																<option value="confadmin"<cfif structkeyexists( form, "usertype" )><cfif trim( form.usertype ) eq "confadmin">selected</cfif></cfif>>Conference Admin</option>
																</cfif>
																<option value="shooter"<cfif structkeyexists( form, "usertype" )><cfif trim( form.usertype ) eq "shooter">selected</cfif></cfif>>Shooter</option>
																<option value="data"<cfif structkeyexists( form, "usertype" )><cfif trim( form.usertype ) eq "data">selected</cfif></cfif>>Data & Analytics</option>
																<option value="future-use" disabled>Future Use</option>																
															</select>
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
															<th></th>
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
															<cfset cleanuserrole = trim( userlist.userrole )  />
																
																<!--- // print out the role, make it look nicer --->
																<cfswitch expression="#cleanuserrole#">
																	<cfcase value="admin">
																		<cfset cleanuserrole = "Admin" />
																	</cfcase>
																	<cfcase value="confadmin">
																		<cfset cleanuserrole = "Conference Admin">
																	</cfcase>
																	<cfcase value="data">
																		<cfset cleanuserrole = "Data &amp; Analytics">
																	</cfcase>
																	<cfcase value="shooter">
																		<cfset cleanuserrole = "Shooter">
																	</cfcase>
																	<cfdefaultcase>
																		<cfset cleanuserrole = "Not Set">
																	</cfdefaultcase>															
																</cfswitch>
														
															<tr>
																<cfif isuserinrole( "admin" )>
																	<td>
																		<a class="btn btn-sm btn-primary" href="#application.root#admin.users&fuseaction=user.edit&id=#userid#" title="Edit User"><i class="fa fa-edit"></i></a>
																		<a class="btn btn-sm btn-danger" href="#application.root#admin.users&fuseaction=user.delete&id=#userid#" title="Delete User"><i class="fa fa-trash"></i></a>
																	</td>
																</cfif>
																<td class="client-avatar"><cfif trim( userprofileimagepath ) neq ""><img src="#userprofileimagepath#" alt="profile image"><cfelse><i class="fa fa-user fa-2x"></i></cfif></td>
																<td><strong>#username#</strong></td>
																<td>#firstname#</td>
																<td>#lastname#</td>																										
																<td>#email#</td>
																<td><cfif trim( userrole ) eq "confadmin">
																		<cfif userlist.confid eq 0>
																			<span class="label label-danger">Conference Not Set</span>
																		<cfelse>
																			<cfinvoke component="apis.com.admin.conferenceadminservice" method="getadminconferencename" returnvariable="conference">
																				<cfinvokeargument name="id" value="#userlist.confid#">
																			</cfinvoke>
																			<span class="label">#conference.confname# Admin</span>
																		</cfif>
																	<cfelseif trim( userrole ) eq "admin">
																		<span class="label label-info">#cleanuserrole#</span>
																	<cfelseif trim( userrole ) eq "data">
																		<span class="label label-warning">#cleanuserrole#</span>
																	<cfelseif trim( userrole ) eq "shooter">
																		<span class="label label-success">#cleanuserrole#</span>
																	<cfelse>
																		<span class="label label-danger">Unknown</span>
																	</cfif></th>
																<td>
																<cfif useractive eq 1>
																    <i class="fa fa-check text-primary"></i>
																<cfelse>
																	<span class="label label-danger">Inactive</span>
																</cfif><small>#dateformat( lastlogindate, "mm/dd/yyyy" )#</small></td>
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