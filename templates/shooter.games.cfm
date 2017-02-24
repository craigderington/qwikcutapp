



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
				
				
				
				
				<cfif structkeyexists( session, "userid" ) and structkeyexists( url, "gameid" ) and structkeyexists( url, "do" )>
					<cfif not structkeyexists( session, "checkedinstatus" )>
						<cfif isnumeric( url.gameid ) and trim( url.do ) eq "game">
							<cfset session.vsid = url.gameid />
							<cflocation url="#application.root#shooter.game" addtoken="yes">
						</cfif>
					<cfelse>
						<div class="row">
							<div class="alert alert-danger">
								<h5>You can not be checked in for a game event and also view other game history.  Close out previous games first.</h5>
							</div>
						</div>
					</cfif>
				</cfif>
				
				
				
				<!--- // some date/time vars for the page --->
				<cfset currentdatetime = now() />
				<cfset currentdatetime = ParseDateTime( currentdatetime ) />
				<cfparam name="linkto" default="">				
				<cfparam name="confirm" default="" />
				<cfparam name="fa_" default="" />
				<cfparam name="link_text" default="" />
				
				<cfoutput>
				
				
				<!--- // main wrapper --->
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">						
							
						<div class="row" style="margin-top:15px;">
							<div class="text-center animated fadeInRightBig">
								<div class="col-lg-12 white-bg" style="padding:50px;">								
									<h3><i class="fa fa-play-circle"></i> #session.username# </h3>
									<h5>Games & Shooter Assignment History</h5>
										
									<a href="#application.root#user.home" class="btn btn-sm btn-success btn-outline btn-block"><i class="fa fa-home"></i> Home</a>
									<a href="#application.root#user.profile" class="btn btn-sm btn-primary btn-outline btn-block"><i class="fa fa-user"></i> My Profile</a>
									<p>&nbsp;</p>										
									<p class="label label-default text-navy" style="margin-top:15px;margin-bottom:15px;">
										<i class="fa fa-clock-o"></i> Game check-in 15 minutes prior to game start. 
									</p>
									<p>&nbsp;</p>							
									<p><i class="fa fa-calendar-o"></i> <strong>Current Server Time:</strong></p>
									<p>#dateformat( currentdatetime, "mm-dd-yyyy" )# : #timeformat( currentdatetime, "hh:mm:ss tt" )#</p>
									
								
										
							<cfif shootergames.recordcount gt 0>
											
								<cfloop query="shootergames">															
									<!--- // test anomalies in CF date time structure --->
									<!--- // use parsedatetime tag 
									<cfset thisdate = datediff( "d", gamedate, currentdatetime ) />
									<cfset thistime = datediff( "n", gamedate, currentdatetime ) />
									--->
									
									<cfif trim( shooterassignstatus ) eq "accepted" and shooteracceptedassignment eq 1>
										<cfif ( datediff( "d", gamedate, currentdatetime ) eq 0 )>
											<cfif datediff( "n", gametime, currentdatetime ) gte -15>
												<cfset linkto = "#application.root##url.event#&fuseaction=game-check-in&vsid=#vsid#&fieldid=#fieldid#&myid=#session.userid#" />																			
												<cfset confirm = "javascript:return confirm('You are checking into this game.  Continue?');" />												
												<cfset fa_ = "fa fa-check-circle-o" />
												<cfset link_text = "<span class='label label-danger' style='font-size:18px;'>CHECK IN NOW</span>" />										
											<cfelse>
												<cfset linkto = "#application.root##url.event#" />
												<cfset confirm = "javascript:void(0);" />
												<cfset fa_ = "fa fa-circle text-danger" />
												<cfset link_text = "Check in 15 min. before game time." />											
											</cfif>
										<cfelse>
											<cfset linkto = "#application.root##url.event#&do=game&gameid=#vsid#" />
											<cfset confirm = "return confirm('This will open the game assignment to view details.  Continue?');" />
											<cfset fa_ = "fa fa-circle text-danger" />
											<cfset link_text = "Check in on game date" />
										</cfif>
									
									<cfelseif trim( shooterassignstatus ) eq "checked in" and shooteracceptedassignment eq 1>										
										
										<cfset linkto = "#application.root##url.event#&fuseaction=resume-game&saID=#shooterassignmentid#" />
										<cfset confirm = "javascript:return confirm('You are already checked in to this game.  Resume Game?');" />
										<cfset fa_ = "fa fa-play-circle text-danger" />
										<cfset link_text = "Resume Game" />				
										
										
									<cfelseif trim( shooterassignstatus ) eq "completed" and shooteracceptedassignment eq 1>										
										
										<cfset linkto = "#application.root##url.event#&do=game&gameid=#vsid#" />
										<cfset confirm = "" />
										<cfset fa_ = "fa fa-circle-o text-success" />
										<cfset link_text = "GAME COMPLETED" />									
										
									<cfelse>
										
										<cfset linkto = "#application.root#shooter-assignments" />
										<cfset confirm = "" />
										<cfset fa_ = "fa fa-circle text-danger" />
										<cfset link_text = "ACCEPT ASSIGNMENT." />								
										
										
									</cfif>
									
									
									
									
															
									<a href="#linkto#" 
									   class="btn btn-<cfif trim( shooterassignstatus ) eq "assigned">danger btn-outline<cfelseif trim( shooterassignstatus ) eq "accepted">success<cfelseif trim( shooterassignstatus ) eq "completed">primary<cfelse>default btn-outline</cfif> btn-lg btn-block"																				
									   onclick="#confirm#">
										
										<p><i class="#fa_#"></i></p>
										<p>#dateformat( gamedate, "mm-dd-yyyy" )# : #timeformat( gametime, "hh:mm tt" )#</p>
																
										<p>#hometeam#</p> 
										<p>vs.</p>
										<p>#awayteam#</p> 
										<!--- | #thisdate# : #thistime#--->
										<p>@</p>							
										<p>#fieldname# Field</p>
										<p><span class="label label-<cfif trim( shooterassignstatus ) eq "assigned">danger<cfelseif trim( shooterassignstatus ) eq "accepted">warning<cfelseif trim( shooterassignstatus ) eq "completed">info<cfelse>default</cfif>">#ucase( shooterassignstatus )#</span></p>
										<p><small>#link_text#</small></p>
									
									
									</a>
									
									
								</cfloop>
															
									<small class="help-block" style="margin-bottom:25px;">* You must accept assignments to confirm your filming schedule.</small>
											
							<cfelse>
								<div class="alert alert-warning">
									<p class="small"><i class="fa fa-clock-o"></i> Sorry, there are no accepted game assignments.</p>
								</div>
							</cfif>										
									
								
							
							
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