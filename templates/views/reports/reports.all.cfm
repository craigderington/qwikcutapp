


									
									
									<cfinvoke component="apis.com.reports.reportservice" method="getallreports" returnvariable="allreports">						
												
												
									<cfoutput>
										<div class="row">
											<div class="ibox">
												<div class="ibox-title">
													<h5><i class="fa fa-briefcase"></i> All Reports </h5>
												</div>
												<div class="ibox-content">													
													<cfif allreports.recordcount gt 0>
														<cfloop query="allreports">
															<div class="file-box">
																<div class="file">
																	<a href="#application.root##url.event#&reports=#url.reports#&reportid=#reportid#">
																		<span class="corner"></span>
																			<div class="icon">
																				<i class="fa fa-th-list"></i>
																			</div>
																			<div class="file-name">
																				#reportname#
																				<br>
																				<small>Added: #dateformat( reportdatecreated, "mm-dd-yyyy" )# #timeformat( reportdatecreated, "hh:mm tt" )#</small>
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
										