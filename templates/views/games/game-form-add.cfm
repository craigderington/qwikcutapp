
							

							


							<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "creategameschedule" )>
							
								<cfset form.validate_require = "conferencetype|The conference type is required.;conferenceid|The conference is required to create games.;hometeam|You did not select a home team.;awayteam|You did not select an away team.;teamlevels|You did not select any team levels.;gamedate|You did not select the game date.;gametime|You did not select the game time." />
										
									<cfscript>
										objValidation = createobject( "component","apis.udfs.validation" ).init();
										objValidation.setFields( form );
										objValidation.validate();
									</cfscript>

									<cfif objValidation.getErrorCount() is 0>							
										
										<!--- define our form structure and set form values --->
										<cfset g = structnew() />
										<cfset g.conferencetype = trim( form.conferencetype ) />
										<cfset g.conferenceid = form.conferenceid />
										<cfset g.hometeam = trim( form.hometeam ) />
										<cfset g.awayteam = trim( form.awayteam ) />
										<cfset g.teamlevels = form.teamlevels />
										<cfset g.gamedate = form.gamedate />
										<cfset g.gametime = form.gametime />
										
										<!--- // get the current game season --->
										<cfinvoke component="apis.com.admin.gameadminservice" method="getgameseasons" returnvariable="gameseasons">
											<cfinvokeargument name="gameseason" value="#year( now() )#">
										</cfinvoke>

										<cfset g.gameseasonid = gameseasons.gameseasonid />
										
										<!--- // insert into the versus table to get pkid --->
										<cfquery name="addversus">
											insert into versus(hometeam, awayteam, gamedate, gametime, fieldid)
												values(
													   <cfqueryparam value="#g.hometeam#" cfsqltype="cf_sql_varchar" />,
													   <cfqueryparam value="#g.awayteam#" cfsqltype="cf_sql_varchar" />,
													   <cfqueryparam value="#g.gamedate#" cfsqltype="cf_sql_date" />,
													   <cfqueryparam value="#g.gametime#" cfsqltype="cf_sql_time" />,
													   <cfqueryparam value="1" cfsqltype="cf_sql_varchar" />
													   ); select @@identity as newvsid
										</cfquery>
										
										<!--- // start our session variable for the admin game manager --->
										<cfset session.vsid = addversus.newvsid /> 
										
										<!--- // next, get all of our home teams and away teams by teamlevel --->
										
										<!--- get all of our home team teamlevelids --->																				
										<cfquery name="gethometeams">
											select teamid, teamname, teamlevelid, homefieldid
											  from teams
											 where teamorgname = <cfqueryparam value="#g.hometeam#" cfsqltype="cf_sql_varchar" />
											 order by teamid asc
										</cfquery>									
											
										<!--- get all of our away team teamlevelids --->
										<cfquery name="getawayteams">
											select teamid, teamname, teamlevelid
											  from teams
										     where teamorgname = <cfqueryparam value="#g.awayteam#" cfsqltype="cf_sql_varchar" />											
											order by teamlevelid asc
										</cfquery>											
										
										<!--- // outer loop ( home teams )--->
										<cfloop query="gethometeams">
											
											<!--- // inner loop ( away teams )--->
											<cfloop query="getawayteams">
												
												<!--- // due to loop bug in CF, the outer loop has to be referenced by the current row, assign values --->
												<cfset g.hometeamid = gethometeams["teamid"][gethometeams.currentRow] />
												<cfset g.homefieldid = gethometeams["homefieldid"][gethometeams.currentRow] />
												<cfset g.awayteamid = getawayteams["teamid"][getawayteams.currentRow] />
												
												<!--- // make sure we have a way to compare all of the team levels so it's level vs level --->
												<cfif gethometeams["teamlevelid"][gethometeams.currentRow] eq getawayteams["teamlevelid"][getawayteams.currentRow]>
												
													<!--- // create the individual games for each of the selected team levels --->
													<cfquery name="addgameschedules">
														insert into games(confid, fieldid, hometeamid, awayteamid, gamedate, gamestart, gamestatus, gameoutcome, gamewinner, gameseasonid, vsid)
															values(
																	<cfqueryparam value="#g.conferenceid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#g.hometeamid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#g.awayteamid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#g.gamedate#" cfsqltype="cf_sql_date" />,
																	<cfqueryparam value="#g.gametime#" cfsqltype="cf_sql_time" />,
																	<cfqueryparam value="Scheduled" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="Not Started" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="0" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#g.gameseasonid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#addversus.newvsid#" cfsqltype="cf_sql_integer" />
																	);
													</cfquery>					
													
													<!--- // increase the game time counter to allow for 90 minutes between games --->
													<cfset g.gametime = dateadd( "n", 90, g.gametime ) />
												
												<cfelse>
												
													<div class="alert alert-danger alert-dismissable">
														<h4><i class="fa fa-warning"></i> <strong>Team Level Mismatch</strong></h4>														
													</div>
												
												</cfif>										
											
											</cfloop>
											
										</cfloop>	
											
										
											<!--- // record the activity --->
											<cfquery name="activitylog">
												insert into activity(userid, activitydate, activitytype, activitytext)														  													   
													values(
															<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
															<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="added the game schedule for #g.hometeam# vs. #g.awayteam#." cfsqltype="cf_sql_varchar" />																
															);
											</cfquery>
												
											
											<!--- // redirect to games detail form --->
											<cflocation url="#application.root##url.event#&fuseaction=games.mgr" addtoken="no">				
											
										
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















								
								<!--- // form to add games by team org name --->
								<cfoutput>
									<form name="creategames" class="form-horizontal" method="post" action="">										
										<div class="row">										
											<div class="col-sm-2">
												<div class="form-group"><label class="control-label" for="conferencetype">Game Type</label>
													<select name="conferencetype" class="form-control" multiple="true" onchange="javascript:this.form.submit();">
														<option value="YF"<cfif structkeyexists( form, "conferencetype" ) and trim( form.conferencetype ) eq "YF">selected</cfif>>Youth Football</option>
														<option value="HS"<cfif structkeyexists( form, "conferencetype" ) and trim( form.conferencetype ) eq "HS">selected</cfif>>High School Football</option>																								
													</select>
												</div>
											</div>
										
										
											<cfif structkeyexists( form, "conferencetype" )>
												<cfinvoke component="apis.com.admin.gameadminservice" method="getconferences" returnvariable="conferencelist">												
													<cfinvokeargument name="conferencetype" value="#trim( form.conferencetype )#">
												</cfinvoke>
												
												<div class="col-sm-2">
													<div class="form-group"><label class="control-label" for="conferenceid">Conference</label>
														<select name="conferenceid" class="form-control" size="4" onchange="javascript:this.form.submit();">
															<cfoutput query="conferencelist">
																<option value="#confid#"<cfif structkeyexists( form, "conferenceid" )><cfif form.conferenceid eq conferencelist.confid>selected</cfif></cfif>>#trim( confname )#</option>
															</cfoutput>
														</select>
													</div>
												</div>
											
											</cfif>
										
											<cfif structkeyexists( form, "conferenceid" )>
												<cfinvoke component="apis.com.admin.gameadminservice" method="gethometeam" returnvariable="hometeam">
													<cfinvokeargument name="conferenceid" value="#form.conferenceid#">
												</cfinvoke>										
											
											
												<div class="col-sm-2">
													<div class="form-group"><label class="control-label" for="hometeam">Home Team</label>
														<select name="hometeam" class="form-control" size="4" onchange="javascript:this.form.submit();">
															<cfoutput query="hometeam">
																<option value="#teamorgname#"<cfif structkeyexists( form, "hometeam" )><cfif trim( form.hometeam ) eq trim( hometeam.teamorgname )>selected</cfif></cfif>>#teamorgname#</option>
															</cfoutput>
														</select>
													</div>
												</div>
											
											</cfif>
										
											<cfif structkeyexists( form, "hometeam" )>
												<cfinvoke component="apis.com.admin.gameadminservice" method="getawayteam" returnvariable="awayteam">
													<cfinvokeargument name="conferenceid" value="#form.conferenceid#">
													<cfinvokeargument name="teamorgname" value="#trim( form.hometeam )#">
												</cfinvoke>
												
												<cfinvoke component="apis.com.admin.gameadminservice" method="getteamlevels" returnvariable="teamlevels">												
													<cfinvokeargument name="conferencetype" value="#form.conferencetype#">
												</cfinvoke>									
											
												<div class="col-sm-2">
													<div class="form-group"><label class="control-label" for="awayteam">Away Team</label>
														<select name="awayteam" class="form-control" size="4">
															<cfoutput query="awayteam">
																<option value="#teamorgname#">#trim( teamorgname )#</option>
															</cfoutput>
														</select>
													</div>
												</div>
												
												<div class="col-sm-2">
													<div class="form-group"><label class="control-label" for="teamlevels">Team Levels</label>
														<select name="teamlevels" class="form-control" multiple="true">
															<cfoutput query="teamlevels">
																<option value="#teamlevelid#">#teamlevelname#</option>
															</cfoutput>
														</select>
														<span class="help-block">Ctr-Click to Select Multiple</span>
													</div>
												</div>
												
												<div class="col-sm-2">
													<div class="form-group" id="data_1"><label class="control-label" for="gamedate">Game Date</label>
														<div class="input-group date">
															<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																<input type="text" class="form-control" name="gamedate" placeholder="Game Date" />													
														</div>
														<div class="input-group clockpicker" data-autoclose="true">															
															<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
															<input type="text" class="form-control" name="gametime" placeholder="Select Game Time">
														</div>
													</div>								
												</div>												
												
											</cfif>
										</div>
										
										
										<cfif structkeyexists( form, "hometeam" )>
											<div class="row">																					
												<div class="col-sm-4">
													<div style="margin-top:5px;">
														<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-sm btn-success"><i class="fa fa-refresh"></i> Reset</a>
														<button type="submit" name="creategameschedule" class="btn btn-sm btn-primary"><i class="fa fa-play-circle"></i> Create Games</button>
													</div>
												</div>				
											</div>
										</cfif>
									</form>
								</cfoutput>