



									
						
							<div class="ibox">
				
								<div class="ibox-title">
									<h5><i class="fa fa-search"></i> Filter Your Results</h5>
								</div>

									<div class="ibox-content m-b-sm border-bottom">
										<div class="row">
										<cfoutput>
											<form name="data-filter" method="post" action="#application.root##url.event#">
												<fieldset>
													<div class="col-sm-4">
														<div class="form-group">
															<label class="control-label" for="status">Conference</label>
															<select name="conferenceid" id="conferenceid" class="form-control" onchange="javascript:this.form.submit();">
																<option value="" selected>Filter by Conference</option>
																<cfloop query="conferencelist">
																	<option value="#confid#"<cfif structkeyexists( form, "conferenceid" )><cfif form.conferenceid eq conferencelist.confid>selected</cfif></cfif>>#confname#</option>
																</cfloop>
															</select>
														</div>
													</div>
													<div class="col-sm-4">
														<div class="form-group">
															<label class="control-label" for="product_name">Team Name</label>
															<input type="text" id="teamname" name="teamname" placeholder="Filter by Team Name" class="form-control" <cfif structkeyexists( form, "teamname" )>value="#trim( form.teamname )#"</cfif> onchange="javascript:this.form.submit();" />
														</div>
													</div>
													<div class="col-sm-2">
														<div class="form-group">
															<label class="control-label" for="price">Team City</label>
															<input type="text" id="teamcity" name="teamcity" placeholder="Filter by City" class="form-control" <cfif structkeyexists( form, "teamcity" )>value="#trim( form.teamcity )#"</cfif> onchange="javascript:this.form.submit();" />
														</div>
													</div>
													<input name="filterresults" type="hidden" value="true" />													
													<!---<button type="submit" name="filterresults" class="btn btn-sm btn-primary"><i class="fa fa-search"></i> Filter Results</button>--->
													<cfif structkeyexists( form, "filterresults" )>
														<a style="margin-left:3px;margin-top:24px;" href="#application.root##url.event#" class="btn btn-md btn-success"><i class="fa fa-remove"></i> Reset Filters</a>
													</cfif>
												</fieldset>
											</form>
										</cfoutput>	
										</div>
									</div>
							</div>
							
								
								
							<div class="ibox" style="margin-top:-15px;">								
								<div class="ibox-title">
									<cfoutput>
										<h5><i class="fa fa-database"></i> The database found #teamlist.recordcount# team<cfif teamlist.recordcount gt 0>s</cfif></h5>
										<cfif isuserinrole( "admin" )>
											<a href="#application.root##url.event#&fuseaction=team.add" class="btn btn-xs btn-primary pull-right"><i class="fa fa-plus"></i> Add Team </a>
										</cfif>
										<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=teams.view" class="btn btn-xs btn-white pull-right"><i class="fa fa-table"></i> Teams by Conference</a>										
									</cfoutput>
								</div>
								
								
									<div class="ibox-content">									
										<div class="table-responsive">			
											<cfif teamlist.recordcount gt 0>
												<table class="table table-striped">
													<thead>
														<tr>									
															<cfif isuserinrole( "admin" )>
																<th>Actions</th>
															</cfif>															
															<th>Conference</th>
															<th>Team Name</th>
															<th>Level</th>
															<th>Mascot</th>
															<th>City, State</th>
															<th>W/L</th>
															<th>Status</th>
														</tr>
													</thead>
													<tbody>
														<cfoutput query="teamlist">
															<tr>
																<cfif isuserinrole( "admin" )>
																	<td>
																		<a class="btn btn-sm btn-primary" href="#application.root##url.event#&fuseaction=team.edit&id=#teamid#" title="Edit Team Details"><i class="fa fa-edit"></i></a>
																		<a class="btn btn-sm btn-danger" href="#application.root##url.event#&fuseaction=team.delete&id=#teamid#" title="Delete Team Details"><i class="fa fa-trash"></i></a>
																	</td>
																</cfif>
																<td>#confname#</td>																
																<td><strong><a href="#application.root##url.event#&fuseaction=team.view&id=#teamid#">#teamname#</a></strong></td>
																<td><small>#teamlevel#</small></td>
																<td><small>#teammascot#</small></td>
																<td><small>#teamcity#, #stateabbr#</small></td>
																<td>#teamrecord#</td>
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
							
						