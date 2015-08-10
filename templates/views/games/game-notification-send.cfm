

						
						
						<!-- to alert shooters of game notifications, get the list of game shooters --->
						<cfinvoke component="apis.com.admin.gameadminservice" method="getgameshooters" returnvariable="gameshooters">
							<cfinvokeargument name="vsid" value="#session.vsid#">
						</cfinvoke>






						<div class="col-md-6">					
							<cfinclude template="game-notification-view.cfm">						
						</div>
						
						
						<cfoutput>
							<div class="col-md-6">
								<div class="ibox">
									<div class="ibox-title">
										<h5><i class="fa fa-mobile"></i> Create Notification</h5>
									</div>
									<div class="ibox-content">
									
										<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "sendGameNotification" )>
										
											<cfset form.validate_require = "notificationtype|Please select a notification type.;message|Please enter the game notification message." />
										
												<cfscript>
													objValidation = createobject( "component","apis.udfs.validation" ).init();
													objValidation.setFields( form );
													objValidation.validate();
												</cfscript>

												<cfif objValidation.getErrorCount() is 0>
										
													<!--- // go ahead and create the notification --->
													<cfset n = structnew() />
													<cfset n.vsid = session.vsid />
													<cfset n.gameid = 0 />
													<cfset n.notificationdate = now() />
													<cfset n.notificationstatus = "Queued" />
													<cfset n.notificationtype = trim( form.notificationtype ) />
													<cfset n.notificationtext = trim( form.message ) />
													
													<cfif structkeyexists( form, "shooterid" )>
														<cfset n.shooterid = form.shooterid />
													<cfelse>
														<cfset n.shooterid = 0 />
													</cfif>
													
													<cfquery name="creategamenotification">
														<!--- // add game to the notification service queue --->											
														insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)														  													   
															values(
																	<cfqueryparam value="#n.vsid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#n.gameid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#n.notificationtype#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#n.notificationtext#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#n.notificationdate#" cfsqltype="cf_sql_timestamp" />,
																	<cfqueryparam value="#n.notificationstatus#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#n.shooterid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
																	<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
																	);
													</cfquery>
													
													<!--- // redirect to the notification page --->
													<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#&scope=gn1" addtoken="no">
													
													
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
									
									
									
									
										<form class="form-horizontal" name="gamenotifications" method="post" action="">
											<fieldset>
												<div class="form-group">
													<div class="col-md-2">
														<label class="control-label" for="notificationtype">Type</label>
													</div>
													<div class="col-md-8">
														<select name="notificationtype" id="notificationtype" class="form-control">
															<option value="">Select Type</option>
															<option value="Game Notification">Game Notification</option>
															<option value="Shooter Notification">Shooter Notification</option>
															<option value="Game Field Change">Game Field Change</option>
															<option value="Game Rescheduled">Game Rescheduled</option>
															<option value="Game Cancelled">Game Cancelled</option>
															<option value="Game Postponed">Game Postponed</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<div class="col-md-2">
														<label class="control-label" for="message">Message</label>
													</div>
													<div class="col-md-8">
														<input type="text" name="message" id="message" class="form-control" maxlength="150" value="Game ID: #versus.vsid# - ">														
													</div>
												</div>
												
												<cfif gameshooters.recordcount gt 0>												
													<div class="form-group">
														<div class="col-md-2">
															<label class="control-label" for="shooters">Shooters</label>
														</div>
														<div class="col-md-8">
															<input type="checkbox" style="padding:4px;" id="shooterid" name="shooterid" value="#gameshooters.shooterid#" checked>
															#gameshooters.shooterfirstname# #gameshooters.shooterlastname#
														</div>
													</div>												
												<cfelse>
													<div class="form-group">
														<div class="col-md-2">
															<label class="sr-only">Notice:</label>
														</div>
														<div class="col-md-8">
															<span class="label label-plain"><small><i class="fa fa-info-circle"></i> No shooters will be notified because there are no shooters assigned to this game.</small></span>
														</div>
													</div>												
												</cfif>										
												
												
												<div class="form-group">
													<div class="col-md-offset-2 col-md-6">												
														<button type="submit" name="sendGameNotification" class="btn btn-sm btn-primary"><i class="fa fa-envelope"></i> Create Notification</button>
														<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-sm btn-success"><i class="fa fa-times-circle"></i> Cancel</a>													
													</div>
												</div>
											</fieldset>
										</form>									
									</div>
								</div>
							</div>
						</cfoutput>


			