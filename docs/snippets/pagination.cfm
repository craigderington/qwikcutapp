												
												
												
												
												<!--- // buttons --->
												
												
												<!--- activity log pagination --->
												<cfparam name="startrow" default="1">
												<cfparam name="displayrows" default="10">
												<cfparam name="torow" default="0">												
												
												<cfset torow = startrow + ( displayrows - 1 ) />
												<cfif torow gt mleadlist.recordcount>
													<cfset torow = mleadlist.recordcount />
												</cfif>												
												
												<cfset next = startrow + displayrows>
												<cfset prev = startrow - displayrows>

												
												<cfoutput>
													<h5><i style="margin-right:5px;" class="icon-th-large"></i> Total New Inquiry Records: #mleadlist.recordcount# | Displaying #startrow# to #torow#      <span class="pull-right"><cfif prev gte 1><a style="margin-bottom:5px;" href="#application.root#?event=#url.event#&startrow=#prev#" class="btn btn-medium btn-secondary"><i class="icon-circle-arrow-left"></i> Previous #displayrows# Records</a></cfif><cfif next lte mleadlist.recordcount><a style="margin-bottom:5px;margin-left:5px;" class="btn btn-medium btn-default" href="#application.root#?event=#url.event#&startrow=#next#">Next <cfif ( mleadlist.recordcount - next ) lt displayrows>#evaluate(( mleadlist.recordcount - next ) + 1 )#<cfelse>#displayrows#</cfif> Records <i class="icon-circle-arrow-right"></i></a></cfif>  <a href="#application.root#?event=page.lead.new" style="margin-left:5px;margin-bottom:5px;" class="btn btn-medium btn-primary"><i class="icon-plus"></i> Create New Inquiry</a></span></h5>
												</cfoutput>
												
												
												
												
												<cfoutput query="mleadlist" startrow="#startrow#" maxrows="#displayrows#">
													data grid output
												</cfoutput>
												
												
												
												
												<!--- // pagination via page number + prev/next links --->
														<cfparam name="url.startRow" default="1" >
														<cfparam name="url.rowsPerPage" default="20" >
														<cfparam name="currentPage" default="1" >
														<cfparam name="totalPages" default="0" >
															<table class="table table-bordered table-striped table-highlight">
																<thead>
																	<tr>
																		<th width="10%">Date</th>
																		<th>Type</th>																		
																		<th>Activity</th>																	
																	</tr>
																</thead>
																<tbody>																		
																	<cfoutput query="leadact" startrow="#url.startrow#" maxrows="#url.rowsperpage#">
																	<tr>
																		<td>#dateformat(activitydate, "mm/dd/yyyy")#</td>																	
																		<td>#activitytype#</td>																		
																		<td>#activity#</td>																	
																	</tr>		
																	</cfoutput>											
																</tbody>
															</table>
															
															
															
															<!--- // 7-26-2013 // new pagination ++ page number links --->
													
															<cfset totalRecords = leadact.recordcount >
															<cfset totalPages = totalRecords / rowsPerPage >
															<cfset endRow = (startRow + rowsPerPage) - 1 >													

																<!--- If the endrow is greater than the total, set the end row to to total --->
																<cfif endRow GT totalRecords>
																   <cfset endRow = totalRecords>
																</cfif>

																<!--- Add an extra page if you have leftovers --->
																<cfif (totalRecords MOD rowsPerPage) GT 0 >
																   <cfset totalPages = totalPages + 1 >
																</cfif>

																<!--- Display all of the pages --->
																<cfif totalPages gte 2>
																	<div class="pagination">
																		<ul>
																			<cfloop from="1" to="#totalPages#" index="i">
																				<cfset startRow = ((i - 1) * rowsPerPage) + 1>
																				<cfif currentPage neq i>
																					<cfoutput><li><a href="#cgi.script_name#?event=#url.event#&startRow=#startRow#&currentPage=#i#">#i#</a></li></cfoutput>
																				<cfelse>
																					<cfoutput><li class="active"><a href="javascript:;">#i#</a></li></cfoutput>
																				</cfif>													
																		   </cfloop>
																		</ul>
																	</div>
																</cfif>
												
												
												