

			<!--- Scope the URL variable --->
			<cfparam name="user.role" default="shooter">

				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> <cfif structkeyexists( url, "userType" )><span class="text-danger">Add New Stats App User</span><cfelse>Add New User</cfif></h5>                        						
							<div class="ibox-tools">
								<a href="#application.root##url.event#" class="btn btn-xs btn-white"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</div>
						</div>
                        <div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "saveUserRecord" )>
										
										<cfset form.validate_require = "email|The user's email address is required to add a new record.;firstname|The user's first name is required.;lastname|The user's last name is required.;userrole|Please select a user role from the list.;pass1|The user's password is required." />
										<cfset form.validate_password = "pass1|pass2|Sorry, the passwords entered do not match.  Please try again..." />
										<cfset form.validate_email = "email|The email address you entered is invalid.  Please try again..." />									
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset users = structnew() />
											<cfset user.username = trim( form.email ) />
											<cfset user.firstname = trim( form.firstname ) />
											<cfset user.lastname = trim( form.lastname ) />
											<cfset user.email = trim( form.email ) />
											<cfset user.password = trim( form.pass1 ) />
											<cfset user.role = trim( form.userrole ) />
											<cfset user.stateid = session.stateid />
											<cfif structkeyexists( form, "teamname" )>
												<cfset user.teamname = trim( form.teamname ) />
											<cfelse>
												<cfset user.teamname = "None" />
											</cfif>
											
											<!--- // get user roles + acl value --->
											<cfswitch expression="#user.role#">
												<cfcase value="admin">
													<cfset user.acl = 9 />
												</cfcase>
												<cfcase value="confadmin">
													<cfset user.acl = 7 />
												</cfcase>
												<cfcase value="shooter">
													<cfset user.acl = 5 />
												</cfcase>
												<cfcase value="data">
													<cfset user.acl = 4 />
												</cfcase>
												<cfcase value="statsapi">
													<cfset user.acl = 3 />
												</cfcase>
												<cfdefaultcase>
													<cfset user.acl = 1 />
												</cfdefaultcase>
											</cfswitch>
											
												<!--- // check the database and make sure the user name/email is unique --->
												<cfquery name="chkUser">
													select userid, email, username
													  from dbo.users
													 where username = <cfqueryparam value="#user.username#" cfsqltype="cf_sql_varchar" /> 
												</cfquery>
												
												<!--- // if a dupe if found, throw error --->
												<cfif chkUser.recordcount neq 0>
													
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<h5><error>Sorry, the system ran into a problem creating this user profile.  </error></h2>
																<ul>														
																	<li class="formerror"><cfoutput>A user with an ID of #chkUser.userid# and email address matching <i>#chkUser.email#</i> was already found in the system.  The operation was aborted.</cfoutput></li>
																</ul>
													</div>
												
												<cfelse>										
												
													<!--- add the new user record --->
													<cfquery name="adduser">
														insert into users(username, firstname, lastname, email, password, userrole, useracl, stateid, teamname)
														 values(
																<cfqueryparam value="#user.username#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.firstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.lastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.email#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#hash( user.password, "SHA-384", "UTF-8" )#" cfsqltype="cf_sql_clob" maxlength="128" />,
																<cfqueryparam value="#user.role#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.acl#" cfsqltype="cf_sql_numeric" />,
																<cfqueryparam value="#user.stateid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#user.teamname#" cfsqltype="cf_sql_varchar" />
																); select @@identity as newuserid
													</cfquery>
													
													<!--- create user settings record in table --->
													<cfquery name="adduser">
														insert into usersettings(userid)
														 values(
																<cfqueryparam value="#adduser.newuserid#" cfsqltype="cf_sql_integer" />																
																);
													</cfquery>
													
													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="added the user #user.username# to the system." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>
													
													<!--- // redirect back to user list --->
													<cflocation url="#application.root##url.event#&scope=u1" addtoken="no">			
											
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
							
							
							
							
							
							<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#<cfif structkeyexists( url, "usertype" )>&userType=#trim( url.usertype )#</cfif>">
                                <p></p>
                                <div class="form-group">
									<label class="col-md-2 control-label">First Name</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="First Name" class="form-control" name="firstname" <cfif structkeyexists( form, "firstname" )>value="#trim( form.firstname )#"</cfif> /> 
											<span class="help-block m-b-none">Please enter the first name of the user.</span>
                                    </div>
                                </div>
                                <div class="form-group">
									<label class="col-md-2 control-label">Last Name</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="Last Name" class="form-control" maxlength="50" name="lastname" <cfif structkeyexists( form, "lastname" )>value="#trim( form.lastname )#"</cfif>/>
											<span class="help-block m-b-none">Please enter the last name of the user.</span>
									</div>
                                </div>
								<div class="form-group">
									<label class="col-md-2 control-label">Email</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="Email Address" class="form-control" maxlength="50" name="email" <cfif structkeyexists( form, "email" )>value="#trim( form.email )#"</cfif>/>
											<span class="help-block m-b-none">Please enter the email address of the user.</span>
									</div>
                                </div>
								<cfif structkeyexists( url, "userType" )>
									<cfif url.usertype eq "statsapi">
										<div class="form-group">
											<label class="col-md-2 control-label">Team Name</label>
											<div class="col-md-4">
												<input type="text" placeholder="Enter Team Name" class="form-control" maxlength="50" name="teamname" <cfif structkeyexists( form, "teamname" )>value="#trim( form.teamname )#"</cfif>/>
													<span class="help-block m-b-none text-danger">Please enter the team name for this Stats App User.  Example:  Oviedo Lions</span>
											</div>
										</div>
									</cfif>
								</cfif>
								<div class="form-group">
									<label class="col-md-2 control-label">Password</label>
                                    <div class="col-md-4">
										<input type="password" placeholder="Enter Password" class="form-control" maxlength="50" name="pass1" />
											<span class="help-block m-b-none">Please enter the password for the user.</span>
									</div>
                                </div>
								<div class="form-group">
									<label class="col-md-2 control-label">Confirm Password</label>
                                    <div class="col-md-4">
										<input type="password" placeholder="Confirm Password" class="form-control" maxlength="50" name="pass2" />
											<span class="help-block m-b-none">Please confirm the user password.</span>
									</div>
                                </div>
								<div class="form-group">
									<label class="col-md-2 control-label">User Role</label>
                                    <div class="col-md-4">				
										<select class="form-control" multiple="true" name="userrole">
											<cfif structkeyexists( url, "userType" )>
												<option value="statsapi" selected>Stats App User</option>
											<cfelse>
												<option value="admin">Admin</option>
												<option value="confadmin">Conference Admin</option>
												<option value="data">Data & Analytics</option>
											</cfif>												
										</select>
										<span class="help-block m-b-none text-success">Please select the system role of the user.</span>
                                    </div>
                                </div>							
								<br />
                                <div class="hr-line-dashed" style-="margin-top:15px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn <cfif structkeyexists( url, "userType" )>btn-danger<cfelse>btn-primary</cfif>" type="submit" name="saveUserRecord"><i class="fa fa-save"></i> Save User</button>
										<a href="#application.root#admin.users" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
									</div>
                                </div>
                            </form>
                        </div>
                    </div>
				</cfoutput>