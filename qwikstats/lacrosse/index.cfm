

	<cfinvoke component="apis.com.qwikstats.qwikstatsdashboardservice" method="gettopgoals" returnvariable="goalleaderboard">		
	</cfinvoke>
	
	<cfinvoke component="apis.com.qwikstats.qwikstatsdashboardservice" method="gettopassists" returnvariable="assistsleaderboard">		
	</cfinvoke>
	
	<cfinvoke component="apis.com.qwikstats.qwikstatsdashboardservice" method="gettopshots" returnvariable="shotsleaderboard">		
	</cfinvoke>
	
	<cfinvoke component="apis.com.qwikstats.qwikstatsdashboardservice" method="gettopsaves" returnvariable="savesleaderboard">		
	</cfinvoke>
	
	<cfinvoke component="apis.com.qwikstats.qwikstatsdashboardservice" method="gettopgrounders" returnvariable="groundersleaderboard">		
	</cfinvoke>
	
	<cfinvoke component="apis.com.qwikstats.qwikstatsdashboardservice" method="gettopturnovers" returnvariable="turnoversleaderboard">		
	</cfinvoke>
	
	<cfinclude template="header.cfm">
	
	<!---
	<cfdump var="#goalleaderboard#" label="Leaderboard">
	
	<ul>
	<cfoutput query="goalleaderboard" maxrows="10">
		<li>#playername#  #teamname# -  #total_goals#</li>
	</cfoutput>
	</ul>
	--->
	
	
	




		<cfoutput>
			<div class="row">
				<div class="ibox">
					<div class="ibox-title" style="padding:5px;">
						<h5 style="margin-left:10px;margin-top:5px;"><i class="fa fa-trophy"></i> Lacrosse Team Standings   <a style="margin-left:10px;" href="" class="btn btn-xs btn-white btn-outline"><i class="fa fa-th-list"></i> List View</a></h5>
						<span class="pull-right">
							<a href="login.cfm" style="margin-bottom:5px;" class="btn btn-sm btn-success"><i class="fa fa-lock"></i> Login for Team Stats</a>
							<a style="margin-right:5px;margin-bottom:5px;" href="" class="btn btn-sm btn-primary"><i class="fa fa-mobile"></i> Contact Us!</a>
							<a style="margin-right:5px;margin-bottom:5px;" href="" class="btn btn-sm btn-danger"><i class="fa fa-credit-card"></i> Purchase Now!</a>
						</span>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-4">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <strong>Top Goals</strong>
                                    </div>
                                    <div class="panel-body">
										<cfloop query="goalleaderboard" maxrows="5">
											<p><strong>#playername#</strong> - #teamname#<span class="badge badge-primary pull-right">#total_goals#</span></p>
										</cfloop>
                                    </div>
                                    <div class="panel-footer">
										<small>Top 5 goals scored by player and team.</small>
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-success">
                                    <div class="panel-heading">
										Top Assists
                                    </div>
                                    <div class="panel-body">
										<cfloop query="assistsleaderboard" maxrows="5">
											<p><strong>#playername#</strong> - #teamname#<span class="badge badge-success pull-right">#total_assists#</span></p>
										</cfloop>
									</div>
                                    <div class="panel-footer">
										<small>Top 5 assists by player and team.</small>
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-info">
                                    <div class="panel-heading">
										Top Shots
                                    </div>
                                    <div class="panel-body">
										<cfloop query="shotsleaderboard" maxrows="5">
											<p><strong>#playername#</strong> - #teamname#<span class="badge badge-info pull-right">#total_shots#</span></p>
										</cfloop>
									</div>
                                    <div class="panel-footer">
										<small>Top 5 shots taken by player and team.</small>
                                    </div>
                                </div>
                            </div>
						</div>
						
						<div class="row">
							<div class="col-lg-4">
                                <div class="panel panel-warning">
                                    <div class="panel-heading">
                                        Top Saves
                                    </div>
                                    <div class="panel-body">
										<cfloop query="savesleaderboard" maxrows="5">
											<p><strong>#playername#</strong> - #teamname#<span class="badge badge-warning pull-right">#total_saves#</span></p>
										</cfloop>
                                    </div>
                                    <div class="panel-footer">
										<small>Top 5 saves by player and team.</small>
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
										Top Grounders
                                    </div>
                                    <div class="panel-body">
										<cfloop query="groundersleaderboard" maxrows="5">
											<p><strong>#playername#</strong> - #teamname#<span class="badge badge-default pull-right">#total_grounders#</span></p>
										</cfloop>
									</div>
                                    <div class="panel-footer">
										<small>Top 5 grounders by player and team.</small>
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-danger">
                                    <div class="panel-heading">
										Turnovers
                                    </div>
                                    <div class="panel-body">
										<cfloop query="turnoversleaderboard" maxrows="5">
											<p><strong>#playername#</strong> - #teamname#<span class="badge badge-danger pull-right">#total_turnovers#</span></p>
										</cfloop>
									</div>
                                    <div class="panel-footer">
										<small>Top 5 turnovers by player and team.</small>
                                    </div>
                                </div>
                            </div>
						</div>
						
						
						
					</div>
				</div>
			</div>
		</cfoutput>
		
		
		<cfinclude template="footer.cfm">
				
				