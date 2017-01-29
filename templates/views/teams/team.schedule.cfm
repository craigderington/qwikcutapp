


	
	
		




				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>		
									
					
				<cfoutput>					
					<div class="ibox" style="margin-top:-15px;">								
								
						<div class="ibox-title">
							<h5><i class="fa fa-group"></i> #teamdetail.teamorgname# Game Schedule</h5>
								<span class="pull-right">
									<a class="btn btn-xs btn-success" href="#application.root#&event=#url.event#&fuseaction=team.view&id=#url.id#"><i class="fa fa-arrow-circle-left"></i> Return to Team Detail</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-warning" href="#application.root#&event=#url.event#"><i class="fa fa-th-list"></i> Return to Team List</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-default" href="#application.root#admin.home"><i class="fa fa-home"></i> Admin Home</a>
								</span>							
						</div>								
								
						<div class="ibox-content" style="min-height:500px;">									
							
								<ul class="nav nav-tabs">
									<li><a href="#application.root##url.event#&fuseaction=team.view&id=#url.id#"><i class="fa fa-check-circle"></i> Team Details</a></li>
									<li><a href="#application.root##url.event#&fuseaction=team.roster&id=#url.id#"><i class="fa fa-soccer-ball-o"></i> Team Roster</a></li>
									<li><a href="#application.root##url.event#&fuseaction=team.contacts&id=#url.id#"><i class="fa fa-briefcase"></i> Team Contacts</a></li>
									<li class="active"><a href="#application.root##url.event#&fuseaction=team.schedule&id=#url.id#"><i class="fa fa-clock-o"></i> Team Schedule</a></li>
									<!---
									<li><a href="">Menu 2</a></li>
									<li><a href="">Menu 2</a></li>
									--->
								</ul>
								<div class="tab-content" style="margin-top:25px;">
								    <div id="teamroster" class="tab-pane fade in active">						
										<div class="col-lg-8">								
											{{ team game schedule | coming soon }}								
										</div>
										<div class="col-lg-4">			
											
										</div>
									</div>
								</div>
						</div>
					</div>
				</cfoutput>
							
						