






						





			
						<cfinvoke component="apis.com.admin.fieldadminservice" method="getregions" returnvariable="regionlist">
							<cfinvokeargument name="stateid" value="#session.stateid#">
						</cfinvoke>




							<div class="row">
							
								<cfoutput>							
								
									<div class="ibox">
										<div class="ibox-title">
											<h5><i class="fa fa-search"></i> Filter Your Results</h5>
										</div>
										<div class="ibox-content m-b-sm border-bottom">
											<form name="data-filter" method="post" action="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#">
												<div class="row">
													<div class="col-sm-2">
														<div class="form-group">
															<label class="control-label" for="stateid">State</label>
															<select name="stateid" id="stateid" class="form-control" onchange="javascript:this.form.submit();">
																<option value="" selected>Filter by State</option>
																	<cfloop query="statelist">														
																		<option value="#stateid#"<cfif structkeyexists( session, "fieldstateid" )><cfif statelist.stateid eq session.stateid>selected</cfif></cfif><cfif statelist.stateid eq session.stateid>selected</cfif>>#statename#</option>
																	</cfloop>
															</select>
														</div>
													</div>					
													
													<input name="filterresults" type="hidden" value="true" />													
													<!---<button type="submit" name="filterresults" class="btn btn-sm btn-primary"><i class="fa fa-search"></i> Filter Results</button>--->
													<cfif structkeyexists( form, "filterresults" ) and not structkeyexists( session, "fieldstateid" )>
														<a style="margin-left:3px;margin-top:24px;" href="#application.root##url.event#" class="btn btn-md btn-success"><i class="fa fa-remove"></i> Reset Filters</a>
													<cfelseif structkeyexists( session, "fieldstateid" )>
														<a style="margin-left:3px;margin-top:24px;" href="#application.root##url.event#&resetfilter=true" class="btn btn-md btn-primary"><i class="fa fa-remove"></i> Reset Filters</a>
													</cfif>
												</div>
											</form>
										</div>
									</div>
								</cfoutput>
								
								<div class="ibox" style="margin-top:-15px;">								
									<cfoutput>
										<div class="ibox-title">
											<h5><i class="fa fa-database"></i> The database found </h5>										
												<span class="pull-right">													
													<a href="#application.root##url.event#" class="btn btn-xs btn-primary"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
												</span>											
										</div>
									</cfoutput>						
									
									<div class="ibox-content">									
										<div class="table-responsive">
											
											<cfif regionlist.recordcount gt 0>

												<!--- // pagination --->
												<cfparam name="url.startRow" default="1" >
												<cfparam name="url.rowsPerPage" default="10" >
												<cfparam name="currentPage" default="1" >
												<cfparam name="totalPages" default="0" >
											
											
												<table class="table table-striped">
													<thead>
														<tr>															
															<th>State</th>														
															<th>Region ID</th>
															<th>Region Name</th>
															<th>Status</th>
														</tr>
													</thead>
													<tbody>
														<cfoutput query="regionlist" startrow="#url.startrow#" maxrows="#url.rowsperpage#">
															<tr>																
																<td>#statename#</td>																
																<td>#regionid#</td>
																<td>#region_name#</td>
																<td><a href="##" title="Active"><i class="fa fa-check text-primary"></i></a></td>
															</tr>
														</cfoutput>																			 
													</tbody>
													<!--- // pagination conditionals --->
													<cfset totalRecords = regionlist.recordcount />
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
							
						</div>