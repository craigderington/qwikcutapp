

	
	
	
			<!--- // get our default data object --->
			<cfinvoke component="apis.com.user.userservice" method="getusersettings" returnvariable="usersettings">
				<cfinvokeargument name="id" value="#session.userid#">
			</cfinvoke>
			

				
			<cfoutput>	
				<div class="wrapper wrapper-content animated fadeInRight">
					<div class="row" style="margin-top:25px;">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-th-list"></i> #session.username# | User Settings</h5>
								<span class="pull-right">
									<a href="#application.root#user.home" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-dashboard"></i> Dashboard</a>
								</span>								
							</div>
							<div class="ibox-content">
							
								<cfif structkeyexists( url, "scope" )>
									<cfif trim( url.scope eq "p2" )>
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<h5><i class="fa fa-check-circle-o"></i> Your settings were successfully saved...</h5>
										</div>
									</cfif>
								</cfif>
								
								
								
								
								
								<!--- // begin form processing --->
									<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "saveUserSettings" )>
										
																				
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset user = structnew() />
											<cfset user.userid = session.userid />
											<cfset user.mailserver = trim( form.mailserveraddress ) />
											<cfset user.mailserverport = trim( form.mailserverport ) />
											<cfset user.mailserverusername = trim( form.mailserverusername ) />
											<cfset user.mailserverpassword =trim( form.mailserverpassword ) />
											
											<cfif trim( form.useralertpref) neq "">
												<cfset user.useralertpref = trim( form.useralertpref ) />
												<cfif structkeyexists( form, "serviceprovider" )>
													<cfset user.serviceprovider = trim( form.serviceprovider ) />
												<cfelse>
													<cfset user.serviceprovider = "" />	
												</cfif>
											<cfelse>
												<cfset user.useralertpref = "" />
												<cfset user.serviceprovider = "" />											
											</cfif>
											
											<!--- // check the password, if entered, and make sure they match --->
											<cfif trim( user.useralertpref ) eq "txtmsg" and trim( user.serviceprovider ) eq "">											
												<div class="alert alert-danger alert-dismissable">
												<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
													<h5><i class="fa fa-warning"></i> <error>Sorry, there were errors in your submission:</error></h2>
														<ul>														
															<li class="formerror">You selected <strong>Text Message</strong> as your alert preference, but you did not select a service provider.</li>														
														</ul>
												</div>
											
											<cfelse>																					
												
												<!--- //  execute the update --->
												<cfquery name="saveusersettings">
													update usersettings
													   set useralertpref = <cfqueryparam value="#user.useralertpref#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   usertextmsgaddress = <cfqueryparam value="#user.serviceprovider#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   mailserver = <cfqueryparam value="#user.mailserver#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   mailserverport = <cfqueryparam value="#user.mailserverport#" cfsqltype="cf_sql_numeric" />,
														   mailserverusername = <cfqueryparam value="#user.mailserverusername#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   mailserverpassword = <cfqueryparam value="#user.mailserverpassword#" cfsqltype="cf_sql_varchar" maxlength="50" />
													 where userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />														
												</cfquery>
												
													<!--- check to see if our user is a shooter --->
													<cfquery name="chkshooter">
														select shooterid, userid
														  from shooters
														 where userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />
													</cfquery>
													
													<!--- // ok, we found a valid shooter id, update the shooter profile --->
													<cfif chkshooter.recordcount gt 0>
														<cfquery name="saveshooterprofile">
															update shooters
															   set shooteralertpref = <cfqueryparam value="#user.useralertpref#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														           shootercellprovider = <cfqueryparam value="#user.serviceprovider#" cfsqltype="cf_sql_varchar" maxlength="50" />
															 where shooterid = <cfqueryparam value="#chkshooter.shooterid#" cfsqltype="cf_sql_integer" />
														</cfquery>											
													</cfif>

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="updated the user settings." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>
												
													<!--- // redirect --->
													<cflocation url="#application.root##url.event#&scope=p2" addtoken="no">
											
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





							
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class=""><a href="#application.root#user.profile"><i class="fa fa-user"></i> My Profile</a></li>
										<li class="active"><a href="#application.root#user.settings"><i class="fa fa-cog"></i> Settings</a></li>
										<li class=""><a href="#application.root#user.image"><i class="fa fa-image"></i> Profile Image</a></li>
										<li class=""><a href="#application.root#user.activity"><i class="fa fa-database"></i> User Activity</a></li>
									</ul>
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<form class="form-horizontal" method="post" name="savesettings" action="#application.root##url.event#">
													
													<div class="form-group" style="margin-top:15px;"><label class="col-sm-2 control-label">Alert Preference:</label>
														<div class="col-sm-6">
															<select name="useralertpref" class="form-control" id="useralertpref">
																<option value="">Select Alert Preference</option>
																<option value="txt"<cfif trim( usersettings.useralertpref ) eq "txt">selected</cfif>>Text Message</option>
																<option value="email"<cfif trim( usersettings.useralertpref ) eq "email">selected</cfif>>Email</option>
															</select>
														</div>
													</div>
													<cfif trim( usersettings.useralertpref ) eq "txt">
														<div class="form-group"><label class="col-sm-2 control-label">Service Provider:</label>
															<div class="col-sm-6">
																<select name="serviceprovider" id="serviceprovider" class="form-control">
																	<option value=""<cfif trim( usersettings.usertextmsgaddress ) eq "">selected</cfif>>Select Mobile Provider</option>															  
																	<option value="@txt.att.net"<cfif trim( usersettings.usertextmsgaddress ) eq "@txt.att.net">selected</cfif>>AT&amp;T</option>
																	<option value="@message.alltel.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@message.alltel.com">selected</cfif>>Alltel</option>
																	<option value="@myboostmobile.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@myboostmobile.com">selected</cfif>>Boost Mobile</option>
																	<option value="@mycellone.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@mycellone.com">selected</cfif>>Cellular South</option>
																	<option value="@cingularme.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@cingularme.com">selected</cfif>>Consumer Cellular</option>
																	<option value="@mymetropcs.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@mymetropcs.com">selected</cfif>>Metro PCS</option>
																	<option value="@messaging.nextel.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@messaging.nextel.com">selected</cfif>>Nextel</option>
																	<option value="@messaging.sprintpcs.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@messaging.sprintpcs.com">selected</cfif>>Sprint</option>
																	<option value="@gmomail.net"<cfif trim( usersettings.usertextmsgaddress ) eq "@gmomail.net">selected</cfif>>T-Mobile</option>
																	<option value="@vtext.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@vtext.com">selected</cfif>>Verizon</option>
																	<option value="@vmobl.com"<cfif trim( usersettings.usertextmsgaddress ) eq "@vmobl.com">selected</cfif>>Virgin Mobile</option>
																	<option value="@noprovider"<cfif trim( usersettings.usertextmsgaddress ) eq "@noprovider">selected</cfif>>None of these</option>
																</select>
															</div>
														</div>
													</cfif>														
													
													<div class="hr-line-dashed" style="margin-top:15px;"></div>											
													
													<!--- // mail server for CFPOP or CFIMAP --->
													<div class="form-group"><label class="col-sm-2 control-label">Mail Server Address:</label>
														<div class="col-sm-6">
															<input type="text" class="form-control" placeholder="Mail Server Address" name="mailserveraddress" value="#trim( usersettings.mailserver)#" />
															<span class="help-block m-b-none">Example: mail.domain.com</span> 
														</div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">Mail Server Port:</label>
														<div class="col-sm-6"><input type="text" class="form-control" placeholder="Mail Server Port" name="mailserverport" value="#trim( usersettings.mailserverport )#" /></div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">Mail Username:</label>
														<div class="col-sm-6"><input type="text" class="form-control" placeholder="Mail Server Username" name="mailserverusername" value="#trim( usersettings.mailserverusername )#" /></div>
													</div>																							
													<div class="form-group"><label class="col-sm-2 control-label">Mail Password:</label>
														<div class="col-sm-6">
															<input type="text" class="form-control" placeholder="Mail Server Password" name="mailserverpassword" value="#trim( usersettings.mailserverpassword )#" />
														</div>
													</div>													
													<div class="hr-line-dashed" style="margin-top:15px;"></div>
													
													<div class="form-group">
														<div class="col-lg-offset-2 col-lg-6">
															<button class="btn btn-primary" type="submit" name="saveUserSettings"><i class="fa fa-save"></i> Save Settings</button>
															<a href="#application.root#user.home" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
														</div>
													</div>
												</form>
											</div>
										</div>                              
									</div>
								</div>
							</div>
						</div> 
					</div>
				</div>
			</cfoutput>