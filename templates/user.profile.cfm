

	
	
	
	
			<cfinvoke component="apis.com.user.userservice" method="getuserprofile" returnvariable="userprofile">
				<cfinvokeargument name="id" value="#session.userid#">
			</cfinvoke>


				
			<cfoutput>	
				<div class="wrapper wrapper-content animated fadeInRight">
					<div class="row" style="margin-top:25px;">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-th-list"></i> #session.username# | Profile</h5>
								<span class="pull-right">
									<a href="#application.root#user.home" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-dashboard"></i> Dashboard</a>
								</span>								
							</div>
							<div class="ibox-content">
								
								<cfif structkeyexists( url, "scope" )>
									<cfif trim( url.scope eq "p1" )>
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<h5><i class="fa fa-check-circle-o"></i> Your profile was successfully updated...</h5>
										</div>
									</cfif>
								</cfif>
								
								
								
								
								
								<!--- // begin form processing --->
									<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "saveUserProfile" )>
										
										<cfset form.validate_require = "firstname|Your first name is required to save your profile.;lastname|Your last name is required to save your profile.;email|Your email address is required to save your profile." />
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset user = structnew() />
											<cfset user.userid = session.userid />
											<cfset user.firstname = trim( form.firstname ) />
											<cfset user.lastname = trim( form.lastname ) />
											<cfset user.email = trim( form.email ) />
											
											<cfif trim( form.password ) neq "">
												<cfset user.password = trim( form.password ) />
												<cfset user.confirmpassword = trim( form.confirm_password ) />
											<cfelse>
												<cfset user.password = "" />
												<cfset user.confirmpassword = "" />												
											</cfif>
											
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
												
												<!--- //  execute the update --->
												<cfquery name="saveuser">
													update users
													   set firstname = <cfqueryparam value="#user.firstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   lastname = <cfqueryparam value="#user.lastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														   email = <cfqueryparam value="#user.email#" cfsqltype="cf_sql_varchar" maxlength="50" />
													       <cfif trim( user.password ) neq "">
														   , password = <cfqueryparam value="#hash( user.password, "SHA-384", "UTF-8" )#" cfsqltype="cf_sql_clob" maxlength="128" />
														   </cfif>
													 where userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />														
												</cfquery>

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="updated the user profile." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>
												
													<!--- // redirect --->
													<cflocation url="#application.root##url.event#&scope=p1" addtoken="no">
											
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
										<li class="active"><a href="#application.root#user.profile"><i class="fa fa-user"></i> My Profile</a></li>
										<li class=""><a href="#application.root#user.settings"><i class="fa fa-cog"></i> Settings</a></li>
										<li class=""><a href="#application.root#user.image"><i class="fa fa-image"></i> Profile Image</a></li>
										<li class=""><a href="#application.root#user.activity"><i class="fa fa-database"></i> User Activity</a></li>
									</ul>
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<form class="form-horizontal" method="post" name="savethisuser" action="#application.root##url.event#">
													<div class="form-group"><label class="col-sm-2 control-label">Username:</label>
														<div class="col-sm-6"><input type="text" name="username" class="form-control" placeholder="First Name" readonly value="#userprofile.username#" /></div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">First Name:</label>
														<div class="col-sm-6"><input type="text" name="firstname" class="form-control" placeholder="First Name" value="#( userprofile.firstname )#" /></div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">Last Name</label>
														<div class="col-sm-6"><input type="text" name="lastname" class="form-control" placeholder="Last Name" value="#trim( userprofile.lastname )#" /></div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">Email Address:</label>
														<div class="col-sm-6"><input type="text" name="email" class="form-control" placeholder="Email Address" value="#trim( userprofile.email )#" /></div>
													</div>													
													<div class="hr-line-dashed"></div>												
													<div class="form-group"><label class="col-sm-2 control-label">Password:</label>
														<div class="col-sm-6">
															<input type="text" name="password" class="form-control" placeholder="Password" />
															<span class="help-block m-b-none"><i class="fa fa-lock"></i> To change your password, enter a new password and confirm, then click Save.</span>
														</div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">Confirm Password:</label>
														<div class="col-sm-6"><input type="text" name="confirm_password" class="form-control" placeholder="Confirm Password" /></div>
													</div>
													<div class="hr-line-dashed" style="margin-top:15px;"></div>
													<div class="form-group">
														<div class="col-lg-offset-2 col-lg-6">
															<button class="btn btn-primary" type="submit" name="saveUserProfile"><i class="fa fa-save"></i> Save Profile</button>
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