


					<!--- check for existing conference session --->
					<cfif structkeyexists( form, "conferenceid" )>
						<cfif isnumeric( "form.conferenceid" )>
							<cfset session.conferenceid = #form.conferenceid# />
						<cfelse>
							<cfset session.conferenceid = 1 />
					</cfif>



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


							<!--- data filter for conference list to filter --->
							<form name="data-filter" method="post" action="#application.root##url.event#&fuseaction=team.levels">
								<fieldset>
									<div class="col-sm-3">
										<div class="form-group">
											<label class="control-label" for="conferenceid">Conference</label>
											<select name="conferenceid" id="conferenceid" class="form-control" onchange="javascript:this.form.submit();">
												<option value="" selected>Filter by Conference</option>
												<cfloop query="conferencelist">
													<option value="#confid#"<cfif structkeyexists( form, "conferenceid" )><cfif form.conferenceid eq conferencelist.confid>selected</cfif><cfelseif structkeyexists( session, "conferenceid" )><cfif session.conferenceid eq conferencelist.confid>selected</cfif></cfif>>#confname#</option>
												</cfloop>
											</select>
										</div>
									</div>
									<input name="filterresults" type="hidden" value="true" />
									<!---<button type="submit" name="filterresults" class="btn btn-sm btn-primary"><i class="fa fa-search"></i> Filter Results</button>--->
									<cfif structkeyexists( form, "filterresults" ) and ( not structkeyexists( session, "conferenceid" ) or not structkeyexists( session, "conferenceid" ))>
										<a style="margin-left:3px;margin-top:24px;" href="#application.root##url.event#" class="btn btn-md btn-success"><i class="fa fa-remove"></i> Reset Filters</a>
									</cfif>
									<cfif structkeyexists( session, "conferenceid" ) or structkeyexists( session, "teamlevelid" )>
										<a style="margin-left:3px;margin-top:24px;" href="#application.root##url.event#&resetfilter=true" class="btn btn-md btn-primary btn-outline"><i class="fa fa-remove"></i> Reset Filters</a>
									</cfif>
								</fieldset>
							</form>



							<!--- // begin data grid --->

							<cfif teamlevels.recordcount gt 0>
								<div class="table-responsive">
									<table class="table table-striped">
										<thead>
											<tr>
												<th>Actions</th>
												<th>Conference</th>
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
													<td>#trim( confname )#</td>
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
