





							
				
				
							<div class="ibox">
				
								<div class="ibox-title">
									<h5><i class="fa fa-search"></i> Filter Your Results</h5>
								</div>

									<div class="ibox-content m-b-sm border-bottom">
										<div class="row">
											<cfoutput>
												<form name="data-filter" method="post" action="#application.root##url.event#">
													<fieldset>
														<div class="col-sm-3">
															<div class="form-group">
																<label class="control-label" for="conferenceid">Conference</label>
																<select name="conferenceid" id="conferenceid" class="form-control" onchange="javascript:this.form.submit();">
																	<option value="" selected>Filter by Conference</option>
																	<cfloop query="conferencelist">
																		<option value="#confid#"<cfif structkeyexists( form, "conferenceid" )><cfif form.conferenceid eq conferencelist.confid>selected</cfif></cfif>>#confname#</option>
																	</cfloop>
																</select>
															</div>
														</div>
														<div class="col-sm-3">
															<div class="form-group">
																<label class="control-label" for="teamlevelid">Team Level</label>
																<select name="teamlevelid" id="teamlevelid" class="form-control" onchange="javascript:this.form.submit();">
																	<option value="" selected>Filter by Team Level</option>
																	<cfloop query="teamlevels">
																		<option value="#teamlevelid#"<cfif structkeyexists( form, "teamlevelid" )><cfif form.teamlevelid eq teamlevels.teamlevelid>selected</cfif></cfif>>#teamlevelconftype# - #teamlevelname#</option>
																	</cfloop>
																</select>
															</div>
														</div>
														<div class="col-sm-2">
															<div class="form-group">
																<label class="control-label" for="product_name">Team</label>
																<input type="text" id="teamname" name="teamname" placeholder="Filter by Team Name" class="form-control" <cfif structkeyexists( form, "teamname" )>value="#trim( form.teamname )#"</cfif> onchange="javascript:this.form.submit();" />
															</div>
														</div>
														<div class="col-sm-2">
															<div class="form-group" id="data_1">
																<label class="control-label" for="price">Game Date</label>
																<div class="input-group date">
																	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																	<input type="text" id="gamedate" name="gamedate" placeholder="Filter by Date" class="form-control" <cfif structkeyexists( form, "gamedate" )>value="#trim( form.gamedate )#"</cfif> onchange="javascript:this.form.submit();" />
																</div>
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
							
								
							<cfoutput>	
							<div class="ibox" style="margin-top:-15px;">								
								<div class="ibox-title">									
									<h5><i class="fa fa-database"></i> The database found #gameslist.recordcount# scheduled games<cfif gameslist.recordcount gt 0>s</cfif>.</h5>										
									<span class="pull-right">
										<a href="#application.root##url.event#&fuseaction=game.add" class="btn btn-xs btn-primary"><i class="fa fa-clock-o"></i> Schedule Games </a>										
										<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=teams.view" class="btn btn-xs btn-success"><i class="fa fa-trophy"></i> Conference Standings</a>
									</span>
								</div>
							</cfoutput>	
								
									<div class="ibox-content">									
										<div class="table-responsive">			
											<cfif gameslist.recordcount gt 0>											
												
												<!--- // pagination --->
												<cfparam name="url.startRow" default="1" >
												<cfparam name="url.rowsPerPage" default="10" >
												<cfparam name="currentPage" default="1" >
												<cfparam name="totalPages" default="0" >
											
											
											
											
												<table class="table table-striped">
													<thead>
														<tr>									
															<cfif isuserinrole( "admin" )>
																<th>Actions</th>
															</cfif>															
															<th>Conference</th>
															<th>Level</th>
															<th>Field</th>
															<th>Game Day</th>
															<th>Teams</th>
															<th>Outcome</th>
															<th>Status</th>
														</tr>
													</thead>
													<tbody>
														<cfoutput query="gameslist" startrow="#url.startrow#" maxrows="#url.rowsperpage#">
															<tr>
																<cfif isuserinrole( "admin" )>
																	<td>
																		<a class="btn btn-sm btn-primary" href="#application.root##url.event#&fuseaction=team.edit&id=#teamid#" title="Edit Game"><i class="fa fa-clock"></i></a>
																	</td>
																</cfif>
																<td>#confname#</td>																
																<td><strong></strong></td>
																<td><small></small></td>
																<td><small></small></td>
																<td><small></small></td>
																<td></td>
																<td><a href="##" title="Active"><i class="fa fa-clock text-primary"></i></a><a style="margin-left:5px;" href="##" title="Modify Game"><i class="fa fa-clock text-blue"></i></a><a style="margin-left:5px;" href="##" title="Assign Shooter"><i class="fa fa-video-camera text-success"></i></a></td>
															</tr>
														</cfoutput>																		 
													</tbody>
													
													<!--- // pagination conditionals --->
													<cfset totalRecords = gameslist.recordcount />
													<cfset totalPages = totalRecords / rowsPerPage />
													<cfset endRow = (startRow + rowsPerPage) - 1 />													

														<!--- If the endrow is greater than the total, set the end row to to total --->
														<cfif endRow GT totalRecords>
															<cfset endRow = totalRecords />
														</cfif>

														<!--- Add an extra page if you have leftovers --->
														<cfif (totalRecords MOD rowsPerPage) GT 0 >
															<cfset totalPages = totalPages + 1 />
														</cfif>

														<!--- Display all of the pages --->
														<cfif totalPages gte 2>												
															<cfoutput>
																<tfoot>
																	<tr>
																		<td colspan="8" class="footable-visible">
																			<ul class="pagination pull-right">
																				<cfloop from="1" to="#totalPages#" index="i">
																					<cfset startRow = (( i - 1 ) * rowsPerPage ) + 1 />
																					<cfif currentPage neq i>
																						<li class="footable-page active"><a href="#application.root##url.event#&startRow=#startRow#&currentPage=#i#">#i#</a></li>
																					<cfelse>
																						<li class="footable-page"><a href="javascript:;">#i#</a></li>
																					</cfif>													
																				</cfloop>																																				
																			</ul>
																		</td>
																	</tr>
																</tfoot>
															</cfoutput>														
														</cfif>
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
								
								
								
								
						