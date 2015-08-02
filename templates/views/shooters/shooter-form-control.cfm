



				<cfif isdefined( "form.fieldnames" ) and structkeyexists( form, "shooterid" )>
										
					<cfset form.validate_require = "shooterid|Opps, internal form error.;shooterfirstname|Please enter the shooters first name.;shooterlastname|Please enter the shooters last name.;shooteremail|Please enter the shooters email address.;shooterstateid|Please select the shooters state." />
					<cfset form.validate_email = "shooteremail|The email you entered is not in the correct form.  Please use the format: alias@domain.xxx" />			
						
						<cfscript>
							objValidation = createobject( "component","apis.udfs.validation" ).init();
							objValidation.setFields( form );
							objValidation.validate();
						</cfscript>

						<cfif objValidation.getErrorCount() is 0>																											
														
							<!--- define our form structure and set form values --->
							<cfset sh = structnew() />
							<cfset sh.shooterid = numberformat( form.shooterid, "99" ) />
							<cfset sh.shooterfirstname = trim( form.shooterfirstname ) />
							<cfset sh.shooterlastname = trim( form.shooterlastname ) />
							<cfset sh.shooteremail = trim( form.shooteremail ) />
							<cfset sh.shooteradd1 = trim( form.shooteradd1 ) />
							<cfset sh.shooteradd2 = trim( form.shooteradd2 ) />
							<cfset sh.shooterstateid = numberformat( form.shooterstateid ) />
							<cfset sh.shootercity = trim( form.shootercity ) />
							<cfset sh.shooterzip = form.shooterzip />
							<cfset sh.shootercellphone = trim( form.shootercellphone ) />
							<cfset sh.shooterregcode = #createuuid()# />
							
							<cfif sh.shooterid eq 0>							
													
								<!--- // add the user first to get the new user id - identity insert --->								
								<!--- // check the database and make sure the user name/email is unique --->
								<cfquery name="chkUser">
									select userid, email, username
									  from dbo.users
									 where username = <cfqueryparam value="#sh.shooteremail#" cfsqltype="cf_sql_varchar" /> 
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
										<cfquery name="addnewuser">
											insert into users(username, firstname, lastname, email, password, userrole, useracl, regcode)
												values(
														<cfqueryparam value="#sh.shooteremail#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shooterfirstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shooterlastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shooteremail#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#hash( sh.shooterlastname, "SHA-384", "UTF-8" )#" cfsqltype="cf_sql_clob" maxlength="128" />,
														<cfqueryparam value="shooter" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="5" cfsqltype="cf_sql_numeric" />,
														<cfqueryparam value="#sh.shooterregcode#" cfsqltype="cf_sql_varchar" maxlength="35" />
														); select @@identity as newuserid
										</cfquery>

										<!--- create user settings record in table --->
										<cfquery name="addnewuser">
											insert into usersettings(userid)
												values(
														<cfqueryparam value="#adduser.newuserid#" cfsqltype="cf_sql_integer" />																
													  );
										</cfquery>
								
										<!--- // now that we have a valid user id, insert the shooter record --->
										<!--- // then add the shooter --->
										<cfquery name="addnewshooter">
											insert into shooters(sh.userid, sh.shooterfirstname, sh.shooterlastname, sh.shooteraddress1, sh.shooteraddress2, sh.shootercity, sh.shooterstateid, sh.shooterzip, sh.shooteremail, sh.shooterisactive, shootercellphone)
												values(
														<cfqueryparam value="#addnewuser.newuserid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="#sh.shooterfirstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shooterlastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shooteradd1#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shooteradd2#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shootercity#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="#sh.shooterstateid#" cfsqltype="cf_sql_integer" />,
														<cfqueryparam value="#sh.shooterzip#" cfsqltype="cf_sql_numeric" />,
														<cfqueryparam value="#sh.shooteremail#" cfsqltype="cf_sql_varchar" maxlength="50" />,
														<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
														<cfqueryparam value="#sh.shootercellphone#" cfsqltype="cf_sql_varchar" maxlength="50" />
														);
										</cfquery>									

										<!--- // send shooter invitation // still need to do --->
										<cfinvoke component="apis.com.admin.notificationservice" method="sendshooterinvite" returnvariable="msgstatus">
											<cfinvokeargument name="shooteremail" value="#sh.shooteremail#">
											<cfinvokeargument name="shootername" value="#sh.shooterfirstname# #sh.shooterlastname#">
											<cfinvokeargument name="shooterregcode" value="#sh.shooterregcode#">
										</cfinvoke>
										<!--- // end shooter email notification --->
										
										
										<!--- // redirect to shooter page --->
										<cflocation url="#application.root##url.event#&scope=s1" addtoken="no">
										
									</cfif>

							<cfelse>
							
								<!--- // update the shooter details --->
								<cfquery name="saveshooter">
									update shooters
									   set shooterfirstname = <cfqueryparam value="#sh.shooterfirstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
									       shooterlastname = <cfqueryparam value="#sh.shooterlastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
										   shooteraddress1 = <cfqueryparam value="#sh.shooteradd1#" cfsqltype="cf_sql_varchar" maxlength="50" />,
										   shooteraddress2 = <cfqueryparam value="#sh.shooteradd2#" cfsqltype="cf_sql_varchar" maxlength="50" />,
										   shootercity = <cfqueryparam value="#sh.shootercity#" cfsqltype="cf_sql_varchar" maxlength="50" />,
										   shooterstateid = <cfqueryparam value="#sh.shooterstateid#" cfsqltype="cf_sql_integer" />,
										   shooterzip = <cfqueryparam value="#sh.shooterzip#" cfsqltype="cf_sql_numeric" />,
										   shooteremail = <cfqueryparam value="#sh.shooteremail#" cfsqltype="cf_sql_varchar" maxlength="50" />,
										   shootercellphone = <cfqueryparam value="#sh.shootercellphone#" cfsqltype="cf_sql_varchar" maxlength="50" />
								     where shooterid = <cfqueryparam value="#sh.shooterid#" cfsqltype="cf_sql_integer" /> 
								</cfquery>
								
								<!--- redirect back to shooter view page --->
								<cflocation url="#application.root##url.event#&fuseaction=shooter.view&id=#sh.shooterid#&scope=2" addtoken="no">
								
								
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
					<form name="shootert-add-new" class="form-horizontal" method="post" action="">						
						<div class="form-group">
							<label class="col-lg-2 control-label">First Name</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Shooter First Name" name="shooterfirstname" <cfif structkeyexists( form, "shooterfirstname" )>value="#trim( form.shooterfirstname )#"<cfelse>value="#trim( shooter.shooterfirstname )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Last Name</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Shooter Last Name" name="shooterlastname" <cfif structkeyexists( form, "shooterlastname" )>value="#trim( form.shooterlastname )#"<cfelse>value="#trim( shooter.shooterlastname )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Address</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Address 1" name="shooteradd1" <cfif structkeyexists( form, "shooteradd1" )>value="#trim( form.shooteradd1 )#"<cfelse>value="#trim( shooter.shooteraddress1 )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Address 2</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Address 2" name="shooteradd2" <cfif structkeyexists( form, "shooteradd2" )>value="#trim( form.shooteradd2 )#"<cfelse>value="#trim( shooter.shooteraddress2 )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">City</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="City" name="shootercity" <cfif structkeyexists( form, "shootercity" )>value="#trim( form.shootercity )#"<cfelse>value="#trim( shooter.shootercity )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">State</label>
							<div class="col-lg-10">
								<select name="shooterstateid" id="shooterstateid" class="form-control">
									<option value="" selected>Select State</option>
									<cfloop query="statelist">
										<option value="#stateid#"<cfif structkeyexists( form, "shooterstateid" )><cfif numberformat( form.shooterstateid ) eq statelist.stateid>selected</cfif><cfelse><cfif shooter.shooterstateid eq statelist.stateid>selected</cfif></cfif>>#statename#</option>
									</cfloop>
								</select>
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Zip Code</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Zip Code" name="shooterzip" <cfif structkeyexists( form, "shooterzip" )>value="#trim( form.shooterzip )#"<cfelse>value="#trim( shooter.shooterzip )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Email</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Email Address" name="shooteremail" <cfif structkeyexists( form, "shooteremail" )>value="#trim( form.shooteremail )#"<cfelse>value="#trim( shooter.shooteremail )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Mobile</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Mobile Phone Number" name="shootercellphone" <cfif structkeyexists( form, "shootercellphone" )>value="#trim( form.shootercellphone )#"<cfelse>value="#trim( shooter.shootercellphone )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<div class="col-sm-6 col-sm-offset-2">
								<button class="btn btn-primary" type="submit"><i class="fa fa-save"></i> Save Shooter</button>
								<input type="hidden" name="shooterid" value="#numberformat( url.id, "99" )#" />
								<cfif isuserinrole( "admin" )>
									<cfif structkeyexists( url, "id" ) and url.id neq 0>
										<a href="#application.root##url.event#&fuseaction=shooter.delete&id=#shooter.shooterid#" class="btn btn-danger"><i class="fa fa-times-circle"></i> Delete Shooter</a>
									</cfif>
								</cfif>
								<a href="#application.root##url.event#" class="btn btn-white"><i class="fa fa-remove"></i> Cancel</a>													
							</div>
						</div>						
					</form>
				</cfoutput>