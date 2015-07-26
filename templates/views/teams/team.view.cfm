

			
			
			<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
				<cfinvokeargument name="id" value="#url.id#">
			</cfinvoke>
			
			



			<cfoutput>			
				<div class="row">
					<div class="ibox">
						<div class="ibox-title">
							<h5><i class="fa fa-trophy"></i> #teamdetail.teamname# | Team Details</h5>
							<span class="pull-right">
								<a href="#application.root#admin.home" class="btn btn-xs btn-outline btn-primary"><i class="fa fa-cog"></i> Admin Home</a>
								<a style="margin-left:5px;" href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline"><i class="fa fa-arrow-circle-left"></i> Teams List</a>								
							</span>
						</div>
						<div class="ibox-content">					
							<div class="panel-body">
								<div class="col-lg-12">
									<div class="col-lg-8">							
										<p><span class="btn btn-xs btn-success"><i class="fa fa-play"></i><cfif trim( teamdetail.conftype ) eq "YF"> YOUTH FOOTBALL<cfelse>HIGH SCHOOL FOOTBALL</cfif></span>  <span style="margin-left:5px;margin-right:5px;" class="btn btn-xs btn-primary"><i class="fa fa-fast-forward"></i> #ucase( teamdetail.teamlevelname )#</span>  <cfif isuserinrole( "admin" )><a style="margin-left:5px;" href="#application.root##url.event#&fuseaction=team.edit&id=#teamdetail.teamid#" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-edit"></i> Edit Team</a></cfif></p>
										<h1><strong>#teamdetail.teamname#</strong> <cfif teamdetail.teamactive eq 1><i class="fa fa-check-circle-o text-primary" style="margin-left:5px;"></i></cfif></h1>
										<h3>#ucase( teamdetail.confname )#</h3>
										<p>#teamdetail.teamcity#, #ucase( teamdetail.stateabbr )#</p>										
										<p>#teamdetail.teammascot#</p>
										<p>#teamdetail.teamcolors#</p>
										<p>&nbsp;</p>
										<p>&nbsp;</p>
									</div>
									<div class="col-lg-4">		
										<div class="widget navy-bg p-lg text-center">
											<div class="m-b-md">
												<i class="fa fa-trophy fa-4x"></i>
												<h1 class="m-xs">#teamdetail.teamrecord#</h1>												
												<h3 class="font-bold">Team Record</h3>
											</div>
										</div>									
									</div>						
								</div>
							</div>
						</div>
					</div>
				</div>
			</cfoutput>