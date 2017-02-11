

			
			<cfif isuserloggedin()>
			
			
				<cfinvoke component="apis.com.qwikstats.dashboard" method="gettopgoals" returnvariable="goalleaderboard">
					<cfinvokeargument name="id" value="#session.teamid#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="gettopassists" returnvariable="assistsleaderboard">		
					<cfinvokeargument name="id" value="#session.teamid#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="gettopshots" returnvariable="shotsleaderboard">		
					<cfinvokeargument name="id" value="#session.teamid#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="gettopsaves" returnvariable="savesleaderboard">		
					<cfinvokeargument name="id" value="#session.teamid#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="gettopgrounders" returnvariable="groundersleaderboard">		
					<cfinvokeargument name="id" value="#session.teamid#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="gettopturnovers" returnvariable="turnoversleaderboard">		
					<cfinvokeargument name="id" value="#session.teamid#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.qwikstats.dashboard" method="getgameseason" returnvariable="gameseason">
				</cfinvoke>







				<!--- // main wrapper --->
				<div class="wrapper wrapper-content animated fadeIn">
					
						
						<cfoutput>
						
						
							<!--- // show message if user attempts to circumvent security settings --->
							<cfif structkeyexists( url, "accessdenied" )>
								<div class="row">
									<div class="alert alert-danger alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<h3><i class="fa fa-lock fa-2x"></i>  You have attempted to access a restricted resource.  Access Denied.</h3>								
									</div>
								</div>
							</cfif>
							<!--- // end system messages --->				
							<!---
							<div class="row">							
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<i class="fa fa-th-list"></i> Team Stats
									</div>
								</div>
							</div>
							--->
							
							<div class="row" style="margin-top:20px;">							
								<div class="ibox">
									<div class="ibox-title">
										<i class="fa fa-trophy"></i> #gameseason.gameseason#: #session.teamname# Leader Board
									</div>
									<div class="ibox-content">
										
										<div class="row">
									<div class="col-lg-4">
										<div class="panel panel-primary">
											<div class="panel-heading">
												<strong><i class="fa fa-check-circle-o"></i> Top Goals</strong>
											</div>
											<div class="panel-body">
												<cfloop query="goalleaderboard" maxrows="5">
													<p><span class="label label-primary">## #playernumber#</span> <strong>#playername#</strong> #playerposition# - #teamname#<span class="badge badge-primary pull-right">#total_goals#</span></p>
												</cfloop>
											</div>
											<div class="panel-footer">
												<small>Top 5 goals scored by player.</small>
											</div>
										</div>
									</div>
									<div class="col-lg-4">
										<div class="panel panel-success">
											<div class="panel-heading">
												<strong><i class="fa fa-check-circle-o"></i> Top Assists</strong>
											</div>
											<div class="panel-body">
												<cfloop query="assistsleaderboard" maxrows="5">
													<p><span class="label label-success">## #playernumber#</span> <strong>#playername#</strong> #playerposition# - #teamname#<span class="badge badge-success pull-right">#total_assists#</span></p>
												</cfloop>
											</div>
											<div class="panel-footer">
												<small>Top 5 assists by player.</small>
											</div>
										</div>
									</div>
									<div class="col-lg-4">
										<div class="panel panel-info">
											<div class="panel-heading">
												<strong><i class="fa fa-check-circle-o"></i> Top Shots</strong>
											</div>
											<div class="panel-body">
												<cfloop query="shotsleaderboard" maxrows="5">
													<p><span class="label label-info">## #playernumber#</span> <strong>#playername#</strong> #playerposition# - #teamname#<span class="badge badge-info pull-right">#total_shots#</span></p>
												</cfloop>
											</div>
											<div class="panel-footer">
												<small>Top 5 shots taken by player.</small>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-4">
										<div class="panel panel-warning">
											<div class="panel-heading">
												<strong><i class="fa fa-check-circle-o"></i> Top Saves</strong>
											</div>
											<div class="panel-body">
												<cfloop query="savesleaderboard" maxrows="5">
													<p><span class="label label-warning">## #playernumber#</span> <strong>#playername#</strong> #playerposition# - #teamname#<span class="badge badge-warning pull-right">#total_saves#</span></p>
												</cfloop>
											</div>
											<div class="panel-footer">
												<small>Top 5 saves by player.</small>
											</div>
										</div>
									</div>
									<div class="col-lg-4">
										<div class="panel panel-default">
											<div class="panel-heading">
												<strong><i class="fa fa-check-circle-o"></i> Top Grounders</strong>
											</div>
											<div class="panel-body">
												<cfloop query="groundersleaderboard" maxrows="5">
													<p><span class="label lebale-default">## #playernumber#</span> <strong>#playername#</strong> #playerposition# - #teamname#<span class="badge badge-default pull-right">#total_grounders#</span></p>
												</cfloop>
											</div>
											<div class="panel-footer">
												<small>Top 5 grounders by player.</small>
											</div>
										</div>
									</div>
									<div class="col-lg-4">
										<div class="panel panel-danger">
											<div class="panel-heading">
												<strong><i class="fa fa-check-circle-o"></i> Turnovers</strong>
											</div>
											<div class="panel-body">
												<cfloop query="turnoversleaderboard" maxrows="5">
													<p><span class="label label-danger">## #playernumber#</span> <strong>#playername#</strong> #playerposition# - #teamname#<span class="badge badge-danger pull-right">#total_turnovers#</span></p>
												</cfloop>
											</div>
											<div class="panel-footer">
												<small>Top 5 turnovers by player.</small>
											</div>
										</div>
									</div>
								</div>
										
										
										
										
									</div>
									<div class="ibox-footer">
										<i class="fa fa-trophy"></i> #gameseason.gameseason# Leader Board
									</div>
								</div>
							</div>
							
							
							
							
						</cfoutput>					
							
												
							
						
					
				</div><!-- /.wrapper-content -->
				
				
			<cfelse>
		
		
				
		
		
			</cfif>
		
