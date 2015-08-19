				
				
				
				
				<!--- // make sure we have a good game session --->
				<cfif not structkeyexists( session, "vsid" )>
					<cflocation url="#application.root#shooter.games" addtoken="yes">
				</cfif>
				
					<cfinvoke component="apis.com.admin.gameadminservice" method="getversus" returnvariable="versus">
						<cfinvokeargument name="vsid" value="#session.vsid#">
					</cfinvoke>
					
					<cfinvoke component="apis.com.admin.gameadminservice" method="getgames" returnvariable="games">
						<cfinvokeargument name="vsid" value="#session.vsid#">
					</cfinvoke>
				
				
					<cfset url.fuseaction = "games.mgr" />



				<!--- // main wrapper --->
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
						<cfoutput>
							<div class="row" style="margin-top:15px;">
								<cfif structkeyexists( url, "ac" )>
									<div class="alert alert-info alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
										<h5><i class="fa fa-check-square-o"></i> You have accepted the game assignment.  On Game Day, <a href="#application.root#shooter.games"><strong>Check In</strong></a> to this game 15 minutes prior to game start.</h5>
									</div>
								<cfelseif structkeyexists( url, "jsessionid" ) and structkeyexists( url, "cftoken" ) and structkeyexists( session, "shooterid" )>
									<div class="alert alert-success alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
										<h5><i class="fa fa-check-square-o"></i> You have successfully checked in for this game.  Update individual game statuses below for each Team Level.  </h5>
									</div>
								</cfif>
								
								
								<div class="ibox">
									<div class="ibox-title">
										<h5><i class="fa fa-film"></i> #session.username# | Game ID: #session.vsid#</h5>
										<span class="pull-right">
											<a href="#application.root#user.home" class="btn btn-xs btn-success btn-outline"><i class="fa fa-home"></i> Home</a>
											<a href="#application.root#shooter.games" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-play-circle"></i> My Games</a>											
											<a href="#application.root#user.settings" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-user"></i> My Profile</a>
										</span>
									</div>
									<div class="ibox-content ibox-heading border-bottom">
										<h3 class="text-center">
											<p>#versus.awayteam# <i>vs.</i>  <strong>#versus.hometeam#</strong></p>								
											<p><small>#versus.fieldname# Field in #versus.fieldcity#, #versus.stateabbr#</small></p>								
											<p><small><span class="label label-primary"><i class="fa fa-calendar-o"></i> #dateformat( versus.gamedate, "mm-dd-yyyy" )#</span> <span style="margin-left:10px;" class="label label-success"><i class="fa fa-clock-o"></i> #timeformat( versus.gametime, "hh:mm tt" )#</span></small></p>								
										</h3>
										<p><span class="help-block text-center"><small>Home team shown in bold.</small></span></p>
									</div>									
									<div class="ibox-content" style="min-height:950px;">
										
										<div class="col-md-6">							
											<cfinclude template="views/games/game-team-list-view.cfm">
										</div>								
								
										<div class="col-md-6">
											<cfif structkeyexists( session, "checkedinstatus" ) and structkeyexists( session, "shooterid" )>											
												<cfif structkeyexists( url, "gamestatus" ) and structkeyexists( url, "sgid" )>
													 <cfinclude template="views/games/game-status-update.cfm">
												<cfelse>
													<cfinclude template="views/games/game-field-map-view.cfm">
												</cfif>
											<cfelse>
												<cfinclude template="views/games/game-field-map-view.cfm">
											</cfif>										
											
										</div>
										
										<!---
										<div class="col-md-3">
											<cfinclude template="views/games/game-shooter-view.cfm">
										</div>
										<div class="col-md-3">
											<cfinclude template="views/games/game-notification-view.cfm">
										</div>
										--->
									</div>
								</div>						
							</div>
						</cfoutput>
						
					</div>
				</div>