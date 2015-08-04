

			
			
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
										
										<cfif teamdetail.homefieldid neq 0>
											<cfinvoke component="apis.com.admin.fieldadminservice" method="gethomefield" returnvariable="homefield">
												<cfinvokeargument name="id" value="#teamdetail.homefieldid#">
											</cfinvoke>
										
										<p>Home Field: <strong>#homefield.fieldname#</strong></p>									
										<p><button type="button" class="btn btn-sm btn-white" data-html="true" data-container="body" data-toggle="popover" data-placement="popover" data-title="#homefield.fieldname#" data-content="<small>#homefield.fieldaddress1#<br /><cfif homefield.fieldaddress2 neq "">#homefield.fieldaddress2#<br /></cfif>#homefield.fieldcity#, #homefield.stateabbr# #homefield.fieldzip#  <a href='#application.root#admin.fields&fuseaction=field.map&id=#homefield.fieldid#'><i class='fa fa-map-marker'></i> Show Map</a><br /><br />Field Contact:<br />#homefield.fieldcontactname#<br />#homefield.fieldcontacttitle#<br />#homefield.fieldcontactnumber#</small>"><i class="fa fa-map-marker"></i> Show Field Info</button></p>
										
										<cfelse>
										<p><strong>Home Field Not Set</strong></p>
										<p style="margin-top:3px;"><a class="btn btn-xs btn-default" href="#application.root##url.event#&fuseaction=team.edit&id=#teamdetail.teamid#"><i class="fa fa-share-square"></i> Set Home Field</a></p>
										</cfif>
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