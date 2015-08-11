

	
	
	
			
			<cfinvoke component="apis.com.user.userservice" method="getusersettings" returnvariable="usersettings">
				<cfinvokeargument name="id" value="#session.userid#">
			</cfinvoke>
			

				
			<cfoutput>	
				<div class="wrapper wrapper-content animated fadeInRight">
					<div class="row" style="margin-top:25px;">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-th-list"></i> #session.username# | Profile Image</h5>
								<span class="pull-right">
									<a href="#application.root#user.home" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-dashboard"></i> Dashboard</a>
								</span>								
							</div>
							<div class="ibox-content">

								<!--- // file upload validation --->
								<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "saveUserProfileImage" )>
									
									<cfif structkeyexists( form, "thisfile" ) and form.thisfile neq "">
									
										<cfset form.validate_file = "thisfile|jpg,gif,png|The file you upload for your profile image must be either JPEG, GIF, or PNG format." />
									
										<cfscript>
											stcDirectories = structnew();										
											stcDirectories.thisfile = "#expandPath( "./img/users" )#";
											objValidation = createObject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.setDirectories( stcDirectories );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>
											
											<cfset myuserid = session.userid />
											<cfset myimagepath = "./img/users/" />
											<cfset myimagefile = objValidation.getFiles().thisfile  />
											
											<cfquery name="saveuserprofileimage">
												update usersettings
												   set userprofileimagepath = <cfqueryparam value="#myimagepath##myimagefile#" cfsqltype="cf_sql_varchar" />
												 where userid = <cfqueryparam value="#myuserid#" cfsqltype="cf_sql_integer" />
											</cfquery>
											
											<!--- // record the activity --->
											<cfquery name="activitylog">
												insert into activity(userid, activitydate, activitytype, activitytext)														  													   
													values(
														   <cfqueryparam value="#myuserid#" cfsqltype="cf_sql_integer" />,
														   <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
														   <cfqueryparam value="User Profile" cfsqltype="cf_sql_varchar" />,
														   <cfqueryparam value="uploaded a new user profile image." cfsqltype="cf_sql_varchar" />																
														  );
											</cfquery>
											
											<cflocation url="#application.root##url.event#&scope=p3" addtoken="no">						
											
											
										<cfelse>
											<div class="alert alert-danger alert-dismissable">
												<h5><i class="fa fa-warning"></i> There were errors in your submission:</h5>
													<ul>
														<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
															<li><cfoutput>#variables.objValidation.getMessage(rr)#"</cfoutput></li>
														</cfloop>
													</ul>
											</div>
										</cfif>
									
									<cfelse>
									
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
											<h5><i class="fa fa-warning"></i> You did not select a file.  Please try again...</h5>													
										</div>										
										
									</cfif>
								</cfif>

								<!--- // end form processing --->
							
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class=""><a href="#application.root#user.profile"><i class="fa fa-user"></i> My Profile</a></li>
										<li class=""><a href="#application.root#user.settings"><i class="fa fa-cog"></i> Settings</a></li>
										<li class="active"><a href="#application.root#user.image"><i class="fa fa-image"></i> Profile Image</a></li>
										<li class=""><a href="#application.root#user.activity"><i class="fa fa-database"></i> User Activity</a></li>
									</ul>
									<div class="tab-content">
									
										<cfif structkeyexists( url, "scope" )>
											<cfif trim( url.scope ) eq "p3">
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>									
													<h5><i class="fa fa-upload"></i> <strong>Upload Success!</strong> Your image was successfully uploaded to the server.</h5>
												</div>
											</cfif>
										</cfif>
										
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<div class="col-md-6">												
													<cfif trim( usersettings.userprofileimagepath ) neq "">
														<div>
															<img class="img-circle" src="#usersettings.userprofileimagepath#" alt="member" width="100">
														</div>
													<cfelse>
														<i class="fa fa-user fa-4x"></i>
														<span class="help-block">Upload Your Image</span>
													</cfif>											
												</div>
												
												<div class="col-md-6">
													<form name="saveUserProfile" method="post" action="" enctype="multipart/form-data" class="form-horizontal">
														<fieldset style="padding:20px;border:1px solid ##f2f2f2;">
															<div class="form-control" style="padding:25px;"><label class="col-sm-2 control-label">Browse:</label>
																<div class="col-md-6"><input type="file" name="thisfile" class="form-control"></div>
															</div>
															<div class="hr-line-dashed" style="margin-top:15px;"></div>
															<div class="form-group">
																<div class="col-lg-offset-2 col-lg-6">
																	<button class="btn btn-primary" type="submit" name="saveUserProfileImage"><i class="fa fa-upload"></i> Save Profile Image</button>
																	<a href="#application.root#user.home" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
																</div>
															</div>
														</fieldset>
													</form>	
												</div>																	
											</div>
										</div>                              
									</div>
								</div>
							</div>
						</div> 
					</div>
				</div>
			</cfoutput>