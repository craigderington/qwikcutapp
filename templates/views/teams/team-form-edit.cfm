			
			
			
			
							
                        					
							<cfif isDefined( "form.fieldnames" ) and structkeyexists( form, "teamid" )>
							
								<cfset form.validate_require = "teamid|Opps, internal form error.;teamname|Please enter the team name.;teamlevel|Please select a team level.;teamcolors|Please enter the team colors.;teammascot|Please enter the team mascot.;teamcity|Please enter the team city.;teamorgname|Please enter the team organization name." />
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>
										
										
										<cfif objValidation.getErrorCount() is 0>
																											
														
											<!--- define our form structure and set form values --->
											<cfset t = structnew() />
											<cfset t.teamid = form.teamid />
											<cfset t.teamlevel = trim( form.teamlevel ) />
											<cfset t.teamname = trim( form.teamname ) />
											<cfset t.teamcity = trim( form.teamcity ) />
											<cfset t.teamorgname = trim( form.teamorgname ) />
											<cfset t.teammascot = trim( form.teammascot ) />
											<cfset t.teamcolors = trim( form.teamcolors ) />
																				
														
												<!---// edit team data operartion --->
												<cfquery name="editteamdetail">
													update teams
													   set teamname = <cfqueryparam value="#t.teamname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
													       teamcity = <cfqueryparam value="#t.teamcity#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   teamcolors = <cfqueryparam value="#t.teamcolors#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   teammascot = <cfqueryparam value="#t.teammascot#" cfsqltype="cf_sql_varchar" maxlength="50" />,												  
														   teamlevel = <cfqueryparam value="#t.teamlevel#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   teamorgname = <cfqueryparam value="#t.teamorgname#" cfsqltype="cf_sql_varchar" maxlength="50" />									
													 where teamid = <cfqueryparam value="#t.teamid#" cfsqltype="cf_sql_integer" />														
												</cfquery>										
												
												
												<cflocation url="#application.root##url.event#" addtoken="no">			
														
											<!--- If the required data is missing - throw the validation error --->
											<cfelse>
											
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h2>
														<ul>
															<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
																<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
															</cfloop>
														</ul>
												</div>	
												
											</cfif>										
											
										</cfif>
										<!--- // end form processing --->
													
												
											
										
									
										
										<cfoutput>
											<form name="team-form-new" method="post" class="form-horizontal" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#"> 							
												
												<div class="form-group">
													<label class="col-lg-2 control-label">Conference</label>
													<div class="col-lg-10"><p class="form-control-static">#teamdetail.confname#</p></div>
													<input type="hidden" name="confid" value="#teamdetail.confid#" />													
												</div>
												
												<div class="form-group">
													<label class="col-lg-2 control-label">Type</label>
													<div class="col-lg-10"><p class="form-control-static"><cfif trim( teamdetail.conftype ) eq "YF">Youth Football<cfelse>High School Football</cfif></p></div>													
												</div>
												
												<div class="hr-line-dashed"></div>
												
												<cfif trim( teamdetail.conftype ) eq "YF">
													<div class="form-group">
														<label class="col-lg-2 control-label">Team Level</label>
														<div class="col-lg-10">
															<div class="i-checks"><label> <input type="radio" value="YT-TM" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "YT-TM"> checked</cfif> /> <i></i> Tiny Mite</label></div>
															<div class="i-checks"><label> <input type="radio" value="YT-MM" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "YT-MM"> checked</cfif> /> <i></i> Mighty Mite</label></div>
															<div class="i-checks"><label> <input type="radio" value="YT-JPW" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "YT-JPW"> checked</cfif> /> <i></i> Junior PeeWee </label></div>
															<div class="i-checks"><label> <input type="radio" value="YT-PW" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "YT-PW"> checked</cfif> /> <i></i> PeeWee </label></div>
															<div class="i-checks"><label> <input type="radio" value="YT-JM" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "YT-JM"> checked</cfif> /> <i></i> Junior Midget</label></div>
															<div class="i-checks"><label> <input type="radio" value="YT-UL" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "YT-UL"> checked</cfif> /> <i></i> Unlimited </label></div>
														</div>
													</div>
												<cfelseif trim( teamdetail.conftype ) eq "HS">
													<div class="form-group">
														<label class="col-lg-2 control-label">Team Level</label>
														<div class="col-lg-10">
															<div class="i-checks"><label> <input type="radio" value="HS-FR" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "HS-FR"> checked</cfif> /> <i></i> Freshman</label></div>
															<div class="i-checks"><label> <input type="radio" value="HS-JV" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "HS-JV"> checked</cfif> /> <i></i> Junior Varsity </label></div>
															<div class="i-checks"><label> <input type="radio" value="HS-V" name="teamlevel" <cfif trim( teamdetail.teamlevel ) eq "HS-V"> checked</cfif> /> <i></i> Varsity </label></div>
														</div>
													</div>
												</cfif>
												
												<div class="hr-line-dashed"></div>
											
												<div class="form-group">
													<label class="col-lg-2 control-label">Team Name</label>
													<div class="col-lg-10">
														<input type="text" class="form-control" placeholder="Team Name" name="teamname" <cfif structkeyexists( form, "teamname" )>value="#trim( form.teamname )#"<cfelse>value="#trim( teamdetail.teamname )#"</cfif> />
													</div>
												</div>
												
												<div class="hr-line-dashed"></div>
												
												<div class="form-group">
													<label class="col-lg-2 control-label">Org Name</label>
													<div class="col-lg-10">
														<input type="text" class="form-control" placeholder="Team Organization Name" name="teamorgname" <cfif structkeyexists( form, "teamorgname" )>value="#trim( form.teamorgname )#"<cfelse>value="#trim( teamdetail.teamorgname )#"</cfif> />
													</div>
												</div>
											
												<div class="hr-line-dashed"></div>

												<div class="form-group">
													<label class="col-lg-2 control-label">Team City</label>
													<div class="col-lg-10">
														<input type="text" class="form-control" placeholder="Team City" name="teamcity" <cfif structkeyexists( form, "teamcity" )>value="#trim( form.teamcity )#"<cfelse>value="#trim( teamdetail.teamcity )#"</cfif> />
													</div>
												</div>
											
												<div class="hr-line-dashed"></div>
												
												<div class="form-group">
													<label class="col-sm-2 control-label">Team Mascot</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" placeholder="Team Mascot" name="teammascot" <cfif structkeyexists( form, "teammascot" )>value="#trim( form.teammascot )#"<cfelse>value="#trim( teamdetail.teammascot )#"</cfif> />
													</div>
												</div>
												
												<div class="hr-line-dashed"></div>
												
												<div class="form-group">
													<label class="col-sm-2 control-label">Team Colors</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" placeholder="Team Colors (i.e. Red/White)" name="teamcolors" <cfif structkeyexists( form, "teamcolors" )>value="#trim( form.teamcolors )#"<cfelse>value="#trim( teamdetail.teamcolors )#"</cfif> />
													</div>
												</div>
											
												<div class="hr-line-dashed"></div>
											
												<div class="form-group">
													<div class="col-sm-4 col-sm-offset-2">
														<button class="btn btn-primary" type="submit"><i class="fa fa-save"></i> Save Team</button>
														<a href="#application.root##url.event#" class="btn btn-white" type="submit"><i class="fa fa-remove"></i> Cancel</a>
														<input type="hidden" name="teamid" value="#teamdetail.teamid#" />
													</div>
												</div>
											</form>	
										</cfoutput>
                   
               
            