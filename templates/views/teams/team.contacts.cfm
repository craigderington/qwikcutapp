




				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>
				
				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamcontacts" returnvariable="teamcontacts">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>
				
				<cfif structkeyexists( url, "tcid" ) and url.tcid is not "">
					<cfif isnumeric( url.tcid ) and url.tcid neq 0>
						<cfset tcid = url.tcid />
							<cfinvoke component="apis.com.admin.teamadminservice" method="getteamcontactdetails" returnvariable="teamcontactdetails">
								<cfinvokeargument name="tcid" value="#tcid#">
							</cfinvoke>
							<cfif structkeyexists( url, "deleteContact" ) and trim( url.deleteContact ) is "True">
								<cfquery name="getcontact">
									select contactid, contactname, teamid
									  from teamcontacts
									 where contactid = <cfqueryparam value="#tcid#" cfsqltype="cf_sql_integer" />
								</cfquery>
								<cfquery name="deletecontact">
									delete from teamcontacts
									where contactid = <cfqueryparam value="#tcid#" cfsqltype="cf_sql_integer" />
								</cfquery>
									<!--- // record the activity --->
									<cfquery name="activitylog">
										insert into activity(userid, activitydate, activitytype, activitytext)														  													   
											values(
													<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
													<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
													<cfqueryparam value="Delete Record" cfsqltype="cf_sql_varchar" />,
													<cfqueryparam value="deleted team contact #tcid#: #getcontact.contactname#, team ID #getcontact.teamid#." cfsqltype="cf_sql_varchar" />																
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
							<h5><i class="fa fa-group"></i> #teamdetail.teamorgname# Contacts</h5>
								<span class="pull-right">
									<a class="btn btn-xs btn-success" href="#application.root#&event=#url.event#&fuseaction=team.view&id=#url.id#"><i class="fa fa-arrow-circle-left"></i> Return to Team Detail</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-warning" href="#application.root#&event=#url.event#"><i class="fa fa-th-list"></i> Return to Team List</a> 
									<a style="margin-left:5px;" class="btn btn-xs btn-default" href="#application.root#admin.home"><i class="fa fa-home"></i> Admin Home</a>
								</span>							
						</div>								
								
						<div class="ibox-content" style="min-height:500px;">									
							<div class="col-lg-8">
								
								<cfif structkeyexists( url, "scope" )>								
									<cfif trim( url.scope ) is "a1">
										<div class="alert alert-warning">
										  <strong><i class="fa fa-info"></i> SUCCESS!</strong> The team contact was successfully added.
										</div>									
									<cfelseif trim( url.scope ) is "b2">
										<div class="alert alert-success">
										  <strong><i class="fa fa-exclamation"></i> SUCCESS!</strong> The team contact was successfully updated.
										</div>
									<cfelseif trim( url.scope ) is "d3">
										<div class="alert alert-danger">
										  <strong><i class="fa fa-warning"></i> WARNING!</strong> The team contact was successfully deleted.
										</div>										
									</cfif>
								</cfif>
								
								
								<cfif teamcontacts.recordcount gt 0>
									<div class="table-responsive">									
										<table class="table table-striped">
											<thead>
												<tr>										
													<th>Name</th>
													<th>Title</th>
													<th>Phone</th>
													<th>Email</th>
													<th>Txt Address</th>												
												</tr>
											</thead>
											<tbody>
												<cfloop query="teamcontacts">
													<tr>														
														<td><a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&tcid=#contactid#">#contactname#</a> <cfif contactactive eq 1> <i title="Active" class="fa fa-check-circle text-primary"></i></cfif></td>
														<td>#coachlastname#</td>
														<td>#contactnumber#</td>
														<td>#contactemail#</td>
														<td>#contactprovider#</td>
													</tr>
												</cfloop>
											</tbody>
											<tfoot>
												<tr><td colspan="5"><small><i class="fa fa-info"></i> Click the contact name to edit details.<span class="pull-right"><i class="fa fa-check-circle text-primary"></i> Active Contact</span>  </td></small></tr>
											</tfoot>
										</table>
									</div>
								<cfelse>
									<div class="alert alert-danger alert-box">
										<h5><i class="fa fa-warning"></i> No Team Contacts Found. </h5> 
										<p>Please use the form to the right to begin adding team contacts.</p>
									</div>
								</cfif>								
							</div>
							<div class="col-lg-4">
								
								<!-- form processing -->
								<cfif isDefined( "form.fieldnames" ) and structkeyexists( form, "teamid" )>
										
									<cfset form.validate_require = "contactid|There was a form error.  Please try again.;contactname|The contact name is required.;contactphone|The contact phone number is required.;contacttitle|Please enter the contacts title or position.;contactemail|The contact email is required.;teamid|There was an internal error posting this form.  Please go back and try again.;contactprovider|The mobile provider is required to send notifications." />
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>																									
														
											<!--- define our form structure and set form values --->
											<cfset tc = structnew() />
											<cfset tc.teamid = form.teamid />
											<cfset tc.contactname = trim( form.contactname ) />
											<cfset tc.contacttitle = trim( form.contacttitle ) />
											<cfset tc.contactemail = trim( form.contactemail ) />
											<cfset tc.contactphone = trim( form.contactphone ) />
											<cfset tc.contactprovider = trim( form.contactprovider ) />

											<cfif structkeyexists( form, "contactid" ) and isnumeric( form.contactid )>
												<cfset tc.contactid = form.contactid />
											<cfelse>
												<cfset tc.contactid = 0 />
											</cfif>
											
											<cfif structkeyexists( form, "isactive" )>
												<cfset tc.isactive = 1 />
											<cfelse>
												<cfset tc.isactive = 0 />
											</cfif>
											
											<cfif tc.contactid eq 0>
											
												<!--- // add team contact data operation --->													
												<cfquery name="addteamcontact">
													insert into teamcontacts(teamid, contactname, coachlastname, contactnumber, contactemail, contactprovider, contactactive, contactactivedate, numalerts)
														values(
																<cfqueryparam value="#tc.teamid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#tc.contactname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#tc.contacttitle#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#tc.contactphone#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#tc.contactemail#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#tc.contactprovider#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,																	
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" maxlength="50" />,
																<cfqueryparam value="0" cfsqltype="cf_sql_numeric" />
															  );
												</cfquery>										
													
													
												<!--- // record the activity --->
												<cfquery name="activitylog">
													insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="added team contact #tc.contactname# for #teamdetail.teamname#." cfsqltype="cf_sql_varchar" />																
															   );
												</cfquery>
													
												<cflocation url="#application.root##url.event#&fuseaction=team.contacts&id=#tc.teamid#&scope=a1" addtoken="no">			
											
											
											<!---   tc.contactid is not zero --->
											<cfelse>

												<!--- //  update the team contact --->													
												<cfquery name="addteamcontact">
													update teamcontacts
													   set contactname = <cfqueryparam value="#tc.contactname#" cfsqltype="cf_sql_varchar" maxlength="50" />, 
													       coachlastname = <cfqueryparam value="#tc.contacttitle#" cfsqltype="cf_sql_varchar" maxlength="50" />, 
														   contactnumber = <cfqueryparam value="#tc.contactphone#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   contactemail = <cfqueryparam value="#tc.contactemail#" cfsqltype="cf_sql_varchar" maxlength="50" />, 
														   contactprovider = <cfqueryparam value="#tc.contactprovider#" cfsqltype="cf_sql_varchar" maxlength="50" />, 
														   contactactive = <cfqueryparam value="#tc.isactive#" cfsqltype="cf_sql_bit" />																
													 where contactid = <cfqueryparam value="#tc.contactid#" cfsqltype="cf_sql_integer" />
												</cfquery>										
													
													
												<!--- // record the activity --->
												<cfquery name="activitylog">
													insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="added team contact #tc.contactname# for #teamdetail.teamname#." cfsqltype="cf_sql_varchar" />																
															   );
												</cfquery>
													
												<cflocation url="#application.root##url.event#&fuseaction=team.contacts&id=#tc.teamid#&scope=b2" addtoken="no">

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
								
								
								
								
								
								
								
								<cfif structkeyexists( url, "tcid" )>
								
									<form name="teamcontact" class="form-horizontal" method="post" action="">
										
										<h5 style="margin-bottom:15px;"><i class="fa fa-check-circle"></i> Edit Team Contact: #teamcontactdetails.contactname#</h5>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Name</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Enter Contact Name" name="contactname" <cfif structkeyexists( form, "contactname" )>value="#trim( form.contactname )#"<cfelse>value="#trim( teamcontactdetails.contactname )#"</cfif>  />
												<input type="hidden" name="teamid" value="#teamdetail.teamid#" />
											</div>
										</div>
													
										<div class="form-group">
											<label class="col-lg-2 control-label">Title</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Contact Title" name="contacttitle" <cfif structkeyexists( form, "contacttitle" )>value="#trim( form.contacttitle )#"<cfelse>value="#trim( teamcontactdetails.coachlastname )#"</cfif>  />
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Phone</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Contact Phone Number" name="contactphone" <cfif structkeyexists( form, "contactphone" )>value="#trim( form.contactphone )#"<cfelse>value="#trim( teamcontactdetails.contactnumber )#"</cfif> />
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Email</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Contact Email Address" name="contactemail" <cfif structkeyexists( form, "contactemail" )>value="#trim( form.contactemail )#"<cfelse>value="#trim( teamcontactdetails.contactemail )#"</cfif> />
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Provider</label>
											<div class="col-lg-10">
												<select name="contactprovider" id="contactprovider" class="form-control">
													<option value="" selected>Select Mobile Provider</option>															  
													<option value="@txt.att.net"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@txt.att.net">selected<cfelseif teamcontactdetails.contactprovider is "@txt.att.net">selected</cfif>>AT&amp;T</option>
													<option value="@message.alltel.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@message.alltel.com">selected<cfelseif teamcontactdetails.contactprovider is "@message.alltel.com">selected</cfif>>Alltel</option>
													<option value="@myboostmobile.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@myboostmobile.com">selected<cfelseif teamcontactdetails.contactprovider is "@myboostmobile.com">selected</cfif>>Boost Mobile</option>
													<option value="@mycellone.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@mycellone.com">selected<cfelseif teamcontactdetails.contactprovider is "@mycellone.com">selected</cfif>>Cellular South</option>
													<option value="@cingularme.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@cingularme.com">selected<cfelseif teamcontactdetails.contactprovider is "@cingularme.com">selected</cfif>>Consumer Cellular</option>
													<option value="@mymetropcs.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@mymetropcs.com">selected<cfelseif teamcontactdetails.contactprovider is "@mymetropcs.com">selected</cfif>>Metro PCS</option>
													<option value="@messaging.nextel.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@messaging.nextel.com">selected<cfelseif teamcontactdetails.contactprovider is "@messaging.nextel.com">selected</cfif>>Nextel</option>
													<option value="@messaging.sprintpcs.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@messaging.sprintpcs.com">selected<cfelseif teamcontactdetails.contactprovider is "@messaging.sprintpcs.com">selected</cfif>>Sprint</option>
													<option value="@gmomail.net"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@gmomail.net">selected<cfelseif teamcontactdetails.contactprovider is "@gmomail.net">selected</cfif>>T-Mobile</option>
													<option value="@vtext.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@vtext.com">selected<cfelseif teamcontactdetails.contactprovider is "@vtext.com">selected</cfif>>Verizon</option>
													<option value="@vmobl.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@vmobl.com">selected <cfelseif teamcontactdetails.contactprovider is "@vmobl.com">selected</cfif>>Virgin Mobile</option>
													<option value="@noprovider"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@provider">selected<cfelseif teamcontactdetails.contactprovider is "@noprovider">selected</cfif>>None of these</option>
												</select>
											</div>
										</div>
										
										<div class="form-group">											
											<div class="col-sm10 col-sm-offset-2">
												<label class="checkbox-inline"><input type="checkbox" name="isactive" value="1" <cfif teamcontactdetails.contactactive eq 1>checked</cfif>>Active Status</label>
											</div>
										</div>
												
										<div class="form-group">
											<div class="col-sm-10 col-sm-offset-2">
												<button class="btn btn-sm btn-success" type="submit"><i class="fa fa-save"></i> Update Team Contact</button>
												<a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&id=#url.id#" class="btn btn-sm btn-white" type="submit"><i class="fa fa-remove"></i> Cancel</a>													
												<input type="hidden" name="contactid" value="#teamcontactdetails.contactid#" />
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&tcid=#teamcontactdetails.contactid#&deleteContact=True" onclick="return confirm('Are you sure you want to delete this contact?');" style="margin-left:4px;" title="Delete Contact"><small><i class="fa fa-trash"></i></small></a>
											</div>
										</div>
										
										
									</form>
								
								
								<cfelse>								
									
									<!--- // new team contact --->
									<form name="teamcontact" class="form-horizontal" method="post" action="">
										
										<h5 style="margin-bottom:15px;"><i class="fa fa-check-circle"></i> Add New Team Contact</h5>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Name</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Enter Contact Name" name="contactname" <cfif structkeyexists( form, "contactname" )>value="#trim( form.contactname )#"</cfif>  />
												<input type="hidden" name="teamid" value="#teamdetail.teamid#" />
											</div>
										</div>
													
										<div class="form-group">
											<label class="col-lg-2 control-label">Title</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Contact Title" name="contacttitle" <cfif structkeyexists( form, "contacttitle" )>value="#trim( form.contacttitle )#"</cfif>  />
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Phone</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Contact Phone Number" name="contactphone" <cfif structkeyexists( form, "contactphone" )>value="#trim( form.contactphone )#"</cfif> />
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Email</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" placeholder="Contact Email Address" name="contactemail" <cfif structkeyexists( form, "contactemail" )>value="#trim( form.contactemail )#"</cfif> />
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-2 control-label">Provider</label>
											<div class="col-lg-10">
												<select name="contactprovider" id="contactprovider" class="form-control">
													<option value="" selected>Select Mobile Provider</option>															  
													<option value="@txt.att.net"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@txt.att.net">selected</cfif>>AT&amp;T</option>
													<option value="@message.alltel.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@message.alltel.com">selected</cfif>>Alltel</option>
													<option value="@myboostmobile.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@myboostmobile.com">selected</cfif>>Boost Mobile</option>
													<option value="@mycellone.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@mycellone.com">selected</cfif>>Cellular South</option>
													<option value="@cingularme.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@cingularme.com">selected</cfif>>Consumer Cellular</option>
													<option value="@mymetropcs.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@mymetropcs.com">selected</cfif>>Metro PCS</option>
													<option value="@messaging.nextel.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@messaging.nextel.com">selected</cfif>>Nextel</option>
													<option value="@messaging.sprintpcs.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@messaging.sprintpcs.com">selected</cfif>>Sprint</option>
													<option value="@gmomail.net"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@gmomail.net">selected</cfif>>T-Mobile</option>
													<option value="@vtext.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@vtext.com">selected</cfif>>Verizon</option>
													<option value="@vmobl.com"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@vmobl.com">selected</cfif>>Virgin Mobile</option>
													<option value="@noprovider"<cfif structkeyexists( form, "contactprovider" ) and form.contactprovider is "@provider">selected</cfif>>None of these</option>
												</select>
											</div>
										</div>								
												
										<div class="form-group">
											<div class="col-sm-10 col-sm-offset-2">
												<button class="btn btn-sm btn-primary" type="submit"><i class="fa fa-save"></i> Save Team Contact</button>
												<a href="#application.root##url.event#&fuseaction=#trim( url.fuseaction )#&id=#url.id#" class="btn btn-sm btn-white" type="submit"><i class="fa fa-remove"></i> Cancel</a>													
												<input type="hidden" name="contactid" value="0" />
											</div>
										</div>
										
										
									</form>
								</cfif>
							</div>
						</div>
					</div>
				</cfoutput>
							
						