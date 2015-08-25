




					<div class="col-md-6">
						<cfinclude template="game-team-list-view.cfm">					
					</div>
					
					<div class="col-md-6">
						
						<cfif structkeyexists( url, "scope" )>
							<cfif trim( url.scope ) eq "gs1">
								<div class="alert alert-success alert-dismissable" style="margin-bottom:10px;">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
									<p class="small"><i class="fa fa-info-circle"></i> Game Saved</p>
								</div>
							</cfif>
						</cfif>
						
						
						<cfif not structkeyexists( url, "id" )>
							<div class="alert alert-info">
								<p class="small"><i class="fa fa-info-circle"></i> No game selected...</p>
							</div>
						<cfelse>
							<cfif structkeyexists( url, "id" )>
								<cfif isnumeric( url.id )>									
									<cfinvoke component="apis.com.admin.gameadminservice" method="getgamedetail" returnvariable="gamedetail">
										<cfinvokeargument name="id" value="#url.id#">
									</cfinvoke>
									
									<cfif gamedetail.recordcount eq 1>
										<cfoutput>
											
											
											<div class="well" style="padding:10px;">
												<div class="text-center">
													<p>Game: #gamedetail.gameid#</p>
													<p>#gamedetail.awayteam# <i>vs.</i> <strong>#gamedetail.hometeam#</strong></p>
													<p><strong>#gamedetail.teamlevelname#</strong></p>
												</div>
											</div>								
										
													<!--- // begin form processing --->
													<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "savegameRecord" )>
														
														<cfset form.validate_require = "gamedate|The game date is required to edit this game record.;gametime|The game time is required to edit this game record.;gamestatus|The game status is required to edit his game record." />
														
														<cfscript>
															objValidation = createobject( "component","apis.udfs.validation" ).init();
															objValidation.setFields( form );
															objValidation.validate();
														</cfscript>

														<cfif objValidation.getErrorCount() is 0>							
															
															<!--- define our form structure and set form values --->
															<cfset g = structnew() />
															<cfset g.gameid = form.gameid />
															<cfset g.gamedate = form.gamedate />
															<cfset g.gametime = form.gametime />
															<cfset g.gamestatus = trim( form.gamestatus ) />
															<cfset g.gameoutcome = trim( form.gameoutcome ) />
															
															<cfif trim( form.gameoutcome ) eq "final">															
																<cfset g.gamewinnerid = form.gamewinner />
															</cfif>
															
																<cfquery name="savegamerecord">
																	update games
																	   set gamedate = <cfqueryparam value="#g.gamedate# #g.gametime#" cfsqltype="cf_sql_timestamp" />,
																	       gamestart = <cfqueryparam value="#g.gamedate# #g.gametime#" cfsqltype="cf_sql_timestamp" />,
																		   gamestatus = <cfqueryparam value="#g.gamestatus#" cfsqltype="cf_sql_varchar" />,
																		   gameoutcome = <cfqueryparam value="#g.gameoutcome#" cfsqltype="cf_sql_varchar" />
																		   <cfif trim( g.gameoutcome ) eq "final">
																		   ,
																		   gamewinner = <cfqueryparam value="#g.gamewinnerid#" cfsqltype="cf_sql_integer" >
																		   </cfif>
																	 where gameid = <cfqueryparam value="#g.gameid#" cfsqltype="cf_sql_integer" />														
																</cfquery>

																	<!--- // record the activity --->
																	<cfquery name="activitylog">
																		insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																		 values(
																				<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																				<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																				<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																				<cfqueryparam value="updated the game schedule for Game: #g.gameid#" cfsqltype="cf_sql_varchar" />																
																				);
																	</cfquery>
																
																<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#&scope=gs1" addtoken="no">										
												
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
													
													<cfif structkeyexists( form, "deleteGameRecord" ) and structkeyexists( form, "game_id" )>													
														
														<cfset gameid = form.game_id />														
														
															<cftry>
																<!--- // remove any statuses for the selected game --->
																<cfquery name="deleteGameStatus">
																	delete from gamestatus
																		  where gameid = <cfqueryparam value="#gameid#" cfsqltype="cf_sql_integer" />
																</cfquery>
																
																<!--- // get some game detail for the activity log --->
																<cfquery name="getgame">
																	select gameid, gamedate, t1.teamlevelid, tl.teamlevelname
																	  from games g, teams t1, teamlevels tl
																	 where g.hometeamid = t1.teamid
																	   and t1.teamlevelid = tl.teamlevelid
																	   and g.gameid = <cfqueryparam value="#gameid#" cfsqltype="cf_sql_integer" />
																</cfquery>
																
																<!--- // kill the game record --->
																<cfquery name="deleteGameRecord">
																	delete from games
																		  where gameid = <cfqueryparam value="#gameid#" cfsqltype="cf_sql_integer" />
																</cfquery>
																
																	<!--- // record the activity --->
																	<cfquery name="activitylog">
																		insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																		 values(
																				<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																				<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																				<cfqueryparam value="Delete Record" cfsqltype="cf_sql_varchar" />,
																				<cfqueryparam value="deleted #getgame.teamlevelname# game schedule Game: #gameid# on #dateformat( getgame.gamedate, "mm-dd-yyyy" )#." cfsqltype="cf_sql_varchar" />																
																				);
																	</cfquery>
															
																<!--- // if the database records were deleted without error, redirect --->
																<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&scope=game" addtoken="no">
																
																
																<cfcatch type="database"> 
																	<div class="alert alert-danger">
																		<h5>You've Thrown a <b>Database Error</b></h5> 																	
																			<!--- and the diagnostic message from the railo server ---> 
																			<p>#cfcatch.message#</p> 
																			<p>Caught an exception, type = #cfcatch.type# </p> 
																			<p>The contents of the tag stack are:</p> 
																			<cfloop from="1" to="#arraylen( cfcatch.tagcontext )#" index="i"> 
																				<cfset sCurrent = #cfcatch.tagcontext[i]#> 
																				<br>#i# #sCurrent["ID"]#  
																					(#sCurrent["LINE"]#,#sCurrent["COLUMN"]#)  
																					#sCurrent["TEMPLATE"]# 
																			</cfloop> 
																	</div>	
																</cfcatch>														
															
															</cftry>
													
													</cfif>
													
													
													
													
													
													
													
													<!--- // end form processing --->
										
										
										
										
										<cfif not structkeyexists( url, "delete.game" )>
										
										
											<form class="form-horizontal" name="savegame" method="post" action="">
												<fieldset>
													<div class="form-group" id="data_1">
														<label class="col-md-4 control-label">Game Date</label>
														<div class="col-md-6">
															<div class="input-group date">
																<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																	<input type="text" class="form-control" name="gamedate" placeholder="Game Date" value="#dateformat( gamedetail.gamedate, "mm-dd-yyyy" )#" />													
															</div>
														</div>
													</div>
													<div class="form-group" data-autoclose="true">
														<label class="col-md-4 control-label">Game Time</label>
														<div class="col-md-6">
															<div class="input-group clockpicker" data-autoclose="true">															
																<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
																<input type="text" class="form-control" name="gametime" placeholder="Select Game Time" value="#timeformat( gamedetail.gamestart, "hh:mm" )#" />
															</div>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-4 control-label">Game Status</label>
														<div class="col-md-6">
															<select class="form-control m-b" name="gamestatus">
																<option value="">Game Status</option>															
																	<option value="Scheduled"<cfif trim( gamedetail.gamestatus ) eq "scheduled">selected</cfif>>Scheduled</option>
																	<option value="In Progress"<cfif trim( gamedetail.gamestatus ) eq "In Progress">selected</cfif>>In Progress</option>
																	<option value="Completed"<cfif trim( gamedetail.gamestatus ) eq "completed">selected</cfif>>Completed</option>
																	<option value="Cancelled"<cfif trim( gamedetail.gamestatus ) eq "cancelled">selected</cfif>>Cancelled</option>
																	<option value="Deferred"<cfif trim( gamedetail.gamestatus ) eq "deferred">selected</cfif>>Deferred</option>
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-4 control-label">Game Outcome</label>
														<div class="col-md-6">
															<select class="form-control m-b" name="gameoutcome">
																<option value="">Game Outcome</option>															
																<option value="Final"<cfif trim( gamedetail.gameoutcome ) eq "final">selected</cfif>>Final</option>
																<option value="Postponed"<cfif trim( gamedetail.gameoutcome ) eq "postponed">selected</cfif>>Postponed</option>
																<option value="Rescheduled"<cfif trim( gamedetail.gameoutcome ) eq "rescheduled">selected</cfif>>Rescheduled</option>
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-4 control-label">Game Winner</label>
														<div class="col-md-6">
															<select class="form-control m-b" name="gamewinner">
																<option value="">Game Winner</option>															
																<option value="#gamedetail.hometeam#"<cfif trim( gamedetail.gamewinner ) eq gamedetail.hometeamid>selected</cfif>>#gamedetail.hometeam#</option>
																<option value="#gamedetail.awayteam#"<cfif trim( gamedetail.gamewinner ) eq gamedetail.awayteamid>selected</cfif>>#gamedetail.awayteam#</option>
															</select>
														</div>
													</div>											
													<div class="hr-line-dashed" style="margin-top:15px;"></div>
														<div class="form-group">
															<div class="col-md-offset-4 col-md-8">
																<button class="btn btn-primary btn-sm" type="submit" name="saveGameRecord"><i class="fa fa-save"></i> Save Game Details</button>
																<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#&id=#url.id#&delete.game=true" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i> Delete This Game</a>																		
																<input type="hidden" name="gameid" value="#gamedetail.gameid#" />
															</div>
														</div>
													</div>
												</fieldset>										
											</form>
											
										<cfelseif structkeyexists( url, "delete.game" )>
										
											<form name="delete-division-game" method="post" class="form-horizontal" action="">
												<div class="alert alert-warning">
													<h4><strong>Delete Game?</strong></h4>
													<p style="margin-bottom: 15px;">This action can not be un-done once deleted.  Are you sure you want to delete Game ID: #gamedetail.gameid#?</p>													
													<div class="form-group">
														<button style="margin-left:15px;" class="btn btn-danger btn-sm" type="submit" name="deleteGameRecord"><i class="fa fa-trash"></i> Delete Game</button>
															<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#&id=#url.id#" class="btn btn-sm btn-default"><i class="fa fa-arrow-circle-left"></i> Cancel Delete</a>																		
															<input type="hidden" name="game_id" value="#gamedetail.gameid#" />
													</div>
												</div>
											</form>

										</cfif>
											
										</cfoutput>
									<cfelse>
										<div class="alert alert-danger">
											<p class="small"><i class="fa fa-warning"></i> <a href="">System Error</a>.  The selected game was not found.</p>
										</div>
									</cfif>								
									
								<cfelse>
									<div class="alert alert-danger">
										<p class="small"><i class="fa fa-warning"></i> Unexpected game ID format...  Operation aborted.</p>
									</div>
								</cfif>						
							</cfif>
						</cfif>
					</div>