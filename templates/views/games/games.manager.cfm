



					<cfif not structkeyexists( session, "vsid" )>
						<cflocation url="#application.root##url.event#&gvs=1" addtoken="no">
					</cfif>
					
					
					<cfinvoke component="apis.com.admin.gameadminservice" method="getversus" returnvariable="versus">
						<cfinvokeargument name="vsid" value="#session.vsid#">
					</cfinvoke>
					
					<cfinvoke component="apis.com.admin.gameadminservice" method="getgames" returnvariable="games">
						<cfinvokeargument name="vsid" value="#session.vsid#">
					</cfinvoke>
				
				

				<cfoutput>
					
					<cfif structkeyexists( url, "scope" ) and trim( url.scope ) eq "game">
						<div class="row" style="margin-top:5px;margin-bottom:-15px;">
							<div class="alert alert-info alert-dismissable">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
								<h4><i class="fa fa-check-circle-o"></i> Game Deleted.</h4>
								<p>The selected game schedule was deleted from this match up.  Games can be rescheduled individually in the Games Manager.</p>
							</div>
						</div>
					</cfif>
					
					
					
					<div class="row">
						<div class="ibox-title">
							<h5>#session.username# | Games Scheduling Manager</h5>
							<span class="pull-right">
								<cfif isuserinrole( "admin" )>
									<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline"><i class="fa fa-play-circle"></i> Finished</a>
									<a style="margin-right:5px;" href="#application.root##url.event#&fuseaction=game.schedule" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-plus-circle"></i> Create Game Schedule</a>
								<cfelse>
									<a href="#application.root#user.home" class="btn btn-xs btn-success btn-outline"><i class="fa fa-play-circle"></i> Finished</a>
									<a style="margin-right:5px;" href="#application.root#team.games" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to Team Games</a>
								</cfif>
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
						
						<div class="ibox-content" style="min-height:<cfif games.recordcount lt 7>800<cfelse>1200</cfif>px;">
							
							<cfif not structkeyexists( url, "manage" )>
							
								<div class="col-md-3">							
									<cfinclude template="game-team-list-view.cfm">
								</div>
								
								<div class="col-md-3">
									<cfinclude template="game-notification-view.cfm">
								</div>
								
								<div class="col-md-3">
									<cfinclude template="game-field-map-view.cfm">
								</div>
								
								<div class="col-md-3">
									<cfinclude template="game-shooter-view.cfm">
								</div>						
							
							<cfelseif structkeyexists( url, "manage" )>
							
								<cfif trim( url.manage ) eq "schedule">
									<cfinclude template="game-schedule-edit.cfm">
								<cfelseif trim( url.manage ) eq "shooter">
									<cfinclude template="game-shooter-assign.cfm">
								<cfelseif trim( url.manage ) eq "send-notify">
									<cfinclude template="game-notification-send.cfm">
								<cfelseif trim( url.manage ) eq "field">
									<cfinclude template="game-change-field.cfm">
								<cfelseif trim( url.manage ) eq "delete.games">
									<cfinclude template="games-delete-versus.cfm">
								<cfelse>
								
									<div class="alert alert-info">
										<h4><i class="fa fa-warning"> <a href="">Error.  Games Manager View Note Found</a> </h4>
									</div>
								
								</cfif>
								
								
								
							
							
							
							
							
							</cfif>
							
							
							
						</div>
					
					</div>
				
				
					
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				</cfoutput>