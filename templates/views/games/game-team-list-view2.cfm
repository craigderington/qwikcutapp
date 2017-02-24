
						
						
						
						<cfif structkeyexists( session, "checkedinstatus" ) and structkeyexists( url, "gamecheckout" )>
							<cfif trim( url.gamecheckout ) eq "true">
								<cfset gc = structnew() />
								<cfset gc.vsid = session.vsid />
								<cfset gc.gamestatus = "Completed" />
								<cfset today = now() />
									
									<cfquery name="closeversus">
										update versus
										   set gamestatus = <cfqueryparam value="#gc.gamestatus#" cfsqltype="cf_sql_varchar" />
										 where vsid = <cfqueryparam value="#gc.vsid#" cfsqltype="cf_sql_integer" />
									</cfquery>
									
									<cfquery name="closegames">
										update games
										   set gamestatus = <cfqueryparam value="#gc.gamestatus#" cfsqltype="cf_sql_varchar" />
										 where vsid = <cfqueryparam value="#gc.vsid#" cfsqltype="cf_sql_integer" />
									</cfquery>
									
									<cfquery name="updateassignmentstatus">
										update shooterassignments
										   set shooterassignstatus = <cfqueryparam value="Completed" cfsqltype="cf_sql_varchar" />,
										       shooterassignlastupdated = <cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />
										 where vsid = <cfqueryparam value="#gc.vsid#" cfsqltype="cf_sql_integer" />
									</cfquery>
									
											<!--- // record the activity --->
											<cfquery name="activitylog">
												insert into activity(userid, activitydate, activitytype, activitytext)														  													   
													values(
															<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />,
															<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="closed out all games and checked out Game ID: #gc.vsid#." cfsqltype="cf_sql_varchar" />																
															);
											</cfquery>									
											
											
											<!--- // add game to the notification service queue --->
											<cfquery name="notificationservicequeue">
												insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)														  													   
													values(
															<cfqueryparam value="#gc.vsid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="0" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="Game Completed" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="Game Completed by Shooter" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />,
															<cfqueryparam value="Queued" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="0" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
															<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
															);
											</cfquery>
									
									<cfset temp_r = structdelete( session, "vsid" ) />
									<cfset temp_c = structdelete( session, "checkedinstatus" ) />
									<cflocation url="#application.root#shooter.games" addtoken="no">
							</cfif>					
						</cfif>



						
						



						<cfinvoke component="apis.com.user.usershooterservice" method="getGameCheckout" returnvariable="gamecheckout">


						<cfoutput>
							<div class="row">																
								
									
									<cfif isuserinrole( "admin" )>
										<cfif structkeyexists( url, "manage" )>
											<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=delete.games" class="btn btn-xs btn-danger" style="margin-right:3px;"><i class="fa fa-trash"></i> Delete All Games</a><a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-xs btn-success"><i class="fa fa-check-circle-o"></i> Finished Rescheduling</a>
										<cfelse>
											<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=schedule" class="btn btn-xs btn-primary"><i class="fa fa-refresh"></i> Reschedule</a>
										</cfif>
									<cfelseif isuserinrole( "shooter" )>
										<cfif structkeyexists( session, "checkedinstatus" )>
											<cfif structkeyexists( url, "gamestatus" )>
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-md btn-success btn-block btn-outline"><i class="fa fa-times-circle"></i> Close Game Status</a>
											<cfelse>																		
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&gamestatus=update" class="btn btn-md btn-primary btn-outline btn-block"><i class="fa fa-refresh"></i> Record Game Status</a>
											</cfif>
												
											<cfif gamecheckout.totalgamestatus gte games.recordcount>
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&gamecheckout=true" class="btn btn-md btn-danger btn-block btn-outline" onclick="return confirm('This will close out all games for this event.  Do you wish to continue?');"><i class="fa fa-flag"></i> All Games Completed</a>
											</cfif>
												
										</cfif>
									</cfif>
										
									
								
								
								
									<cfif structkeyexists( url, "manage" ) and isuserinrole( "admin" )>
										<small>Select an individual game to edit the game date or game time.</small>
									<cfelseif structkeyexists( url, "gamestatus" ) and isuserinrole( "shooter" )>
										<cfif structkeyexists( session, "checkedinstatus" )>
											<small>Select an individual game to update the game status.</small>
										</cfif>									
									<cfelse>
										<small>#games.recordcount# game<cfif ( games.recordcount neq 1 )>s</cfif> scheduled</small>									
									</cfif>
								
								
								
									
									
									
									
									<div class="ibox" style="margin-top:10px;">										
										<div class="ibox-title">
											<h5><i class="fa fa-play-circle"></i> Team Games  <cfif ( games.recordcount gt 0 )>(#games.recordcount#)</cfif></h5>
										</div>
										<div class="ibox-content">
											<cfloop query="games">
												<div class="feed-element">
													<div>
														<p><small class="text-navy">#dateformat( gamedate, "mm-dd-yyyy" )#</small></P>													
														<p><strong>#teamlevelname#</strong></p>
														<p><small>#awayteam# <i>vs.</i> #hometeam#</small>												
														<p><small class="text-muted">#gamestatus#</small>
															
														<p>	<small class="pull-right">
																<cfif structkeyexists( session, "checkedinstatus" ) and structkeyexists( session, "shooterid" )>
																	<cfif structkeyexists( url, "gamestatus" )>					
																		<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=#url.fuseaction#&gamestatus=update&sgid=#gameid#"><i class="fa fa-play-circle fa-2x"></i></a>
																	</cfif>													
																</cfif>
															</small>
														
														</p>

														<p><small>#timeformat( gamestart, "hh:mm tt" )#</small><p>
													</div>
												</div>										
											</cfloop>
										</div>
									</div>
										
							</div>	
						</cfoutput>