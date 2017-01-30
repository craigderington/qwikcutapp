

	<cfinvoke component="apis.com.qwikstats.qwikstatsdashboardservice" method="gettopgoals" returnvariable="goalleaderboard">		
	</cfinvoke>
	
	<cfinclude template="header.cfm">
	
	<!---
	<cfdump var="#goalleaderboard#" label="Leaderboard">
	
	<ul>
	<cfoutput query="goalleaderboard" maxrows="3">
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
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Conference Name I
                                    </div>
                                    <div class="panel-body">
										<p>Team Name   <span class="pull-right">12-0</span></p>
										<p>Team Name   <span class="pull-right">8-4</span></p>
										<p>Team Name   <span class="pull-right">7-5</span></p>
										<p>Team Name   <span class="pull-right">6-6</span></p>
										<p>Team Name   <span class="pull-right">5-7</span></p>
                                    </div>
                                    <div class="panel-footer">
										{{ team count }}
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
										Conference Name II
                                    </div>
                                    <div class="panel-body">
										<p>Team Name   <span class="pull-right">12-0</span></p>
										<p>Team Name   <span class="pull-right">8-4</span></p>
										<p>Team Name   <span class="pull-right">7-5</span></p>
										<p>Team Name   <span class="pull-right">6-6</span></p>
										<p>Team Name   <span class="pull-right">5-7</span></p>
									</div>
                                    <div class="panel-footer">
										{{ team count }}
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-info">
                                    <div class="panel-heading">
										Conference Name III
                                    </div>
                                    <div class="panel-body">
										<p>Team Name   <span class="pull-right">12-0</span></p>
										<p>Team Name   <span class="pull-right">8-4</span></p>
										<p>Team Name   <span class="pull-right">7-5</span></p>
										<p>Team Name   <span class="pull-right">6-6</span></p>
										<p>Team Name   <span class="pull-right">5-7</span></p>
									</div>
                                    <div class="panel-footer">
										{{ team count }}
                                    </div>
                                </div>
                            </div>
						</div>
						
						<div class="row">
							<div class="col-lg-4">
                                <div class="panel panel-warning">
                                    <div class="panel-heading">
                                        Conference Name IV
                                    </div>
                                    <div class="panel-body">
										<p>Team Name   <span class="pull-right">12-0</span></p>
										<p>Team Name   <span class="pull-right">8-4</span></p>
										<p>Team Name   <span class="pull-right">7-5</span></p>
										<p>Team Name   <span class="pull-right">6-6</span></p>
										<p>Team Name   <span class="pull-right">5-7</span></p>
                                    </div>
                                    <div class="panel-footer">
										{{ team count }}
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-success">
                                    <div class="panel-heading">
										Conference Name V
                                    </div>
                                    <div class="panel-body">
										<p>Team Name   <span class="pull-right">12-0</span></p>
										<p>Team Name   <span class="pull-right">8-4</span></p>
										<p>Team Name   <span class="pull-right">7-5</span></p>
										<p>Team Name   <span class="pull-right">6-6</span></p>
										<p>Team Name   <span class="pull-right">5-7</span></p>
									</div>
                                    <div class="panel-footer">
										{{ team count }}
                                    </div>
                                </div>
                            </div>
							<div class="col-lg-4">
                                <div class="panel panel-danger">
                                    <div class="panel-heading">
										Conference Name VI
                                    </div>
                                    <div class="panel-body">
										<p>Team Name   <span class="pull-right">12-0</span></p>
										<p>Team Name   <span class="pull-right">8-4</span></p>
										<p>Team Name   <span class="pull-right">7-5</span></p>
										<p>Team Name   <span class="pull-right">6-6</span></p>
										<p>Team Name   <span class="pull-right">5-7</span></p>
									</div>
                                    <div class="panel-footer">
										{{ team count }}
                                    </div>
                                </div>
                            </div>
						</div>
						
						
						
					</div>
				</div>
			</div>
		</cfoutput>
		
		
		<cfinclude template="footer.cfm">
				
				