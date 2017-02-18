





				


					




				<cfoutput>
					<div class="row">
						<div class="ibox">					
							<div class="ibox-title">
								<h5><i class="fa fa-video-camera"></i> View Shooter | #shooter.shooterfirstname# #shooter.shooterlastname#   <cfif isuserinrole( "admin" )><a href="#application.root##url.event#&fuseaction=shooter.edit&id=#shooter.shooterid#" class="btn btn-xs btn-primary btn-outline" style="margin-left:15px;"><i class="fa fa-edit"></i> Edit Shooter</a></cfif></h5>
								<span class="pull-right">
									<a href="#application.root#admin.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-cog"></i> Admin Home</a>
									<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline" style="margin-left:5px;"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
								</span>
							</div>
							<div class="ibox-content">
								
								<!--- // system messages --->
								<cfif structkeyexists( url, "scope" )>									
									<cfif numberformat( url.scope, "99" ) eq 3>						
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<p><i class="fa fa-check-circle-o"></i> Shooter Details Saved...</p>								
										</div>									
									</cfif>					
								</cfif>
							
									
							
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="##tab-1"><i class="fa fa-video-camera"></i> Shooter Details</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.regions&id=#url.id#"><i class="fa fa-map-marker"></i> Regions</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.dates&id=#url.id#"><i class="fa fa-calendar"></i> Availability</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.account&id=#url.id#"><i class="fa fa-money"></i> Account</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.comments&id=#url.id#"><i class="fa fa-comments"></i> Rating &amp; Comments</a></li>																							
									</ul>			
											
																					
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">

												<!--- // process the invitation form --->
												<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "resendShooterInvite" )>
													<cfset form.validate_require = "shooterfirstname|The shooter first name is required.;shooterlastname|The shooters last name is required to resend the invitation.;shooteremail|The shooters email address is required and readonly.;shooterregcode|The shooters registration code is required to send the invite." />													
														<cfscript>
															objValidation = createobject( "component","apis.udfs.validation" ).init();
															objValidation.setFields( form );
															objValidation.validate();
														</cfscript>
														<cfif objValidation.getErrorCount() is 0>												
															
															<cfset sh = structnew() />
															<cfset sh.shooterid = form.shooterid />
															<cfset sh.shooterregcode = trim( form.shooterregcode ) />
															<cfset sh.shooteremail = trim( form.shooteremail ) />
															<cfset sh.shooterfirstname = trim( form.shooterfirstname ) />
															<cfset sh.shooterlastname = trim( form.shooterlastname ) />
															
															<!--- // send shooter invitation // still need to do --->
															<cfinvoke component="apis.com.admin.notificationservice" method="sendshooterinvite" returnvariable="msgstatus">
																<cfinvokeargument name="shooteremail" value="#sh.shooteremail#">
																<cfinvokeargument name="shootername" value="#sh.shooterfirstname# #sh.shooterlastname#">
																<cfinvokeargument name="shooterregcode" value="#sh.shooterregcode#">
															</cfinvoke>
															<!--- // end shooter email notification --->
															
															<!--- // record the activity --->
															<cfquery name="activitylog">
																insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																	values(
																			<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																			<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																			<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																			<cfqueryparam value="re-sent the shooter invitation for #sh.shooterfirstname# #sh.shooterlastname#." cfsqltype="cf_sql_varchar" />																
																		);
															</cfquery>										
															
															<!--- // redirect to shooter page --->
															<cflocation url="#application.root##url.event#&scope=s4" addtoken="no">
															
															
															
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









												
	




											
												
												<cfif shooter.regcomplete eq 1 and shooter.regcompletedate neq "" and shooter.useractive eq 1>
												
													<div class="alert alert-info">
														<h5><i class="fa fa-check-square"></i> <strong>Shooter Already Successfully Registered</strong></h5>
														<p>The selected shooter has already successfully completed the shooter registration.  The resend shooter invitation function has been disabled.</p>
														<p>You can navigate away from this page.</p>
													</div>
													
													<div>
														<p><i class="fa fa-check"></i> Registered #dateformat( shooter.regcompletedate, "mm-dd-yyyy" )# @ #timeformat( shooter.regcompletedate, "hh:mm:ss tt" )#</p>
														<p><i class="fa fa-user"></i> <span class="small label label-primary">ACTIVE</span></p>														
													</div>
												
												
												<cfelse>
												
													<div class="ibox-title">
														<h5><i class="fa fa-envelope"></i> Send Invite Email</h5>
													</div>
													<div>
														<ul style="list-style:none;">															
															<li class="m-b"><i class="fa fa-doc"></i> Reg Code: #shooter.regcode#</li>
															<li class="m-b"><span class="label lable-danger">Shooter Not Active</span></li>
														</ul>
													</div>
													<br />
													<form role="form" class="form-inline" name="resend-shooter-invite" method="post" action="">
														<fieldset>
															<div class="form-group">
																<label for="shooterEmail" class="sr-only">Shooter Email</label>																
																<input type="text" placeholder="Enter First Name" name="shooterfirstname" class="form-control" value="#shooter.shooterfirstname#" />
																<input type="text" placeholder="Enter Last Name" name="shooterlastname" class="form-control" value="#shooter.shooterlastname#" />
																<input type="email" placeholder="Enter Email" name="shooteremail" class="form-control" value="#shooter.shooteremail#" readonly />
																<input type="hidden" name="shooterid" value="#shooter.shooterid#" />
																<input type="hidden" name="shooterregcode" value="#shooter.regcode#" />
																<button name="resendShooterInvite"class="btn btn-white" type="submit" onclick="return confirm('This will re-send the shooter invitation.  Continue?');">Resend Invite</button>
															</div>															
														</fieldset>
													</form>
													
													
													
													 
												</cfif>
												
												
												
												
											</div>
										</div>											
									</div><!-- / .tab-content -->
								</div><!-- / .tab-container -->	
							</div>					
						</div>				
					</div>
				</cfoutput>