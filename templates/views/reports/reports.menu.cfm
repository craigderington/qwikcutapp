


									
									
									
									<cfinvoke component="apis.com.reports.reportservice" method="getreportfolder" returnvariable="reportfolder">
										<cfinvokeargument name="folderslug" value="#trim( url.reports )#">
									</cfinvoke>							
									
									<cfif reportfolder.recordcount gt 0>
										
										<cfif isnumeric( reportfolder.reportfolderid )>
											
											<cfinvoke component="apis.com.reports.reportservice" method="getreports" returnvariable="reports">
												<cfinvokeargument name="folderid" value="#reportfolder.reportfolderid#">
											</cfinvoke>
											
											<cfoutput>
												<div class="row">
													<div class="ibox">
														<div class="ibox-title">
															<h5><i class="fa fa-briefcase"></i> #reportfolder.reportfolder# </h5>
														</div>
														<div class"ibox-content">
													
															<cfif reports.recordcount gt 0>
																<cfloop query="reports">
																	<div class="file-box">
																		<div class="file">
																			<a href="#application.root##url.event#&reports=#url.reports#&reportid=#reportid#">
																				<span class="corner"></span>
																					<div class="icon">
																						<i class="fa fa-table"></i>
																					</div>
																					<div class="file-name">
																						#reportname#
																						<br>
																						<small>Added: #dateformat( reportdatecreated, "mm-dd-yyyy" )#</small>
																					</div>
																			</a>
																		</div>
																	</div>
																</cfloop>
															<cfelse>
																<small>
																	<div class="alert alert-warning alert-dismissable">
																		<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																		<i class="fa fa-info-sign"></i> There are no reports in the selected folder.... <a class="alert-link" href="">Create A Report</a>.
																	</div>
																</small>
															</cfif>
														</div>
													</div>
												</div>
											</cfoutput>										
										<cfelse>
											<small>
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
													<i class="fa fa-warning"></i>  Error fetching reports list.  There was a problem with the report folder name.  <a class="alert-link" href="index.cfm?event=admin.reports">Report Home</a>.
												</div>
											</small>
										</cfif>
									<cfelse>
										<small>
											<div class="alert alert-danger alert-dismissable">
												<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
												<i class="fa fa-warning"></i>  Error fetching reports list.  There was a problem with the report folder name.  <a class="alert-link" href="index.cfm?event=admin.reports">Report Home</a>.
											</div>
										</small>
									</cfif>


									

									
									
								