			
			
			
			
							
                        					
							<cfif isDefined( "form.fieldnames" ) and structkeyexists( form, "teamid" )>
							
								<cfset form.validate_require = "teamid|Opps, internal form error.;teamname|Please enter the team name.;teamlevelid|Please select a team level.;teamcolors|Please enter the team colors.;teammascot|Please enter the team mascot.;teamcity|Please enter the team city.;teamorgname|Please enter the team organization name." />
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>
										
										
										<cfif objValidation.getErrorCount() is 0>
																											
														
											<!--- define our form structure and set form values --->
											<cfset t = structnew() />
											<cfset t.teamid = form.teamid />
											<cfset t.teamlevelid = form.teamlevelid />
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
														   teamlevelid = <cfqueryparam value="#t.teamlevelid#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   teamorgname = <cfqueryparam value="#t.teamorgname#" cfsqltype="cf_sql_varchar" maxlength="50" />									
													 where teamid = <cfqueryparam value="#t.teamid#" cfsqltype="cf_sql_integer" />														
												</cfquery>

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="updated the team #t.teamname# in the system." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>
												
												
												<cflocation url="#application.root##url.event#&scope=t2" addtoken="no">			
														
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
												
													<!--- // 7-23-2015 // modify to systemize and output team levels from database --->
													<!--- // this enables the user to add all team levels for the master team being added --->
													<cfinvoke component="apis.com.admin.teamadminservice" method="getteamlevelsforconference" returnvariable="teamlevels">
														<cfinvokeargument name="teamlevelconftype" value="#trim( teamdetail.conftype )#">
													</cfinvoke>
												
												
													<div class="form-group">
														<label class="col-lg-2 control-label">Team Levels <br /><small><a href="#application.root##url.event#&fuseaction=team.levels">Manage Levels</a></small></label>
														<div class="col-lg-10">
															<cfloop query="teamlevels">
																<div class="i-checks"><label> <input type="radio" value="#teamlevelid#" name="teamlevelid"<cfif teamdetail.teamlevelid eq teamlevels.teamlevelid>checked</cfif> /> <i></i> #teamlevelname#</label></div>
															</cfloop>
														</div>
													</div>
												
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
                   
               
            