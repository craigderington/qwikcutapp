

			<!--- Scope the URL variable --->
			<cfparam name="user.role" default="shooter">

			<cfoutput>
					
				<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5><i class="fa fa-database"></i> Edit User | #userdetail.firstname# #userdetail.lastname#</h5>
						<div class="ibox-tools">
								<a href="#application.root##url.event#" class="btn btn-xs btn-white"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</div>
                    </div>						
                        
                     <div class="ibox-content">
                            
						<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset user = structnew() />											
											<cfset user.userid = form.userid />
											<cfset user.username = trim( form.username ) />
											<cfset user.firstname = trim( form.firstname ) />
											<cfset user.lastname = trim( form.lastname ) />
											<cfset user.email = trim( form.email ) />											
											<cfset user.role = trim( form.userrole ) />
											
											<cfif trim( form.pass1 ) neq "">
												<cfset user.password = trim( form.pass1 ) />
												<cfset user.confirmpassword = trim( form.pass2 ) />
											<cfelse>
												<cfset user.password = "" />
												<cfset user.confirmpassword = "" />												
											</cfif>
											
											<!--- // get user roles + acl value --->
											<cfswitch expression="#user.role#">
												<cfcase value="admin">
													<cfset user.acl = 9 />
												</cfcase>
												<cfcase value="shooter">
													<cfset user.acl = 5 />
												</cfcase>
												<cfcase value="data">
													<cfset user.acl = 4 />
												</cfcase>
												<cfdefaultcase>
													<cfset user.acl = 1 />
												</cfdefaultcase>
											</cfswitch>
											
											<!--- // check the password, if entered, and make sure they match --->
											<cfif comparenocase( user.password, user.confirmpassword ) neq 0>											
												<div class="alert alert-danger alert-dismissable">
												<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
													<h5><error>Sorry, there were errors in your submission:</error></h2>
														<ul>														
															<li class="formerror">The passwords you entered do not match.  Please try again...</li>														
														</ul>
												</div>
											
											<cfelse>
											
												<!--- edit the user record --->
												<cfquery name="edituser">
													update users
													   set firstname = <cfqueryparam value="#user.firstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   lastname = <cfqueryparam value="#user.lastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   email = <cfqueryparam value="#user.email#" cfsqltype="cf_sql_varchar" maxlength="50" />,													   
														   userrole = <cfqueryparam value="#user.role#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   useracl = <cfqueryparam value="#user.acl#" cfsqltype="cf_sql_numeric" />
														   <cfif trim( user.password ) neq "">
															, password = <cfqueryparam value="#hash( user.password, "SHA-384", "UTF-8" )#" cfsqltype="cf_sql_clob" maxlength="128" />
														   </cfif>
													 where userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />														
												</cfquery>

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="updated the user #user.username# in the system." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>
													
												<!--- // redirect back to user list --->
												<cflocation url="#application.root##url.event#&scope=u2" addtoken="no">						
											
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
							
							
							
							
									<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#">
										<p></p>
										<div class="form-group">
											<label class="col-md-2 control-label">First Name</label>
											<div class="col-md-4">
												<input type="text" placeholder="First Name" class="form-control" name="firstname" value="#trim( userdetail.firstname )#" /> 
													<span class="help-block m-b-none">Please enter the first name of the user.</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 control-label">Last Name</label>
											<div class="col-md-4">
												<input type="text" placeholder="Last Name" class="form-control" maxlength="50" name="lastname" value="#trim( userdetail.lastname )#" />
													<span class="help-block m-b-none">Please enter the last name of the user.</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 control-label">Email</label>
											<div class="col-md-4">
												<input type="text" placeholder="Email Address" class="form-control" maxlength="50" name="email" value="#trim( userdetail.email )#" />
													<span class="help-block m-b-none">Please enter the email address of the user.</span>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 control-label">User Role</label>
											<div class="col-md-4">				
												<select class="form-control" multiple="true" name="userrole">
													<option value="admin"<cfif trim( userdetail.userrole ) eq "admin">selected</cfif>>Admin</option>
													<option value="shooter"<cfif trim( userdetail.userrole ) eq "shooter">selected</cfif>>Shooter</option>
													<option value="data"<cfif trim( userdetail.userrole ) eq "data">selected</cfif>>Data & Analytics</option>
													<option value="future-use"<cfif trim( userdetail.userrole ) eq "future-use">selected</cfif>>Future Use</option>
												</select>
												<span class="help-block m-b-none">Please select the system role of the user.</span>
											</div>
										</div>
										
										<hr class="hr-line-dashed">
										
										<div class="form-group">
											<label class="col-md-2 control-label">Password</label>
											<div class="col-md-4">
												<input type="password" placeholder="Enter Password" class="form-control" maxlength="50" name="pass1" />
													<span class="help-block m-b-none"><i class="fa fa-warning"></i> Please enter the password for the user.  Only enter if you are changing the user's password.</span>
											</div>
										</div>								
										
										<div class="form-group">
											<label class="col-md-2 control-label">Confirm Password</label>
											<div class="col-md-4">
												<input type="password" placeholder="Confirm Password" class="form-control" maxlength="50" name="pass2" />
											</div>
										</div>								
																	
										<br />
										<div class="hr-line-dashed" style-="margin-top:15px;"></div>
										<div class="form-group">
											<div class="col-lg-offset-2 col-lg-10">
												<button class="btn btn-primary" type="submit" name="stateUserRecord"><i class="fa fa-save"></i> Save User</button>
												<a href="#application.root#admin.users" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
												<input type="hidden" name="userid" value="#userdetail.userid#" />
												<input type="hidden" name="username" value="#userdetail.username#" />
												<input name="validate_require" type="hidden" value="email|The user's email address is required to add a new record.;firstname|The user's first name is required.;lastname|The user's last name is required.;userrole|Please select a user role from the list." />
												<input type="hidden" name="validate_email" value="email|The email address you entered is invalid.  Please try again..." />
											</div>
										</div>
									</form>
								</div>
							</div>
						</cfoutput>