
				
				
				



				<!---
				<cfinvoke component="apis.com.admin.gameadminservice" method="getgameslist" returnvariable="gameslist">
					<cfinvokeargument name="gameseasonid" value="1">
				</cfinvoke>
				
				<cfinvoke component="apis.com.admin.conferenceadminservice" method="getconferences" returnvariable="conferencelist">
				</cfinvoke>
			
				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamlevels" returnvariable="teamlevels">
				</cfinvoke>
				--->

			<cfoutput>	
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
					
							<!--- // check the users role --->
							<cfif isuserinrole( "admin" ) or isuserinrole( "confadmin" )>	
								
								<!-- // include the page heading --->
								<cfinclude template="views/games-admin-page-heading.cfm">
							
												
							
								<!-- // include the view state -->
								<cfif not structkeyexists( url, "fuseaction" )>				
									<cfinclude template="views/games/games.list.cfm">
								<cfelseif structkeyexists( url, "fuseaction" )>
									<cfif trim( url.fuseaction ) eq "game.edit">
										<cfinclude template="views/games/game.edit.cfm">
									<cfelseif trim( url.fuseaction ) eq "game.delete">
										<cfinclude template="views/games/game.delete.cfm">
									<cfelseif trim( url.fuseaction ) eq "game.add">
										<cfinclude template="views/games/game.add.cfm">
									<cfelseif trim( url.fuseaction ) eq "game.schedule">
										<cfinclude template="views/games/game.start.cfm">
									<cfelseif trim( url.fuseaction ) eq "game.custom">
										<cfinclude template="views/games/game.custom.cfm">
									<cfelseif trim( url.fuseaction ) eq "game.view">
										<cfinclude template="views/games/game.view.cfm">									
									<cfelseif trim( url.fuseaction ) eq "game.map">
										<cfinclude template="views/games/game.map.cfm">
									<cfelseif trim( url.fuseaction ) eq "games.mgr">
										<cfinclude template="views/games/games.manager.cfm">
									<cfelseif trim( url.fuseaction ) eq "games.filter">
										<cfinclude template="views/games/games.filter.cfm">
									<cfelseif trim( url.fuseaction ) eq "game.custom.nc">
										<cfinclude template="views/games/game.custom.nc.cfm">
									<cfelseif trim( url.fuseaction ) eq "game.start">
										<cfinclude template="views/games/game.custom.cfm">
									<cfelseif trim( url.fuseaction ) eq "games.shooters">
										<cfinclude template="views/games/games.shooters.cfm">
									<cfelseif trim( url.fuseaction ) eq "games.week.view">
										<cfinclude template="views/games/games-week-view.cfm">
									<cfelse>
										<!-- // no view found, show message -->
										<div class="alert alert-danger" style="margin-top:10px;">
											<h4><i class="fa fa-warning"></i> SYSTEM ALERT</h4>
											<p>The selected view could not be found...  Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate to the homepage.</p>
										</div>						
									</cfif>
								<cfelse>
									<!-- // no view found, show message -->
									<div class="alert alert-danger" style="margin-top:10px;">
										<h4><i class="fa fa-warning"></i> SYSTEM ALERT</h4>
										<p>The selected view could not be found...  Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate to the homepage.</p>
									</div>
								</cfif>
							
							<cfelse>
							
								<!-- // no view found, show message -->
									<div class="alert alert-danger" style="margin-top:10px;">
										<h4><i class="fa fa-warning fa-3x"></i> SYSTEM ALERT</h4>
										<p>You are attempting to access a restricted resource within this system without proper authorization.   Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate away from this page.</p>
									</div>
							
							</cfif>					
					</div>
				</div>
			</cfoutput>