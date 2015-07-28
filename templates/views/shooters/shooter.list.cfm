




						<cfoutput>
							<div class="row">							
								<div class="ibox">
									<div class="ibox-title">
										<h5><i class="fa fa-search"></i> Filter Your Results</h5>
									</div>
									<div class="ibox-content m-b-sm border-bottom">
										<form name="data-filter" method="post" action="">
											<div class="row">
												<div class="col-sm-2">
													<div class="form-group">
														<label class="control-label" for="stateid">State</label>
														<select name="stateid" id="stateid" class="form-control" onchange="javascript:this.form.submit();">
															<option value="" selected>Filter by State</option>
															<cfloop query="statelist">
																<option value="#stateid#"<cfif structkeyexists( form, "stateid" )><cfif numberformat( form.stateid, "99" ) eq numberformat( statelist.stateid, "99" )>selected</cfif></cfif>>#statename#</option>
															</cfloop>
														</select>
													</div>
												</div>
												<div class="col-sm-3">
													<div class="form-group">
														<label class="control-label" for="shootername">Shooter Name</label>
														<input type="text" id="shootername" name="shootername" placeholder="Search by Shooter Name" class="form-control" <cfif structkeyexists( form, "shootername" )>value="#trim( form.shootername )#"</cfif> onblur="javascript:this.form.submit();">
													</div>
												</div>											
												<div class="col-sm-2">
													<div class="form-group">
														<label class="control-label" for="shooterstatus">Shooter Status</label>
														<select name="shooterstatus" id="shooterstatus" class="form-control" onchange="javascript:this.form.submit();">
															<option value="" selected>Filter by Status</option>
															<option value="1"<cfif structkeyexists( form, "shooterstatus" ) and form.shooterstatus eq 1>selected</cfif>>Active</option>
															<option value="0"<cfif structkeyexists( form, "shooterstatus" ) and form.shooterstatus eq 0>selected</cfif>>Inactive</option>
														</select>
													</div>
												</div>
												<input name="filterresults" type="hidden" value="true" />													
												<!---<button type="submit" name="filterresults" class="btn btn-sm btn-primary"><i class="fa fa-search"></i> Filter Results</button>--->
												<cfif structkeyexists( form, "filterresults" )>
													<a style="margin-left:3px;margin-top:24px;" href="#application.root##url.event#" class="btn btn-md btn-success"><i class="fa fa-remove"></i> Reset Filters</a>
												</cfif>
											</div>
										</form>
									</div>
								</div>
							</div>
							<div class="row">							
								<div class="ibox" style="margin-top:-15px;">								
									<div class="ibox-title">
										<h5><i class="fa fa-database"></i> The database found #shooterlist.recordcount# record<cfif shooterlist.recordcount gt 0 or shooterlist.recordcount eq 0>s</cfif>.</h5>										
											<span class="pull-right">
												<a href="#application.root#admin.home" class="btn btn-xs btn-default"><i class="fa fa-cog"></i> Admin Home</a>
												<a style="margin-left:5px;" href="#application.root#admin.shooters&fuseaction=shooter.add&id=0" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-user-plus"></i> Add Shooter</a>
											</span>
									</div>
															
									<div class="ibox-content" style="min-height:500px;">									
										
										<cfif shooterlist.recordcount gt 0>
											<cfoutput query="shooterlist">
												<div class="col-lg-4">											
													<div class="contact-box">
														<a href="#application.root##url.event#&fuseaction=shooter.view&id=#shooterid#">
															<div class="col-sm-4">
																<div class="text-center">
																	<i class="fa fa-video-camera fa-4x text-primary"></i>
																	<div class="m-t-xs font-bold"></div>
																	<br />
																	<cfif shooterisactive eq 1>
																		<span class="label label-success"><i class="fa fa-check"></i> Active</span>
																	<cfelse>
																		<span class="label label-danger"><i class="fa fa-check"></i> Inactive</span>
																	</cfif>
																</div>
															</div>
															<div class="col-sm-8">
																
																<cfif shootercity neq "" and shooterzip neq "" and shooteremail neq "">
																	<h3><strong>#shooterfirstname# #shooterlastname#</strong></h3>
																	<p><i class="fa fa-map-marker"></i> #shootercity#, #stateabbr#</p>
																	<address>															
																		#shooteraddress1#<br/>
																		#shootercity#, #stateabbr# #shooterzip#<br />
																		#shootercellphone#<br />
																		#shooteremail#																
																	</address>
																<cfelse>
																	<h3><strong>#shooterfirstname# #shooterlastname#</strong></h3>
																	<p><i class="fa fa-map-marker"></i> #stateabbr#</p>
																	<address>															
																		Address Not Entered<br/>
																		Located In: #stateabbr#<br />
																		No Phone Saved <br />
																		#shooteremail#																
																	</address>
																</cfif>
																
															</div>
															<div class="clearfix"></div>
														</a>
													</div>											
												</div>
											</cfoutput>
										
										<cfelse>
										
											<div class="alert alert-danger alert-dismissable">
												<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
												<p><i class="fa fa-warning"></i> No Records Found...</p>								
											</div>
										
										</cfif>
										
									</div>
								</div>							
							</div>
						</cfoutput>