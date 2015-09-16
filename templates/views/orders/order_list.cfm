
										
										
										
										
										<cfinvoke component="apis.com.admin.storeadminservice" method="getorders" returnvariable="orders">
											<cfif structkeyexists( form, "filterresults" )>
												<cfif structkeyexists( form, "order_date" )>
													<cfinvokeargument name="order_date" value="#form.order_date#">
												</cfif>
												<cfif structkeyexists( form, "order_id" )>
													<cfinvokeargument name="order_id" value="#form.order_id#">
												</cfif>
												<cfif structkeyexists( form, "customer_name" )>
													<cfinvokeargument name="customer_name" value="#trim( form.customer_name )#">
												</cfif>
											</cfif>
										</cfinvoke>





									
										<div class="ibox">
											<div class="ibox-content">
												<cfif orders.recordcount gt 0>
												
													<!--- // pagination --->
													<cfparam name="url.startRow" default="1" >
													<cfparam name="url.rowsPerPage" default="20" >
													<cfparam name="currentPage" default="1" >
													<cfparam name="totalPages" default="0" >
												
													<table class="footable table table-stripped toggle-arrow-tiny default footable-loaded" data-page-size="15">
														<thead>
															<tr>
																<th class="footable-visible footable-first-column footable-sortable">Order ID<span class="footable-sort-indicator"></span></th>
																<th data-hide="phone" class="footable-visible footable-sortable">Customer<span class="footable-sort-indicator"></span></th>
																<th data-hide="phone" class="footable-visible footable-sortable">Amount<span class="footable-sort-indicator"></span></th>
																<th data-hide="phone" class="footable-visible footable-sortable">Date added<span class="footable-sort-indicator"></span></th>
																<th data-hide="phone,tablet" class="footable-visible footable-sortable">Date modified<span class="footable-sort-indicator"></span></th>
																<th data-hide="phone" class="footable-visible footable-sortable">Status<span class="footable-sort-indicator"></span></th>
																<th class="text-right footable-visible footable-last-column footable-sortable">Actions<span class="footable-sort-indicator"></span></th>
															</tr>
														</thead>
														<tbody>
															<cfoutput query="orders" startrow="#url.startrow#" maxrows="#url.rowsperpage#">
																<tr class="footable-even" style="display: table-row;">
																	<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
																	   #order_id#
																	</td>
																	<td class="footable-visible">
																		#first_name# #last_name#
																	</td>
																	<td class="footable-visible">
																		#dollarformat( total_sale )#
																	</td>
																	<td class="footable-visible">
																		#dateformat( order_date, "mm-dd-yyyy" )#
																	</td>
																	<td class="footable-visible">
																		#dateformat( order_date, "mm-dd-yyyy" )#
																	</td>
																	<td class="footable-visible">
																		
																		<cfif trim( order_status ) eq "In Process">
																			<span class="label label-danger">#order_status#</span>
																		<cfelseif trim( order_status ) eq "Pending">
																			<span class="label label-info">#order_status#</span>
																		<cfelseif trim( order_status ) eq "Fufilled">
																			<span class="label label-primary">#order_status#</span>
																		<cfelseif trim( order_status ) eq "Awaiting Payment">
																			<span class="label label-default">#order_status#</span>
																		<cfelseif trim( order_status ) eq "Cancelled">
																			<span class="label label-warning">#order_status#</span>
																		</cfif>
																		
																		
																		
																	</td>
																	<td class="text-right footable-visible footable-last-column">
																		<div class="btn-group">
																			<a href="#application.root##url.event#&fuseaction=order_view&order_id=#order_id#" class="btn-white btn btn-xs">View</a>
																			<a href="#application.root##url.event#&fuseaction=order_edit&order_id=#order_id#" class="btn-white btn btn-xs">Edit</a>
																			<a href="#application.root##url.event#&fuseaction=order_remove&order_id=#order_id#" class="btn-white btn btn-xs">Delete</a>
																		</div>
																	</td>
																</tr>
															</cfoutput>
														</tbody>
														
														<!--- // pagination conditionals --->
													<cfset totalRecords = orders.recordcount />
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
														
														
														<!---
														<tfoot>
															<tr>
																<td colspan="7" class="footable-visible">
																	<ul class="pagination pull-right"><li class="footable-page-arrow disabled"><a data-page="first" href="first"><i class="fa fa-angle-double-left"></i></a></li><li class="footable-page-arrow disabled"><a data-page="prev" href="prev"><i class="fa fa-angle-left"></i></a></li><li class="footable-page active"><a data-page="0" href="">1</a></li><li class="footable-page"><a data-page="1" href="">2</a></li><li class="footable-page"><a data-page="2" href="">3</a></li><li class="footable-page-arrow"><a data-page="next" href="next"><i class="fa fa-angle-right"></i></a></li><li class="footable-page-arrow"><a data-page="last" href="last"><i class="fa fa-angle-double-right"></i></a></li></ul>
																</td>
															</tr>
														</tfoot>
														--->
													</table>
												<cfelse>
													<div class="alert alert-info">
														<h5><i class="fa fa-warning"></i> <strong>No Orders Found!</strong></h5>
														<p>There are no orders to display in the data grid.  Reset your data filters and try again...</p>
													</div>
												</cfif>
											</div>
										</div>									
									