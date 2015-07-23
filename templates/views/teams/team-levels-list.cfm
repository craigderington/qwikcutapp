





					<div class="ibox">
						<div class="ibox-title">
							<h5><i class="fa fa-database"></i> <cfoutput>The database found #teamlevels.recordcount# team level<cfif ( teamlevels.recordcount gt 0 ) or ( teamlevels.recordcount eq 0 )>s...</cfif></cfoutput></h5>
						</div>
						<div class="ibox-content">


							<cfif structkeyexists( url, "delete" )>
								<cfif structkeyexists( url, "id" )>
									<cfif url.id neq 0 and url.id neq "">
										<cfif trim( url.delete ) eq "true">
											<cfinvoke component="apis.com.admin.teamadminservice" method="getteamlevel" returnvariable="teamlevel">
												<cfinvokeargument name="id" value="#url.id#">
											</cfinvoke>
											<!--- // check the levels against the database --->
											<!--- // enforce referential integrity --->
											<cfquery name="chkdata">
												select t.teamlevelid
												  from teams t, teamlevels tl
												 where t.teamlevelid = tl.teamlevelid 
												   and tl.teamlevelid = <cfqueryparam value="#teamlevel.teamlevelid#" cfsqltype="cf_sql_integer" />
											</cfquery>
												  
												<cfif chkdata.recordcount gt 0>
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<p>Sorry, you can not delete the selected team level.  The team level is being used.  Operation aborted.</p>
													</div>
												<cfelse>												  
													<cfquery name="killteamlevel">
														delete
														  from teamlevels
														 where teamlevelid = <cfqueryparam value="#teamlevel.teamlevelid#" cfsqltype="cf_sql_integer" />
													</cfquery>
													<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&scope=3" addtoken="no">
												</cfif>											  
										</cfif>
									</cfif>
								</cfif>
							</cfif>

							
							
							<!--- // system messages --->
							<cfif structkeyexists( url, "scope" )>
								<cfif url.scope eq 1>
									<div class="alert alert-success alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<p><i class="fa fa-check-circle-o"></i> Team Level Added</p>								
									</div>
								<cfelseif url.scope eq 2>						
									<div class="alert alert-info alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<p><i class="fa fa-check"></i> Team Level Saved</p>								
									</div>
								<cfelseif url.scope eq 3>						
									<div class="alert alert-danger alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<p><i class="fa fa-warning"></i> Team Level Deleted</p>								
									</div>
								</cfif>					
							</cfif>
							
							
							
							
							<!--- // begin data grid --->

							<cfif teamlevels.recordcount gt 0>
								<div class="table-responsive">
									<table class="table table-striped">
										<thead>
											<tr>
												<th>Actions</th>
												<th>Type</th>
												<th>Team Level</th>												
												<th>Code</th>
											</tr>
										</thead>
										<tbody>
											<cfoutput query="teamlevels">
												<tr>
													<td>
														<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#teamlevelid#"><small><i class="fa fa-edit"></i></small></a>
														<a style="margin-left:4px;" href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#teamlevelid#&delete=true" onclick="javascript:return confirm('Are you sure you want to delete this level?  This action can not be un-done...')"><small><i class="fa fa-trash"></i></small></a>
													</td>
													<td>#trim( teamlevelconftype )#</td>
													<td>#trim( teamlevelname )#</td>													
													<td>#trim( teamlevelcode )#</td>
												</tr>
											</cfoutput>
										</tbody>
									</table>
								</div>							
							<cfelse>
								<div class="alert alert-danger alert-dismissable">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<h5><i class="fa fa-warning"></i> NO RECORDS FOUND</h5>
										<p>Sorry, no system team levels were found in the database....  Please use the form to add team levels.</p>
								</div>
							</cfif>
						</div>
					</div>