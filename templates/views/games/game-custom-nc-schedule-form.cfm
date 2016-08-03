







						<!--- // create the game from the form data --->
						<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "createCustomGame" )>
							<cfset form.validate_require = "conferenceA|The conference is required to create this game.;conferenceB|Please select the away team conference.;divisionid|Please select a team level.;fieldid|Please select a team level.;hometeam|Please select the home team.;awayteam|Please select the away team.;gamedate|Please select a game date.;gametime|Please select the game time." />
							<cfset form.validate_dateus = "gamedate|Sorry, the game date selected is in the incorrect date/time format.  Please try again." />
							<cfset form.validate_numeric = "conferenceA|The conference ID must be a number.;conferenceB|The away team conference must be a number.;divisionid|The Team Division must be a number.;fieldid|The selected field must be a number." />

							<cfscript>
								objValidation = createobject( "component","apis.udfs.validation" ).init();
								objValidation.setFields( form );
								objValidation.validate();
							</cfscript>

							<cfif objValidation.getErrorCount() is 0>

								<cfset g = structnew() />
								<cfset g.conferenceA = form.conferenceA />
								<cfset g.conferenceB = form.conferenceB />
								<cfset g.divisionid = form.divisionid />
								<cfset g.fieldid = form.fieldid />
								<cfset g.hometeam = trim( form.hometeam ) />
								<cfset g.awayteam = trim( form.awayteam ) />
								<cfset g.gamedate = form.gamedate />
								<cfset g.gametime = form.gametime />

								<!--- // use the division and home and away teams to get the necessary ID's --->
								<cfquery name="gethometeamid">
									select t1.teamid
									  from teams t1
									 where t1.confid = <cfqueryparam value="#g.conferenceA#" cfsqltype="cf_sql_integer" />
									   and t1.teamlevelid = <cfqueryparam value="#g.divisionid#" cfsqltype="cf_sql_integer" />
									   and t1.teamorgname = <cfqueryparam value="#trim( g.hometeam )#" cfsqltype="cf_sql_varchar" />
								</cfquery>

								<cfquery name="getawayteamid">
									select t2.teamid
									  from teams t2
									 where t2.confid = <cfqueryparam value="#g.conferenceB#" cfsqltype="cf_sql_integer" />
									   and t2.teamlevelid = <cfqueryparam value="#g.divisionid#" cfsqltype="cf_sql_integer" />
									   and t2.teamorgname = <cfqueryparam value="#trim( g.awayteam )#" cfsqltype="cf_sql_varchar" />
								</cfquery>


								<cfif gethometeamid.recordcount eq 1
								    and getawayteamid.recordcount eq 1 >

									<cfquery name="checkforexistinggames">
										select gameid, gamedate
										  from games
										 where (
													( hometeamid = <cfqueryparam value="#gethometeamid.teamid#" cfsqltype="cf_sql_integer" />
													  and gamedate = <cfqueryparam value="#g.gamedate#" cfsqltype="cf_sql_date" />
													)
										          or
													( awayteamid = <cfqueryparam value="#getawayteamid.teamid#" cfsqltype="cf_sql_integer" />
													  and gamedate = <cfqueryparam value="#g.gamedate#" cfsqltype="cf_sql_date" />
													)
												)
									</cfquery>


									<cfif checkforexistinggames.recordcount eq 0>

										<!--- // add versus + game --->
										<cfquery name="addversus">
											insert into versus(hometeam, awayteam, gamedate, gametime, fieldid, gamestatus)
												values(
														<cfqueryparam value="#g.hometeam#" cfsqltype="cf_sql_varchar" />,
														<cfqueryparam value="#g.awayteam#" cfsqltype="cf_sql_varchar" />,
														<cfqueryparam value="#g.gamedate# #g.gametime#" cfsqltype="cf_sql_timestamp" />,
														<cfqueryparam value="#g.gamedate# #g.gametime#" cfsqltype="cf_sql_timestamp" />,
														<cfqueryparam value="#g.fieldid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="Scheduled" cfsqltype="cf_sql_varchar" />
													   ); select @@IDENTITY as newvsid
										</cfquery>

										<cfquery name="getgameseason">
											select gameseasonid
											  from gameseasons
											 where gameseasonactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
										</cfquery>

										<cfquery name="addgame">
											insert into games(confid, fieldid, hometeamid, awayteamid, gamedate, gamestart, gamestatus, gameseasonid, vsid, customgame)
												values(
														<cfqueryparam value="#g.conferenceA#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="#g.fieldid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="#gethometeamid.teamid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="#getawayteamid.teamid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="#g.gamedate# #g.gametime#" cfsqltype="cf_sql_timestamp" />,
														<cfqueryparam value="#g.gametime#" cfsqltype="cf_sql_time" />,
														<cfqueryparam value="Scheduled" cfsqltype="cf_sql_varchar" />,
														<cfqueryparam value="#getgameseason.gameseasonid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="#addversus.newvsid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="1" cfsqltype="cf_sql_bit" />
													   )
										</cfquery>

											<!--- // record the activity --->
											<cfquery name="activitylog">
												insert into activity(userid, activitydate, activitytype, activitytext)
													values(
															<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
															<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="added the custom game schedule for #g.hometeam# vs. #g.awayteam#." cfsqltype="cf_sql_varchar" />
															);
											</cfquery>


											<!--- // add game to the notification service queue --->
											<cfquery name="notificationservicequeue">
												insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)
													values(
															<cfqueryparam value="#addversus.newvsid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="0" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="Game Scheduled" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="Game Scheduled by Admin" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
															<cfqueryparam value="Queued" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="0" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
															<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
															);
											</cfquery>

										<div class="alert alert-success">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<h5><i class="fa fa-check-circle-o"></i> GAME SCHEDULED!</h5>
											<p>Your custom matchup was successfully created.  Use the list to select your custom game to view game details.</p>
										</div>



									<cfelse>
										<cfoutput>
											<div class="alert alert-info">
												<h5><i class="fa fa-warning"></i> ERROR!</h5>
												<p>Sorry, can not schedule #trim( g.hometeam )# <i>vs.</i> #trim( g.awayteam )# on #dateformat( g.gamedate, "mm-dd-yyyy" )#.  There is a conflict in the game schedule.  One of the selected teams already has a game scheduled for that date.  Please select a new date.</p>
											</div>
										</cfoutput>
									</cfif>


								<cfelse>

									<div class="alert alert-danger">
										<h5><i class="fa fa-warning"></i> ERROR!</h5>
										<p>There was a problem fetching the teams for the selected Division.  There is a mis-match in the team level.  Please try again...</p>
									</div>

								</cfif>


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








						<form name="create-custom-nc-game-schedule" method="post" action="">
							<div class="form-group">
								<label class="col-sm-4 control-label" for="conferencetype">Conference Type</label>
								<div class="col-sm-8">
									<select name="conferencetype" class="form-control m-b" onchange="javascript:this.form.submit();">
										<option value="">Select Conference Type</option>
										<option value="YF"<cfif structkeyexists( form, "conferencetype" ) and trim( form.conferencetype ) eq "YF">selected</cfif>>Youth Football</option>
										<option value="HS"<cfif structkeyexists( form, "conferencetype" ) and trim( form.conferencetype ) eq "HS">selected</cfif>>High School Football</option>
									</select>
								</div>
							</div>

							<cfif structkeyexists( form, "conferencetype" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getconferences" returnvariable="conferencelist">
									<cfinvokeargument name="conferencetype" value="#trim( form.conferencetype )#">
								</cfinvoke>
								<div class="form-group">
									<label class="col-sm-4 control-label" for="conferenceid">Conference A</label>
									<div class="col-sm-8">
										<select name="conferenceA" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="0">Select Conference</option>
											<cfoutput query="conferencelist">
												<option value="#confid#"<cfif structkeyexists( form, "conferenceA" )><cfif form.conferenceA eq conferencelist.confid>selected</cfif></cfif>>#trim( confname )#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>

							<cfif structkeyexists( form, "conferenceA" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getteamlevels" returnvariable="teamlevels">
									<cfinvokeargument name="conferencetype" value="#trim( form.conferencetype )#">
									<cfinvokeargument name="conferenceid" value="#form.conferenceA#">
								</cfinvoke>
								<div class="form-group">
									<label class="col-sm-4 control-label" for="divisionid">Division</label>
									<div class="col-sm-8">
										<select name="divisionid" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="">Select Division</option>
											<cfoutput query="teamlevels">
												<option value="#teamlevelid#"<cfif structkeyexists( form, "divisionid" )><cfif form.divisionid eq teamlevels.teamlevelid>selected</cfif></cfif>>#teamlevelname#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>

							<cfif structkeyexists( form, "divisionid" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="gethometeam" returnvariable="hometeam">
									<cfinvokeargument name="conferenceid" value="#form.conferenceA#">
									<cfinvokeargument name="teamlevelid" value="#form.divisionid#">
								</cfinvoke>
								<div class="form-group">
									<label class="col-sm-4 control-label" for="hometeam">Home Team</label>
									<div class="col-sm-8">
										<select name="hometeam" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="">Select Home Team</option>
											<cfoutput query="hometeam">
												<option value="#trim( teamorgname )#"<cfif structkeyexists( form, "hometeam" )><cfif trim( form.hometeam ) eq trim( hometeam.teamorgname )>selected</cfif></cfif>>#trim( teamorgname )#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>

							<cfif structkeyexists( form, "hometeam" ) and trim( form.hometeam ) neq "">
								<cfinvoke component="apis.com.admin.gameadminservice" method="getnonconferences" returnvariable="nonconferences">
									<cfinvokeargument name="stateid" value="#session.stateid#">
									<cfinvokeargument name="conferenceid" value="#form.conferenceA#">
									<cfinvokeargument name="conferencetype" value="#trim( form.conferencetype )#">
								</cfinvoke>
								<div class="form-group">
									<label class="col-sm-4 control-label" for="awayteam">Conference B</label>
									<div class="col-sm-8">
										<select name="conferenceB" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="">Select Conference B</option>
											<cfoutput query="nonconferences">
												<option value="#confid#"<cfif structkeyexists( form, "conferenceB" )><cfif form.conferenceB eq nonconferences.confid>selected</cfif></cfif>>#trim( confname )#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>

							<cfif structkeyexists( form, "conferenceB" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getnonconferenceawayteam" returnvariable="nonconferenceawayteam">
									<cfinvokeargument name="stateid" value="#session.stateid#">
									<cfinvokeargument name="conferenceid" value="#form.conferenceB#">
								</cfinvoke>
								<div class="form-group">
									<label class="col-sm-4 control-label" for="awayteam">Away Team</label>
									<div class="col-sm-8">
										<select name="awayteam" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="">Select Away Team</option>
											<cfoutput query="nonconferenceawayteam">
												<option value="#trim( teamorgname )#"<cfif structkeyexists( form, "awayteam" )><cfif trim( form.awayteam ) eq trim( nonconferenceawayteam.teamorgname )>selected</cfif></cfif>>#trim( teamorgname )#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>

							<cfif structkeyexists( form, "awayteam" )>
								<cfinvoke component="apis.com.admin.fieldadminservice" method="getfields" returnvariable="fieldlist">
									<cfinvokeargument name="stateid" value="#session.stateid#">
								</cfinvoke>
								<div class="form-group">
									<label class="col-sm-4 control-label" for="fieldid">Game Field</label>
									<div class="col-sm-8">
										<select name="fieldid" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="">Select Game Field</option>
											<cfoutput query="fieldlist">
												<option value="#fieldid#"<cfif structkeyexists( form, "fieldid" )><cfif form.fieldid eq fieldlist.fieldid>selected</cfif></cfif>>#fieldname# Field - #stateabbr#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>

							<cfif structkeyexists( form, "fieldid" )>
								<cfoutput>
									<div class="form-group" id="data_1">
										<label class="col-sm-4 control-label" for="gamedate">Game Date</label>
										<div class="col-sm-7 input-group date">
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											<input type="text" class="form-control m-b" name="gamedate" placeholder="Select Game Date" <cfif structkeyexists( form, "gamedate" )>value="#dateformat( form.gamedate, "mm/dd/yyyy" )#"</cfif> />
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-4 control-label" for="gametime">Game Time</label>
										<div class="col-sm-7 input-group clockpicker" data-autoclose="true">
											<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											<input type="text" class="form-control m-b" name="gametime" placeholder="Select Game Time" <cfif structkeyexists( form, "gametime" )>value="#timeformat( form.gametime, "hh:mm:ss" )#"</cfif>  />
										</div>
									</div>
								</cfoutput>

								<div class="hr-line-dashed"></div>

								<div class="form-group">
									<div class="col-sm-offset-4 col-sm-8">
										<button type="submit" name="createCustomGame" class="btn btn-md btn-primary">Schedule Game</button>
										<a href="" class="btn btn-md btn-success"><i class="fa fa-refresh"></i> Reset</a>
									</div>
								</div>


							</cfif>


						</form>
