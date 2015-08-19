



				<cfif structkeyexists( session, "vsid" )>
					<cfset tempr = structdelete( session, "vsid" ) />
				</cfif>
				
				<cfif structkeyexists( session, "shooterid" )>
					<cfset tempr = structdelete( session, "shooterid" ) />
				</cfif>
				
				<cfinvoke component="apis.com.user.usershooterservice" method="getshootergames" returnvariable="shootergames">
					<cfinvokeargument name="userid" value="#session.userid#" />
				</cfinvoke>
				
				<cfset strShooterGameManager = {} />
				
				<cfif structkeyexists( url, "fuseaction" )>
					<cfif structkeyexists( url, "myid" )>
						<cfif structkeyexists( url, "vsid" ) and structkeyexists( url, "fieldid" )>						
							<cfset shooterid = url.myid />
							<cfset fieldid = url.fieldid />
							<cfset vsid = url.vsid />
							<cfset docheckin = shooterid + fieldid + vsid />							
							<cfif ( trim( url.fuseaction ) eq "game-check-in" ) and ( isnumeric( shooterid ) and isnumeric( fieldid ) and isnumeric( vsid ))>
								<cfinvoke component="apis.com.user.usershooterservice" method="gamecheckin" returnvariable="strShooterGameManager">
									<cfinvokeargument name="shooterid" value="#numberformat( shooterid, "99" )#" />
									<cfinvokeargument name="fieldid" value="#numberformat( fieldid, "99" )#" />
									<cfinvokeargument name="vsid" value="#numberformat( vsid, "99" )#" />
									<cfinvokeargument name="docheckin" value="#numberformat( docheckin, "999999" )#" />
								</cfinvoke>
								<cfif structkeyexists( strShooterGameManager, "shooterid" ) and structkeyexists( strShooterGameManager, "vsid" )>
									<cfif structkeyexists( strShooterGameManager, "checkedinstatus" ) eq true >
										<cfset session.checkedinstatus = true />
										<cfset session.vsid = strShooterGameManager.vsid />
										<cfset session.shooterid = strShooterGameManager.shooterid />
										<cflocation url="#application.root#shooter.game" addtoken="yes">
									<cfelse>
										<div class="row">
											<div class="col-lg-12">
												<div class="alert alert-danger">
													<h5><i class="fa fa-warning fa-2x"></i>  Oops, we were unable to check your shooter profile in to this game.  Please check your user settings.</h5>
												</div>
											</div>
										</div>
									</cfif>
								</cfif>
							<cfelse>
								<cflocation url="#application.root#user.home&accessdenied=1" addtoken="yes">
							</cfif>
						</cfif>
					<cfelseif structkeyexists( url, "saID" )>
						<cfif isnumeric( url.saID )>						
							<cfset saID =  url.saID />
							<cfquery name="resumegameinprogress">
							   select sa.shooterassignmentid, sa.vsid, sa.shooterid
								 from shooterassignments sa
								where sa.shooterassignmentid = <cfqueryparam value="#saID#" cfsqltype="cf_sql_integer" />
							</cfquery>
								<cfif resumegameinprogress.recordcount eq 1>
									<!--- // start game vars --->
									<cfset session.checkedinstatus = true />
									<cfset session.vsid = resumegameinprogress.vsid />
									<cfset session.shooterid = resumegameinprogress.shooterid />
									<cflocation url="#application.root#shooter.game" addtoken="no">
								</cfif>
						<cfelse>
							<div class="row">
								<div class="col-lg-12">
									<div class="alert alert-danger">
										<h5><i class="fa fa-warning fa-2x"></i>  Sorry, there was an error accessing your shooter profile and resuming this game.  Please check your user settings.</h5>
									</div>
								</div>
							</div>
						</cfif>
					</cfif>					
				</cfif>
				
				
				
				
				
				
				
				<!--- // some date/time vars for the page --->
				<cfset currentdatetime = now() />
				<cfset currentdatetime = ParseDateTime( currentdatetime ) />
								
				
				
				<!--- // main wrapper --->
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
						<cfoutput>
							<div class="row" style="margin-top:15px;">						
								<div class="ibox">
									<div class="ibox-title">
										<h5><i class="fa fa-play-circle"></i> #session.username# | Games & Assignment History</h5>
										<span class="pull-right">
											<a href="#application.root#user.home" class="btn btn-xs btn-success"><i class="fa fa-home"></i> Home</a>
											<a href="#application.root#user.profile" class="btn btn-xs btn-primary" style="margin-left:5px;"><i class="fa fa-user"></i> My Profile</a>
										</span>
									</div>							
									<div class="ibox-content">			
										<span class="help-block text-navy" style="margin-bottom:15px;"><i class="fa fa-clock-o"></i> Game check-in 15 minutes prior to game start. <span class="help-block small pull-right"><i class="fa fa-calendar-o"></i> <strong>Current Server Time:</strong> #dateformat( currentdatetime, "mm-dd-yyyy" )# : #timeformat( currentdatetime, "hh:mm:ss tt" )#</span></span>
										
										<cfif shootergames.recordcount gt 0>
											<div class="table-responsive">
												<table class="table table-striped table-hover">
													<thead>
														<tr class="small">													
															<th>Game Date</th>
															<th>Game</th>
															<th>Field</th>
															<th>Status</th>
															<th>Game Check In</th>
														</tr>
													</thead>
													<tbody>
														<cfloop query="shootergames">															
															<!--- // test anomalies in CF date time structure --->
															<!--- // use parsedatetime tag 
															<cfset thisdate = datediff( "d", gamedate, currentdatetime ) />
															<cfset thistime = datediff( "n", gamedate, currentdatetime ) />
															--->
															
															<tr class="small">														
																<td>#dateformat( gamedate, "mm-dd-yyyy" )# : #timeformat( gametime, "hh:mm tt" )#</td>
																<td>#hometeam# vs #awayteam# <!--- | #thisdate# : #thistime#---></td>
																<td>#fieldname# Field <a style="margin-left:5px;" href=""><i class="fa fa-map-marker"></i></a></td>
																<td><cfif trim( shooterassignstatus ) eq "assigned"><span class="label label-danger"><cfelseif trim( shooterassignstatus ) eq "accepted"><span class="label label-primary"><cfelseif trim( shooterassignstatus ) eq "game complete"><span class="label label-success"><cfelse><span class="label"></cfif>#ucase( shooterassignstatus )#</span></td>
																<td>																
																	<cfif trim( shooterassignstatus ) eq "accepted" and shooteracceptedassignment eq 1>
																		<cfif ( datediff( "d", gamedate, currentdatetime ) eq 0 )>
																			<cfif datediff( "n", gametime, currentdatetime ) gte -15>
																				<a href="#application.root##url.event#&fuseaction=game-check-in&vsid=#vsid#&fieldid=#fieldid#&myid=#session.userid#" onclick="javascript:return confirm('You are checking into this game.  Continue?');" class="btn btn-sm btn-success"><i class="fa fa-check-circle"></i> Check In</a>																			
																			<cfelse>
																				<i class="fa fa-circle text-danger" title="Check in 15 minutes before game time."></i>
																			</cfif>
																		<cfelse>
																			<i class="fa fa-circle text-navy" title="Check in on game date."></i>
																		</cfif>
																	<cfelseif trim( shooterassignstatus ) eq "checked in" and shooteracceptedassignment eq 1>
																		<a href="#application.root##url.event#&fuseaction=resume-game&saID=#shooterassignmentid#" onclick="javascript:return confirm('You are already checked in to this game.  Resume Game?');" class="btn btn-sm btn-primary">Resume <i class="fa fa-play-circle"></i></a>
																	<cfelseif trim( shooterassignstatus ) eq "game complete" and shooteracceptedassignment eq 1>
																		<i class="fa fa-circle-o" title="Game already completed."></i>
																	<cfelse>
																		<i class="fa fa-circle" title="You have not accepted the assignment."></i>
																	</cfif>
																	
																</td>
															</tr>
														</cfloop>
													</tbody>													
												</table>
												<small class="help-block" style="margin-bottom:25px;">* You must accept assignments to confirm your filming schedule.</small>
											</div>
										<cfelse>
											<div class="alert alert-warning">
												<p class="small"><i class="fa fa-clock-o"></i> Sorry, there are no accepted game assignments.</p>
											</div>
										</cfif>										
									</div>
								</div>						
							</div>

							<cfif structkeyexists( strShooterGameManager, "checkedinstatus" )>
								<cfif strShooterGameManager.checkedinstatus eq true>
									<span class="label label-danger">{{ CHECKED IN }}</span>
								<cfelse>
									<span class="label label-warning">{{ NOT CHECKED IN }}</span>
								</cfif>
								
								
								<!--- // debug 
								<cfif structkeyexists( session, "vsid" )>
									#session.vsid#
								</cfif>							
								<cfdump var="#strShooterGameManager#" label="mystruct">
								--->
							</cfif>


							
						</cfoutput>						
					</div>
				</div>