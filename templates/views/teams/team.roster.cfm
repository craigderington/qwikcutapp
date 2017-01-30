


	
	
		




				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamroster" returnvariable="teamroster">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>
				
				<cfif structkeyexists( url, "trid" ) and url.trid is not "">
					<cfif isnumeric( url.trid ) and url.trid neq 0>
						<cfset trid = url.trid />
							<cfinvoke component="apis.com.admin.teamadminservice" method="getplayerdetails" returnvariable="playerdetails">
								<cfinvokeargument name="trid" value="#trid#">
							</cfinvoke>
							<cfif structkeyexists( url, "deleteTeamMember" ) and trim( url.deleteTeamMember ) is "True">
								<cfquery name="getplayer">
									select rosterid, teamid, playername, playernumber, playerposition
									  from teamrosters
									 where rosterid = <cfqueryparam value="#trid#" cfsqltype="cf_sql_integer" />
								</cfquery>
								<cfquery name="deleteplayer">
									delete from teamrosters
									where rosterid = <cfqueryparam value="#trid#" cfsqltype="cf_sql_integer" />
								</cfquery>
									<!--- // record the activity --->
									<cfquery name="activitylog">
										insert into activity(userid, activitydate, activitytype, activitytext)														  													   
											values(
													<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
													<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
													<cfqueryparam value="Delete Record" cfsqltype="cf_sql_varchar" />,
													<cfqueryparam value="deleted team member #trid#: #getplayer.playername# on team: #teamdetail.teamname#." cfsqltype="cf_sql_varchar" />																
												  );
									</cfquery>
								<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&scope=d3" addtoken="no">							
							</cfif>
					<cfelse>
						<cflocation url="#application.root##url.event#" addtoken="yes">
					</cfif>
				</cfif>
				
									
					
				<cfoutput>					
					<div class="ibox" style="margin-top:-15px;">								
								
						<div class="ibox-title">
							<h5><i class="fa fa-group"></i> #teamdetail.teamorgname# Roster | All Players By Position</h5>
								<span class="pull-right">
									<a class="btn btn-xs btn-success" href="#application.root#&event=#url.event#&fuseaction=team.view&id=#url.id#"><i class="fa fa-arrow-circle-left"></i> Return to Team Detail</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-warning" href="#application.root#&event=#url.event#"><i class="fa fa-th-list"></i> Return to Team List</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-default" href="#application.root#admin.home"><i class="fa fa-home"></i> Admin Home</a>
								</span>							
						</div>								
								
						<div class="ibox-content" style="min-height:700px;">									
							
							<ul class="nav nav-tabs">
									<li><a href="#application.root##url.event#&fuseaction=team.view&id=#url.id#"><i class="fa fa-check-circle"></i> Team Details</a></li>
									<li class="active"><a href="#application.root##url.event#&fuseaction=team.roster&id=#url.id#"><i class="fa fa-soccer-ball-o"></i> Team Roster</a></li>
									<li><a href="#application.root##url.event#&fuseaction=team.contacts&id=#url.id#"><i class="fa fa-briefcase"></i> Team Contacts</a></li>
									<li><a href="#application.root##url.event#&fuseaction=team.schedule&id=#url.id#"><i class="fa fa-clock-o"></i> Team Schedule</a></li>
									<!---
									<li><a href="">Menu 2</a></li>
									<li><a href="">Menu 2</a></li>
									--->
								</ul>
								<div class="tab-content" style="margin-top:25px;">
								    <div id="teamroster" class="tab-pane fade in active">						
										<div class="col-lg-8">											
											<cfif structkeyexists( url, "scope" )>								
												<cfif trim( url.scope ) is "a1">
													<div class="alert alert-warning">
													  <strong><i class="fa fa-info-circle"></i> SUCCESS!</strong> The team player was successfully added.
													</div>									
												<cfelseif trim( url.scope ) is "b2">
													<div class="alert alert-success">
													  <strong><i class="fa fa-check-circle"></i> SUCCESS!</strong> The team player was successfully updated.
													</div>
												<cfelseif trim( url.scope ) is "d3">
													<div class="alert alert-danger">
													  <strong><i class="fa fa-warning"></i> WARNING!</strong> The team player was successfully deleted.
													</div>										
												</cfif>
											</cfif>
											
											
											<cfif teamroster.recordcount gt 0>
												<div class="table-responsive">									
													<table class="table table-striped">
														<thead>
															<tr>										
																<th>Name</th>
																<th>Position</th>
																<th>Number</th>
																<th>Status</th>
															</tr>
														</thead>
														<tbody>
															<cfloop query="teamroster">
																<tr>														
																	<td><a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&trid=#rosterid#">#playername#</a></td>
																	<td>#playerposition#</td>
																	<td>#playernumber#</td>
																	<td><cfif playerstatus eq 1><i title="Active" class="fa fa-check-circle text-success"></i><cfelse><i title="Inactive" class="fa fa-ban text-danger"></cfif></td>
																</tr>
															</cfloop>
														</tbody>
														<tfoot>
															<tr><td colspan="5"><small><i class="fa fa-info"></i> Click the player name to edit details.<span class="pull-right"><i class="fa fa-check-circle text-success"></i> Active Player</span></td></small></tr>
														</tfoot>
													</table>
												</div>
											<cfelse>
												<div class="alert alert-danger alert-box">
													<h5><i class="fa fa-warning"></i> Team Roster Not Found. </h5> 
													<p>Please use the form to the right to begin adding players for #teamdetail.teamname#.</p>
												</div>
											</cfif>								
										</div>
										<div class="col-lg-4">
											
											<!-- form processing -->
											<cfif isDefined( "form.fieldnames" ) and structkeyexists( form, "playerid" ) and structkeyexists( form, "teamid" )>
													
												<cfset form.validate_require = "playerid|There was a form error.  Please try again.;playername|The player name is required.;playerposition|The player position is required.;playernumber|The player number is required.;teamid|There was an internal error posting this form.  Please go back and try again.;" />
													
													<cfscript>
														objValidation = createobject( "component","apis.udfs.validation" ).init();
														objValidation.setFields( form );
														objValidation.validate();
													</cfscript>

													<cfif objValidation.getErrorCount() is 0>																									
																	
														<!--- define our form structure and set form values --->
														<cfset tr = structnew() />
														<cfset tr.teamid = form.teamid />
														<cfset tr.playerid = form.playerid />
														<cfset tr.playername = trim( form.playername ) />
														<cfset tr.playerposition = trim( form.playerposition ) />
														<cfset tr.playernumber = form.playernumber />
														
														<cfif structkeyexists( form, "isactive" )>
															<cfset tr.isactive = 1 />
														<cfelse>
															<cfset tr.isactive = 0 />
														</cfif>
														
														
														<cfif tr.playerid eq 0>
														
															<!--- // add team contact data operation --->													
															<cfquery name="addteammember">
																insert into teamrosters(teamid, playername, playerposition, playernumber, playerstatus)
																	values(
																			<cfqueryparam value="#tr.teamid#" cfsqltype="cf_sql_integer" />,
																			<cfqueryparam value="#tr.playername#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																			<cfqueryparam value="#tr.playerposition#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																			<cfqueryparam value="#tr.playernumber#" cfsqltype="cf_sql_numeric" />,
																			<cfqueryparam value="1" cfsqltype="cf_sql_bit" />																
																		  );
															</cfquery>										
																
																
															<!--- // record the activity --->
															<cfquery name="activitylog">
																insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																	values(
																			<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																			<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																			<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																			<cfqueryparam value="added team member #tr.playername# for #teamdetail.teamname#." cfsqltype="cf_sql_varchar" />																
																		   );
															</cfquery>
																
															<cflocation url="#application.root##url.event#&fuseaction=team.roster&id=#tr.teamid#&scope=a1" addtoken="no">			
														
														
														<!---   tr.playerid is not zero --->
														<cfelse>

															<!--- //  update the team contact --->													
															<cfquery name="updateteamroster">
																update teamrosters
																   set playername = <cfqueryparam value="#tr.playername#" cfsqltype="cf_sql_varchar" />,
																	   playerposition = <cfqueryparam value="#tr.playerposition#" cfsqltype="cf_sql_varchar" />,
																	   playernumber = <cfqueryparam value="#tr.playernumber#" cfsqltype="cf_sql_numeric" />,
																	   playerstatus = <cfqueryparam value="#tr.isactive#" cfsqltype="cf_sql_bit" />
																 where rosterid = <cfqueryparam value="#tr.playerid#" cfsqltype="cf_sql_integer" />
															</cfquery>										
																
																
															<!--- // record the activity --->
															<cfquery name="activitylog">
																insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																	values(
																			<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																			<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																			<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																			<cfqueryparam value="updated team member: #tr.playerid#, #tr.playername# for #teamdetail.teamname#." cfsqltype="cf_sql_varchar" />																
																		   );
															</cfquery>
																
															<cflocation url="#application.root##url.event#&fuseaction=team.roster&id=#tr.teamid#&scope=b2" addtoken="no">

														</cfif>
													<!--- If the required data is missing - throw the validation error --->
													<cfelse>
														
														<div class="alert alert-danger alert-dismissable">
															<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h2>
																<ul>
																	<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
																		<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
																	</cfloop>
																</ul>
														</div>				
															
													</cfif>										
														
											</cfif>
											<!--- // end form processing --->					
											
											
											
											
											
											
											
											<cfif structkeyexists( url, "trid" )>
											
												<form name="teamroster" class="form-horizontal" method="post" action="">
													
													<h5 style="margin-bottom:15px;"><i class="fa fa-check-circle"></i> Edit Team Member: #playerdetails.playername#</h5>
													
													<div class="form-group">
														<label class="col-lg-2 control-label">Name</label>
														<div class="col-lg-10">
															<input type="text" class="form-control" placeholder="Enter Player Name" name="playername" <cfif structkeyexists( form, "playername" )>value="#trim( form.playername )#"<cfelse>value="#trim( playerdetails.playername )#"</cfif>  />
															<input type="hidden" name="teamid" value="#playerdetails.teamid#" />
														</div>
													</div>
																
													<div class="form-group">
														<label class="col-lg-2 control-label">Position</label>
														<div class="col-lg-10">
															<input type="text" class="form-control" placeholder="Position" name="playerposition" <cfif structkeyexists( form, "playerposition" )>value="#trim( form.playerposition )#"<cfelse>value="#trim( playerdetails.playerposition )#"</cfif>  />
														</div>
													</div>
													
													<div class="form-group">
														<label class="col-lg-2 control-label">Number</label>
														<div class="col-lg-10">
															<input type="text" class="form-control" placeholder="Player Number" name="playernumber" <cfif structkeyexists( form, "playernumber" )>value="#trim( form.playernumber )#"<cfelse>value="#trim( playerdetails.playernumber )#"</cfif> />
														</div>
													</div>

													<div class="form-group">
														<div class="col-sm10 col-sm-offset-2">
															<label class="checkbox-inline"><input style="margin-left:3px;" type="checkbox" name="isactive" value="1" <cfif playerdetails.playerstatus eq 1>checked</cfif>><span style="margin-left:20px;">Active Status</span></label>
														</div>
													</div>
															
													<div class="form-group">
														<div class="col-sm-10 col-sm-offset-2">
															<button class="btn btn-sm btn-success" type="submit"><i class="fa fa-save"></i> Update Player</button>
															<a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&id=#url.id#" class="btn btn-sm btn-white" type="submit"><i class="fa fa-remove"></i> Cancel</a>													
															<input type="hidden" name="playerid" value="#playerdetails.rosterid#" />
															<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&trid=#playerdetails.rosterid#&deleteTeamMember=True" onclick="return confirm('Are you sure you want to remove this player from the team?');" style="margin-left:4px;" title="Delete Team Member"><small><i class="fa fa-trash"></i></small></a>
														</div>
													</div>
													
													
												</form>
											
											
											<cfelse>								
												
												<!--- // new team contact --->
												<form name="teamcontact" class="form-horizontal" method="post" action="">
													
													<h5 style="margin-bottom:15px;"><i class="fa fa-check-circle"></i> Add New Team Player</h5>
													
													<div class="form-group">
														<label class="col-lg-2 control-label">Name</label>
														<div class="col-lg-10">
															<input type="text" class="form-control" placeholder="Enter Player Name" name="playername" <cfif structkeyexists( form, "playername" )>value="#trim( form.playername )#"</cfif>  />
															<input type="hidden" name="teamid" value="#teamdetail.teamid#" />
														</div>
													</div>
																
													<div class="form-group">
														<label class="col-lg-2 control-label">Position</label>
														<div class="col-lg-10">
															<input type="text" class="form-control" placeholder="Player Position" name="playerposition" <cfif structkeyexists( form, "playerposition" )>value="#trim( form.playerposition )#"</cfif>  />
														</div>
													</div>
													
													<div class="form-group">
														<label class="col-lg-2 control-label">Number</label>
														<div class="col-lg-10">
															<input type="text" class="form-control" placeholder="Player Number" name="playernumber" <cfif structkeyexists( form, "playernumber" )>value="#trim( form.playernumber )#"</cfif> />
														</div>
													</div>																	
															
													<div class="form-group">
														<div class="col-sm-10 col-sm-offset-2">
															<button class="btn btn-sm btn-primary" type="submit"><i class="fa fa-save"></i> Save Player</button>
															<a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&id=#url.id#" class="btn btn-sm btn-white" type="submit"><i class="fa fa-remove"></i> Cancel</a>													
															<input type="hidden" name="playerid" value="0" />
														</div>
													</div>
													
													
												</form>
											</cfif>
										</div>
									</div>
								</div>
						</div>
					</div>
				</cfoutput>
							
						