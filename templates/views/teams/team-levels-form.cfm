






					


												<div class="ibox">
													<div class="ibox-title">
														<h5>
															<cfif not structkeyexists( url, "id" )>
																<i class="fa fa-plus"></i> Add Team Level
															<cfelse>
																<cfinvoke component="apis.com.admin.teamadminservice" method="getteamlevel" returnvariable="teamlevel">
																	<cfinvokeargument name="id" value="#url.id#">
																</cfinvoke>
																<i class="fa fa-edit"></i> Edit Team Level
															</cfif>
														</h5>
													</div>
													<div class="ibox-content">								
														
														<!--- // begin form processing --->
														<cfif isdefined( "form.fieldnames" ) and structkeyexists( form, "add-new-team-level" )>
														
															<cfset form.validate_require = "tlid|Ops, internal form error...;teamlevelname|Please enter a team level name.;teamlevelcode|Please enter a team level code (i.e. JV for Junior Varsity).;teamlevelconftype|Please select the conference type." />																
														
															<cfscript>
																objValidation = createobject( "component","apis.udfs.validation" ).init();
																objValidation.setFields( form );
																objValidation.validate();
															</cfscript>

															<cfif objValidation.getErrorCount() is 0>							
																
																<cfset tl = structnew() />
																<cfset tl.tlid = form.tlid />
																<cfset tl.teamlevelname = trim( form.teamlevelname ) />
																<cfset tl.teamlevelconftype = trim( form.teamlevelconftype ) />
																<cfset tl.teamlevelcode = trim( form.teamlevelcode ) />
																<cfset tl.confid = form.confid />
																
																<cfif tl.tlid eq 0>
																
																	<cfquery name="addteamlevel">
																		insert into teamlevels(teamlevelname, teamlevelconftype, teamlevelcode, confid)
																		 values(
																				<cfqueryparam value="#tl.teamlevelname#" cfsqltype="cf_sql_varchar" />,																				
																				<cfqueryparam value="#tl.teamlevelconftype#" cfsqltype="cf_sql_varchar" maxlength="2" />,
																				<cfqueryparam value="#tl.teamlevelcode#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#tl.confid#" cfsqltype="cf_sql_integer" />
																				);
																	</cfquery>										
																	
																	<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&scope=1" addtoken="no">			
																
																<cfelse>
																
																	<cfquery name="editteamlevel">
																		update teamlevels
																		   set teamlevelname = <cfqueryparam value="#tl.teamlevelname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																			   teamlevelcode = <cfqueryparam value="#tl.teamlevelcode#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																			   teamlevelconftype = <cfqueryparam value="#tl.teamlevelconftype#" cfsqltype="cf_sql_varchar" maxlength="2" />																	   
																		 where teamlevelid = <cfqueryparam value="#tl.tlid#" cfsqltype="cf_sql_integer" />																			
																	</cfquery>										
																	
																	<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&scope=2" addtoken="no">			
																
																
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
														
														
														
														
														<cfoutput>
															<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#">
																<cfif not structkeyexists( url, "id" )>
																	<p class="small">Please enter the team level details...</p>
																<cfelse>
																	<p class="small">Please edit the team level details...</p>
																</cfif>
																
																<div class="form-group">
																	<label class="col-lg-2 control-label">Type</label>
																	<div class="col-lg-10">
																		<div class="i-checks"><label> <input type="radio" value="YF" name="teamlevelconftype" <cfif structkeyexists( form, "teamlevelconftype" ) and trim( form.teamlevelconftype ) eq "YF">checked <cfelseif structkeyexists( url, "id" ) and trim( teamlevel.teamlevelconftype ) eq "YF">checked</cfif> /> <i></i> Youth Football</label></div>
																		<div class="i-checks"><label> <input type="radio" value="HS" name="teamlevelconftype" <cfif structkeyexists( form, "teamlevelconftype" ) and trim( form.teamlevelconftype ) eq "HS">checked <cfelseif structkeyexists( url, "id" ) and trim( teamlevel.teamlevelconftype ) eq "HS">checked</cfif> /> <i></i> High School Football </label></div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="col-lg-2 control-label">Name</label>
																	<div class="col-lg-10">
																		<input type="name" placeholder="Team Level Name" name="teamlevelname" class="form-control" <cfif structkeyexists( form, "teamlevelname" )>value="#trim( form.teamlevelname )#"<cfelseif structkeyexists( url, "id" )>value="#trim( teamlevel.teamlevelname )#"</cfif> />									
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-lg-2 control-label">Title</label>
																	<div class="col-lg-10">
																		<input type="text" placeholder="Team Level Code" name="teamlevelcode" class="form-control" <cfif structkeyexists( form, "teamlevelcode" )>value="#trim( form.teamlevelcode )#"<cfelseif structkeyexists( url, "id" )>value="#trim( teamlevel.teamlevelcode )#"</cfif> />								
																	</div>
																</div>
																				                                
																<div class="form-group">
																	<div class="col-lg-offset-2 col-lg-10">
																		<cfif not structkeyexists( url, "id" )>
																			<button class="btn btn-sm btn-white" type="submit"><i class="fa fa-save"></i> Add Team Level</button>
																			<input type="hidden" name="tlid" value="0" />
																			<input type="hidden" name="confid" value="<cfif structkeyexists( session, "conferenceid" )>#session.conferenceid#<cfelse>1</cfif>">
																		<cfelse>
																			<button class="btn btn-sm btn-white" type="submit"><i class="fa fa-save"></i> Save Team Level</button>
																			<input type="hidden" name="tlid" value="#url.id#" />
																			<input type="hidden" name="confid" value="<cfif structkeyexists( session, "conferenceid" )>#session.conferenceid#<cfelse>1</cfif>">
																			<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-sm btn-default"><i class="fa fa-remove"></i> Cancel</a>
																		</cfif>
																		<input type="hidden" name="add-new-team-level" value="1" />
																	</div>
																</div>
															</form>
														</cfoutput>
													</div>
												</div>