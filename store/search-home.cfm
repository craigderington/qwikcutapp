									
								
								
								
								
								
								
									
									
									
									
								<cfoutput>
									
									
									<div class="ibox">
										<div class="ibox-title">
											<h5><i class="fa fa-search"></i> Search Games</h5>
										</div>
										<div class="ibox-content">											
											
											
											<cfif structkeyexists( url, "sid" ) and structkeyexists( url, "fuseaction" )>
											
												<cfif trim( url.fuseaction )  eq "filter" and isnumeric( url.sid )>
												
													<cfinvoke component="apis.com.store.storegameservice" method="getconferences" returnvariable="conferencelist">
														<cfinvokeargument name="stateid" value="#url.sid#">
													</cfinvoke>													
														
														<cfif conferencelist.recordcount gt 0>
															<div>																						
																<ul class="list-group">
																	<li class="list-group-item active">Filter By Conference</li>
																	<cfloop query="conferencelist">
																		<li class="list-group-item"><a href="team_results.cfm?cid=#confid#&fuseaction=getteams" class="text-primary" style="font-weight:bold;"><i class="fa fa-circle-o"></i> #confname#</a></li>
																	</cfloop>
																	<li class="list-group-item"><a href="index.cfm" class="btn btn-sm btn-primary"><i class="fa fa-times-circle"></i> Reset Filter</a></li>
																</ul>
															</div>
															
														<cfelse>
														
															<div class="alert alert-danger">
																<h5>No Records Found!</h5>
																<p>The selected state does not have any conferences to display... </p>
															</div>
														
														</cfif>											
												
												<cfelse>
												
													<div class="alert alert-danger">
														<h5>Error!</h5>
														<p>The state ID must be a numeric value.  Operation aborted! </p>
													</div>
												
												</cfif>											
											
											
											<cfelse>
											
											
												<!--- // default view --->
											
											
												<form class="form-horizontal m-b" name="searchgames" method="post" action="search_results.cfm?fuseaction=search">
													<fieldset>
														<div class="input-group">
															<input type="text" placeholder="Search by Team or Game Date" name="search" class="input-md form-control" onblur="javascript:this.form.submit();" <cfif structkeyexists( form, "search" )>value="#trim( form.search )#"</cfif>> 
															<span class="input-group-btn">
																<button type="submit" name="dosearch" class="btn btn-md btn-primary"> Go!</button> 
															</span>
														</div>
													</fieldset>
												</form>
												<br />
												<div>																						
													<ul class="list-group">
														<li class="list-group-item active">Filter By State</li>
														<li class="list-group-item"><a href="index.cfm?sid=1&fuseaction=filter" style="font-weight:bold;"><i class="fa fa-circle-o"></i> Florida</a></li>
														<li class="list-group-item">Georgia</li>
														<li class="list-group-item">North Carolina</li>
														<li class="list-group-item">South Carolina</li>
													</ul>
												</div>

											</cfif>
											
										</div>
									</div>
								</cfoutput>