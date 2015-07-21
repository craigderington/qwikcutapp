

			<!--- Scope the URL variable --->
			<cfparam name="user.role" default="shooter">

				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> Add New User</h5>                        						
							<div class="ibox-tools">
								<a href="#application.root##url.event#" class="btn btn-xs btn-white"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</div>
						</div>
                        <div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
										
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
														insert into users(username, firstname, lastname, email, password, userrole, useracl)
														 values(
																<cfqueryparam value="#user.username#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.firstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.lastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.email#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#hash( user.password, "SHA-384", "UTF-8" )#" cfsqltype="cf_sql_clob" maxlength="128" />,
																<cfqueryparam value="#user.role#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#user.acl#" cfsqltype="cf_sql_numeric" />
																);
													</cfquery>										
													
													<!--- // redirect back to user list --->
													<cflocation url="#application.root#admin.users" addtoken="no">			
											
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
							
							
							
							
							
							<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#">
                                <p></p>
                                <div class="form-group">
									<label class="col-md-2 control-label">First Name</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="First Name" class="form-control" name="firstname" /> 
											<span class="help-block m-b-none">Please enter the first name of the user.</span>
                                    </div>
                                </div>
                                <div class="form-group">
									<label class="col-md-2 control-label">Last Name</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="Last Name" class="form-control" maxlength="50" name="lastname" />
											<span class="help-block m-b-none">Please enter the last name of the user.</span>
									</div>
                                </div>
								<div class="form-group">
									<label class="col-md-2 control-label">Email</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="Email Address" class="form-control" maxlength="50" name="email" />
											<span class="help-block m-b-none">Please enter the email address of the user.</span>
									</div>
                                </div>
								<div class="form-group">
									<label class="col-md-2 control-label">Password</label>
                                    <div class="col-md-4">
										<input type="password" placeholder="Enter Password" class="form-control" maxlength="50" name="pass1" />
											<span class="help-block m-b-none">Please enter the password for the user.</span>
									</div>
                                </div>
								<div class="form-group">
									<label class="col-md-2 control-label">Email</label>
                                    <div class="col-md-4">
										<input type="password" placeholder="Confirm Password" class="form-control" maxlength="50" name="pass2" />
											<span class="help-block m-b-none">Please confirm the user password.</span>
									</div>
                                </div>
								<div class="form-group">
									<label class="col-md-2 control-label">User Role</label>
                                    <div class="col-md-4">				
										<select class="form-control" multiple="true" name="userrole">
											<option value="admin">Admin</option>
											<option value="shooter">Shooter</option>
											<option value="data">Data & Analytics</option>
											<option value="future-use">Future Use</option>
										</select>
										<span class="help-block m-b-none">Please select the system role of the user.</span>
                                    </div>
                                </div>							
								<br />
                                <div class="hr-line-dashed" style-="margin-top:15px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-primary" type="submit" name="stateUserRecord"><i class="fa fa-save"></i> Save User</button>
										<a href="#application.root#admin.users" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
									</div>
                                </div>
                            </form>
                        </div>
                    </div>
				</cfoutput>