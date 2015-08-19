


				<cfif structkeyexists( url, "sgid" )>
					<cfif isnumeric(url.sgid)>
						<cfset sgid = url.sgid />
					<cfelse>
						<cfset sgid = 0 />
					</cfif>
					<cfinvoke component="apis.com.admin.gameadminservice" method="getgamedetail" returnvariable="gamedetail">
						<cfinvokeargument name="id" value="#sgid#">				
					</cfinvoke>
				</cfif>
					
						
					



				<cfoutput>
					<div class="row">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-edit"></i> Record Game Status</h5>
								<span class="pull-right">
									<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&gamestatus=#url.gamestatus#" class="btn btn-xs btn-primary"><i class="fa fa-times-circle"></i> Cancel</a>
								</span>
							</div>
							<div class="ibox-content ibox-heading text-navy text-center">
								#gamedetail.awayteam# <i>vs.</i> <strong>#gamedetail.hometeam#</strong>
								<br />#gamedetail.teamlevelname#
							</div>
							<div class="ibox-content">
								
								<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "save-game-status" )>
									<cfset form.validate_require = "gameevent|The game event is required to save a game status.;awayteam_score|The away team score is required to save.;hometeam_score|The home team score is required to save this game status." />
									<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset today = now() />
											
											<cfset gs = structnew() />
											<cfset gs.hometeamscore = numberformat( form.hometeam_score, "99" ) />
											<cfset gs.awayteamscore = numberformat( form.awayteam_score, "99" ) />
											<cfset gs.vsid = session.vsid />
											<cfset gs.shooterid = session.shooterid />
											<cfset gs.gameid = numberformat( url.sgid, "99" ) />
											
											<cfif trim( form.gameevent ) neq "FINAL">
												<cfset gs.gamestatus = "In Progress" />
											<cfelse>
												<cfset gs.gamestatus = "FINAL" />
											</cfif>
											
											<cfset gs.gametime = timeformat( today, "hh:mm:ss" ) />
											<cfset gs.gameevent = trim( form.gameevent ) />
											<cfset gs.gamenotes = trim( form.gamenotes ) />
											<cfset gs.gamelastupdate = today />
											
											<cfset gs.notificationstatus = "Queued" />
											<cfset gs.notificationtext = "Shooter updated game status." />
											<cfset gs.notificationtype = "Game Notification" />

												<!--- // save the game status data --->
												<cfquery name="savegamestatus">
													insert into gamestatus(gameid, gamestatus, hometeamscore, awayteamscore, gametime, gamequarter, gamelastupdate, gamelastupdateby, gamenotes)
													 values(
															<cfqueryparam value="#gs.gameid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#gs.gamestatus#" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#gs.hometeamscore#" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#gs.awayteamscore#" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#gs.gameevent#" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#gs.gamelastupdate#" cfsqltype="cf_sql_timestamp" />,
															<cfqueryparam value="#gs.shooterid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#gs.gamenotes#" cfsqltype="cf_sql_varchar" />
															);
												</cfquery>
												
												<!--- // add game check-in to the notification service queue --->
												<cfquery name="creategamenotification">															
													insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)														  													   
														values(
																<cfqueryparam value="#gs.vsid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#gs.gameid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#gs.notificationtype#" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="#gs.notificationtext#" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="#gs.gamelastupdate#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="#gs.notificationstatus#" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="#gs.shooterid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
																<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
															  );
												</cfquery>

												<!--- // record the activity --->
												<cfquery name="activitylog">
													insert into activity(userid, activitydate, activitytype, activitytext)
														values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="recorded a game status for Game ID: #gs.gameid#." cfsqltype="cf_sql_varchar" />																
															);
												</cfquery>

												<!--- // add a game notification --->
												
												<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&gamestatus=#url.gamestatus#&sgid=#url.sgid#" addtoken="no">				
											
								
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








































								<form class="form-horizontal" name="save-game-status" method="post" action="">
									<fieldset>
										<div class="col-md-4">
											<div class="form-group">
												<label class="control-label" for="gameevent">
													End of Quarter
												</label>												
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<select name="gameevent" class="form-control">
													<option value="">Select Game Event</option>
													<option value="1Q">First Quarter (1Q)</option>
													<option value="2Q">Second Quarter (2Q)</option>
													<option value="3Q">Third Quarter (3Q)</option>
													<option value="4Q">Fourth Quarter(4Q)</option>
													<option value="Final">FINAL</option>
												</select>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group">
												<label class="control-label" for="awayteam">
													#gamedetail.awayteam#
												</label>												
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<input type="text" class="form-control" name="awayteam_score" placeholder="Away Team Score"/>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group">
												<label class="control-label" for="awayteam">
													#gamedetail.hometeam#
												</label>												
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<input type="text" class="form-control" name="hometeam_score" placeholder="Home Team Score" />
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group">
												<label class="control-label" for="awayteam">
													Notes
												</label>												
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<textarea name="gamenotes" class="form-control" rows="4"></textarea>
											</div>
										</div>
										<div class="hr-line-dashed" style-="margin-top:25px;"></div>
										<div class="form-group">
											<div class="col-md-offset-4 col-md-6">
												<button class="btn btn-sm btn-primary" name="save-game-status" id="save-game-status"><i class="fa fa-times-circle"></i> Save Game Status</button>
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&gamestatus=#url.gamestatus#" class="btn btn-sm btn-default"><i class="fa fa-remove"></i> Cancel</a>
											</div>
										</div>
									</fieldset>
								</form>


								<cfinvoke component="apis.com.user.usershooterservice" method="getgamestatus" returnvariable="gamestatus">
									<cfinvokeargument name="sgid" value="#url.sgid#">								
								</cfinvoke>
									
								
								<cfif gamestatus.recordcount gt 0>
									<div class="well" style="margin-top:20px;">										
										<i class="fa fa-flag"></i> Current Game Status
										<ul>
											<cfloop query="gamestatus">
												<li>Game #gamestatus# |  Home: #hometeamscore# |  Away: #awayteamscore# | Quarter: #gamequarter#</li>	
											</cfloop>
										</ul>
									</div>
								</cfif>











							</div>
						</div>
					</div>
				</cfoutput>