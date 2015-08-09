


							

								
								<div class="col-md-6">
									<cfinclude template="game-shooter-view.cfm">
								</div>
								
								<div class="col-md-6">
									<!--- // begin form processing --->
									<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "shooterGameAssign" )>
														
										<cfset form.validate_require = "shooterid|Please select a videographer from the list." />
															
											<cfscript>
												objValidation = createobject( "component","apis.udfs.validation" ).init();
												objValidation.setFields( form );
												objValidation.validate();
											</cfscript>

											<cfif objValidation.getErrorCount() is 0>							
																
												<!--- define our form structure and set form values --->
												<cfset s = structnew() />
												<cfset s.shooterassignid = 0 />
												<cfset s.shooterid = form.shooterid />
												<cfset s.gamevsid = session.vsid />
												<cfset s.gameid = games.gameid />
												<cfset s.assigndate = now() />
												<cfset s.assignstatus = "Assigned">

													<cfquery name="getlastassignment">
														select max(shooterassignmentid) as assignlastid
														  from shooterassignments
													</cfquery>
													
													<!--- // did not create shooterassignment pkid as auto_increment, workaround --->
													<cfif getlastassignment.assignlastid neq "">													
														<cfset s.shooterassignid = getlastassignment.assignlastid  />
														<cfset s.shooterassignid = s.shooterassignid + 1 />													
													<cfelse>
														<cfset s.shooterassignid = 2365 />
													</cfif>
													
													<cfquery name="assignshooters">
														insert into shooterassignments(shooterassignmentid,gameid,vsid,shooterid,shooterassignstatus,shooterassigndate,shooterassignlastupdated)
															values (
																	<cfqueryparam value="#s.shooterassignid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.gameid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.gamevsid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.shooterid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.assignstatus#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#s.assigndate#" cfsqltype="cf_sql_timestamp" />,
																	<cfqueryparam value="#s.assigndate#" cfsqltype="cf_sql_timestamp" />
																	);
													</cfquery>											
													
													<!--- // begin notify shooters --->
													
													<!--- // end notify shooters --->

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
															values(
																	<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																	<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="assigned shooter #s.shooterid# to Game ID: #s.gamevsid#." cfsqltype="cf_sql_varchar" />																
																	);
													</cfquery>
																	
													<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#" addtoken="no">				
																
													
													<!--- If the required data is missing - throw the validation error --->
											<cfelse>
															
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h5>
															<ul>
																<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
																	<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
																</cfloop>
															</ul>
														</div>				
																
											</cfif>										
															
									</cfif>
									<!--- // end form processing --->
									
									<cfinvoke component="apis.com.admin.gameadminservice" method="getshooterfields" returnvariable="shooterfields">
										<cfinvokeargument name="fieldid" value="#versus.fieldid#">
										<cfif gameshooters.recordcount gt 0>
											<cfinvokeargument name="assignedids" value="#valuelist( gameshooters.shooterid )#">
										<cfelse>
											<cfinvokeargument name="assignedids" value="0">
										</cfif>
									</cfinvoke>
									
									<cfoutput>
										<form class="form-horizontal" name="assign-game-shooters" method="post">
											<fieldset>
												<cfif shooterfields.recordcount gt 0>
													<div class="form-group">
														<label class="label control-label">Select Shooters</label>														
															<select class="form-control" name="shooterid" id="shooterid">
																<option value="" selected>Assign Shooters to Game</option>
																<cfloop query="shooterfields">
																	<option value="#shooterid#">#shooterfirstname# #shooterlastname#</option>
																</cfloop>
															</select>													
													</div>
													<div class="hr-line-dashed" style="margin-top:15px;"></div>
														<div class="form-group">
															<div class="col-lg-offset-2 col-lg-10">
																<button class="btn btn-sm btn-primary" type="submit" name="shooterGameAssign"><i class="fa fa-save"></i> Assign Shooter</button>
																<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-sm btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
															</div>
													</div>
												<cfelse>
													<cfif gameshooters.recordcount gt 0>
														<div class="alert alert-warning">
															<i class="fa fa-info-circle"></i><small> There are no more shooters assigned to the selected field. <a href="#application.root#admin.shooters">Shooter Admin</a>
														</div>
													<cfelse>
														<div class="alert alert-warning">
															<i class="fa fa-warning"></i><small> There are no shooters assigned to the selected field. <a href="#application.root#admin.shooters">Shooter Admin</a>
														</div>
													</cfif>
												</cfif>							
											</fieldset>				
										</form>
									</cfoutput>
								</div>