

			
			
			<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
				<cfinvokeargument name="id" value="#url.id#">
			</cfinvoke>
			
			<cfquery name="gameseason">
				select gameseasonid, gameseason from gameseasons where gameseasonactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			</cfquery>
			
			<cfinvoke component="apis.com.admin.teamadminservice" method="getteamrecord" returnvariable="teamrecord">
				<cfinvokeargument name="id" value="#url.id#">
				<cfinvokeargument name="gameseasonid" value="#gameseason.gameseasonid#">
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
									<div class="col-lg-7">							
										<p><span class="btn btn-xs btn-success"><i class="fa fa-play"></i><cfif trim( teamdetail.conftype ) eq "YF"> YOUTH FOOTBALL<cfelse>HIGH SCHOOL FOOTBALL</cfif></span>  <span style="margin-left:5px;margin-right:5px;" class="btn btn-xs btn-primary"><i class="fa fa-fast-forward"></i> #ucase( teamdetail.teamlevelname )#</span>  <cfif isuserinrole( "admin" )><a style="margin-left:5px;" href="#application.root##url.event#&fuseaction=team.edit&id=#teamdetail.teamid#" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-edit"></i> Edit Team</a></cfif></p>
										<h1><strong>#teamdetail.teamname# <cfif teamdetail.teammascot is not "">#teamdetail.teammascot#</cfif></strong> <cfif teamdetail.teamactive eq 1><i class="fa fa-check-circle-o text-primary" style="margin-left:5px;"></i></cfif></h1>
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
									<div class="col-lg-5">		
										<div class="widget navy-bg p-lg text-center">
											<div class="m-b-md">
												<i class="fa fa-trophy fa-4x"></i>
												<cfif teamrecord.recordcount eq 1>
													<h1 class="m-xs">#teamrecord.wins# - #teamrecord.losses#</h1>
												<cfelse>
													<h2 class="m-xs m-b">No Game Statuses Recorded</h2>
												</cfif>
													<h3 style="margin-top:10px;" class="font-bold">#gameseason.gameseason# Team Record</h3>
											</div>											
										</div>
										<cfif isuserinrole( "admin" )>
											<div>
												<a href="#application.root##url.event#&fuseaction=team.roster&id=#teamdetail.teamid#" class="btn btn-sm btn-success"><i class="fa fa-users"></i> Manage Team Roster</a>
												<a style="margin-left:1px;" href="#application.root##url.event#&fuseaction=team.contacts&id=#teamdetail.teamid#" class="btn btn-sm btn-default"><i class="fa fa-envelope"></i> Manage Team Contacts</a>
											</div>
										</cfif>
									</div>						
								</div>
							</div>
						</div>
					</div>
				</div>
			</cfoutput>