

		
		<cfif not structkeyexists( session, "shooterid" ) and ( structkeyexists( url, "beginregistration" ) and trim( url.beginregistration ) eq "true" )>
			<cfif structkeyexists( url, "regcode" ) and structkeyexists( url, "email" )>
				<cfinvoke component="apis.com.register.registrationservice" method="getshooterbyregcode" returnvariable="shooter">
					<cfinvokeargument name="regcode" value="#trim( url.regcode )#">
					<cfinvokeargument name="email" value="#trim( url.email )#">
				</cfinvoke>
			</cfif>
		</cfif>
		
		<cfif structkeyexists( form, "beginregistration" )>
			<cfif structkeyexists( form, "shooterid" ) and structkeyexists( form, "userid" )>
				<cfset session.shooterid = shooter.shooterid />
				<cfset session.userid = shooter.userid />
				<cflocation url="index.cfm?step=1" addtoken="no">
			</cfif>
		</cfif>

		<cfif ( structkeyexists( session, "shooterid" ) and structkeyexists( session, "userid" )) and not structkeyexists( url, "beginregistration" )>
			<cfinvoke component="apis.com.register.registrationservice" method="getshooterbyid" returnvariable="shooter">
				<cfinvokeargument name="shooterid" value="#session.shooterid#">
				<cfinvokeargument name="userid" value="#session.userid#">
			</cfinvoke>
		</cfif>
		
		<cfif structkeyexists( url, "reset" )>
			<cfset tempr = structdelete( session, "shooterid" ) />
			<cfset tempr2 = structdelete( session, "userid" ) />
			<cflocation url="index.cfm?beginregistration=true&regcode=#trim( url.regcode )#&email=#trim( url.email )#" addtoken="no">
		</cfif>
		
		<cfset today = now() />


		<!doctype html>
			<html lang="en">			
				<head>
					<cfoutput>
						<title>#application.title#</title>
					</cfoutput>									
									
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="apple-mobile-web-app-capable" content="yes"> 				
					
					<!-- Boostrap and Font-Awesome -->
					<link href="../css/bootstrap.min.css" rel="stylesheet">
					<link href="../font-awesome/css/font-awesome.css" rel="stylesheet">
					<link href="../css/animate.css" rel="stylesheet">
					<link href="../css/style.css" rel="stylesheet">					
					<link href="../css/plugins/datapicker/datepicker3.css" rel="stylesheet">
					<link href="../css/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet">
					<link href="../css/plugins/steps/jquery.steps.css" rel="stylesheet">

					<!--- // make sure that none of our dynamic pages are cached by the users browser --->
					<cfheader name="cache-control" value="no-cache,no-store,must-revalidate" >
					<cfheader name="pragma" value="no-cache" >
					<cfheader name="expires" value="#getHttpTimeString( Now() )#" >
					
					<!--- // shortcut icon --->
					<link rel="shortcut icon" href="http://qwikcut.cloudapp.net/qwikcutapp/favicon.ico?v=2" type="image/x-icon" />
					<link rel="icon" href="http://qwikcut.cloudapp.net/qwikcutapp/favicon.ico?v=2" type="image/x-icon">
					<link rel="apple-touch-icon" href="http://qwikcut.cloudapp.net/qwikcutapp/img/qwikcut-icon-60x60.png"/>
					
					<!--- // also ensure that non-dynamic pages are not cached by the users browser --->
					<META HTTP-EQUIV="expires" CONTENT="-1">
					<META HTTP-EQUIV="pragma" CONTENT="no-cache">
					<META HTTP-EQUIV="cache-control" CONTENT="no-cache,no-store,must-revalidate">
				
				</head>
				
				<cfoutput>
				
				
				
				<body class="top-navigation">				
					<div id="wrapper">					
						<div id="page-wrapper" class="gray-bg">
							<div class="row border-bottom white-bg">
								<nav class="navbar navbar-fixed-top" role="navigation">
									<div class="navbar-header">
										<button aria-controls="navbar" aria-expanded="false" data-target="##navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
											<i class="fa fa-reorder"></i>
										</button>
										<a href="/index.cfm" class="navbar-brand"><i class="fa fa-upload"></i> QwikCut</a>
									</div>
						
									<div class="navbar-collapse collapse" id="navbar">
										<ul class="nav navbar-nav">
											<li class="active">
												<a aria-expanded="false" role="button" href="index.cfm"> Game Video &amp; Analytics</a>
											</li>
										</ul>												
									</div>
								</nav>
							</div>
							
							<div class="wrapper wrapper-content animated fadeIn">
								<div class="container">				
								
									<!-- show welcome --->
									<cfif not structkeyexists( session, "shooterid" )>
										<cfif structkeyexists( url, "beginregistration" ) and structkeyexists( url, "regcode" ) and structkeyexists( url, "email" )>
											<cfif shooter.recordcount eq 1>
												<cfif shooter.regcomplete neq 1>
													<div class="row" style="margin-top:20px;">
														<div class="ibox">							
															<div class="jumbotron">
																<h1><i class="fa fa-video-camera text-primary"></i> Welcome, #shooter.shooterfirstname# #shooter.shooterlastname#</h1>
																<h3>Game Day Videographer</h3>
																<p><i class="fa fa-check-circle-o text-navy"></i> Your registration code <i>#trim( url.regcode )#</i> has been successfully verified.</p>
																<p class="small">Please click begin below to get started...</p>
																<form name="register-game-videographer" method="post" action="">
																	<button class="btn btn-primary btn-lg" name="beginregistration" type="submit"><i class="fa fa-arrow-circle-right"></i> Begin Registration</button>
																	<input type="hidden" name="shooterid" value="#shooter.shooterid#" />
																	<input type="hidden" name="userid" value="#shooter.userid#"  />
																</form>
															</div>							
														</div>
													</div>
												<cfelse>
													<div class="row" style="margin-top:20px;">
														<div class="ibox">							
															<div class="jumbotron">
																<h1><i class="fa fa-video-camera text-primary"></i> Welcome, #shooter.shooterfirstname# #shooter.shooterlastname#</h1>
																<h3>Game Day Videographer</h3>
																<p><i class="fa fa-check-circle-o text-navy"></i> Your QwikCut registration was completed on #dateformat( shooter.regcompletedate, "mm/dd/yyyy" )# at #timeformat( shooter.regcompletedate, "hh:mm tt" )#</p>
																<p class="small">You do not need to register again.</p>
																<p class="small">Qwikcut will contact you by email when games are scheduled for you to shoot.</p>
																
															</div>							
														</div>
													</div>
												</cfif>
											<cfelse>
												<div class="row" style="margin-top:20px;">
													<div class="ibox">							
														<div class="jumbotron">
															<h1><i class="fa fa-warning text-navy"></i>  "Houston, We Have a Problem...."</h1>
															<h3>Sorry, but there was a problem with your registration code.</h3>													
															<p class="small">Please contact your QwikCut representative for further instructions...</p>														
														</div>							
													</div>
												</div>
											</cfif>
										<cfelse>
											<div class="row" style="margin-top:20px;">
												<div class="ibox">							
													<div class="jumbotron">
														<h1><i class="fa fa-warning text-navy"></i>  "Houston, We Have a Problem...."</h1>
														<h3>Sorry, the registration parameters were not found in your invite code.</h3>													
														<p class="small">Please contact your QwikCut representative for further instructions...</p>														
													</div>							
												</div>
											</div>
										</cfif>
									<cfelse>									
										<cfif structkeyexists( session, "shooterid" )>
											<div class="ibox" style="margin-top:20px;">													
												<div class="ibox-content">
													<h2>QwikCut Videographer Registration</h2>
													<br />
													
													<!--- // begin form processing --->
													<cfif isdefined( "form.fieldnames" ) and structkeyexists( form, "savestep1" )>
													
														<cfset form.validate_require = "password|The password is required to create your user profile...;confirmpassword|Please confirm your password." />
														<cfset form.validate_password = "password|confirmpassword|The passwords you entered do not match.  Please try again..." />
														
														<cfscript>
															objValidation = createobject( "component","apis.udfs.validation" ).init();
															objValidation.setFields( form );
															objValidation.validate();
														</cfscript>

														<cfif objValidation.getErrorCount() is 0>							
															
															<!--- define our form structure and set form values --->
															<cfset user = structnew() />
															<cfset user.userid = session.userid />
															<cfset user.password = trim( form.password ) />										
															
																<cfquery name="updateusersettings">
																	update users
																	   set password = <cfqueryparam value="#hash( user.password, "SHA-384", "UTF-8" )#" cfsqltype="cf_sql_clob" maxlength="128" />
																	 where userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />
																</cfquery>												
																													
																<cflocation url="index.cfm?step=2" addtoken="no">				
															
												
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
													
													
													<!--- // begin form processing // step 2 --->
													<cfif isdefined( "form.fieldnames" ) and structkeyexists( form, "savestep2" )>
													
														<cfset form.validate_require = "shooterfirstname|Please enter the shooters first name.;shooterlastname|Please enter the shooters last name.;shooteremail|Please enter the shooters email address.;shooterstateid|Please select the shooters state.;shooteradd1|Please enter your address.;shootercity|Please enter your city.;shooterzip|Please enter your zip code.;shootercellphone|Please enter your cell phone number.;shootercellprovider|Please select your cell provider.;shooteralertpref|Please select your alert type preference." />
														
														<cfscript>
															objValidation = createobject( "component","apis.udfs.validation" ).init();
															objValidation.setFields( form );
															objValidation.validate();
														</cfscript>

														<cfif objValidation.getErrorCount() is 0>														
																
															<!--- define our form structure and set form values --->
															<cfset sh = structnew() />
															<cfset sh.shooterid = numberformat( session.shooterid, "99" ) />
															<cfset sh.userid = numberformat( session.userid, "99" ) />
															<cfset sh.shooterfirstname = trim( form.shooterfirstname ) />
															<cfset sh.shooterlastname = trim( form.shooterlastname ) />
															<cfset sh.shooteremail = trim( form.shooteremail ) />
															<cfset sh.shooteradd1 = trim( form.shooteradd1 ) />
															<cfset sh.shooteradd2 = trim( form.shooteradd2 ) />
															<cfset sh.shooterstateid = numberformat( form.shooterstateid ) />
															<cfset sh.shootercity = trim( form.shootercity ) />
															<cfset sh.shooterzip = form.shooterzip />
															<cfset sh.shootercellphone = trim( form.shootercellphone ) />
															<cfset sh.shootercellprovider = trim( form.shootercellprovider ) />
															<cfset sh.shooteralertpref = trim( form.shooteralertpref ) />
															
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
																		   shootercellphone = <cfqueryparam value="#sh.shootercellphone#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																		   shootercellprovider = <cfqueryparam value="#sh.shootercellprovider#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																		   shooteralertpref = <cfqueryparam value="#sh.shooteralertpref#" cfsqltype="cf_sql_varchar" maxlength="50" />
																	 where shooterid = <cfqueryparam value="#sh.shooterid#" cfsqltype="cf_sql_integer" /> 
																</cfquery>
																
																<!-- // save user details --->
																<cfquery name="updateusersettings">
																	update users
																	   set stateid = <cfqueryparam value="#sh.shooterstateid#" cfsqltype="cf_sql_integer" />
																	 where userid = <cfqueryparam value="#sh.userid#" cfsqltype="cf_sql_integer" />
																</cfquery>												
																													
																<cflocation url="index.cfm?step=3" addtoken="no">				
															
												
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
													
													<!--- // begin form processing // shooter block out dates ---->
													<cfif isdefined( "form.fieldnames" ) and structkeyexists( form, "addblockdates" )>
										
														<cfset form.validate_require = "start|Please select the block out start date;end|Please select the block out end date." />
															
															<cfscript>
																objValidation = createobject( "component","apis.udfs.validation" ).init();
																objValidation.setFields( form );
																objValidation.validate();
															</cfscript>

															<cfif objValidation.getErrorCount() is 0>																											
																						
																<!--- define our form structure and set form values --->
																<cfset s = structnew() />
																<cfset s.shooterid = numberformat( session.shooterid, "99" ) />
																<cfset s.fromdate = form.start  />
																<cfset s.todate = form.end />															
																
																<cfif datecompare( s.fromdate, s.todate, "d" ) eq -1>
																
																	<!--- add the new user record --->
																	<cfquery name="addshooterblockdates">
																		insert into shooterblockoutdates(shooterid, fromdate, todate)
																			values(
																					<cfqueryparam value="#s.shooterid#" cfsqltype="cf_sql_integer" />,
																					<cfqueryparam value="#s.fromdate#" cfsqltype="cf_sql_date" />,
																					<cfqueryparam value="#s.todate#" cfsqltype="cf_sql_date"  />																																		
																				);
																	</cfquery>

																	<!--- // send shooter invitation // to do --->													
																	<cflocation url="index.cfm?step=3" addtoken="no">
																
																<cfelse>
																
																	<div class="alert alert-danger alert-dismissable">
																		<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																		<p><i class="fa fa-warning"></i> Error.  The <i>to date</i> can not be earlier than the <i>from date</i>.  Please try again...</p>								
																	</div>
																
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
													
													
													
													
													
													
													
													<!--- // begin form processing // terms and conditions --->
													<cfif isdefined( "form.fieldnames" ) and structkeyexists( form, "finishregistration" )>
													
														<cfset form.validate_require = "acceptterms|Please accept the terms to complete your registration...." />
														
														<cfscript>
															objValidation = createobject( "component","apis.udfs.validation" ).init();
															objValidation.setFields( form );
															objValidation.validate();
														</cfscript>

														<cfif objValidation.getErrorCount() is 0>							
															
															<!--- define our form structure and set form values --->
															<cfset user = structnew() />
															<cfset user.userid = session.userid />
																								
															
																<cfquery name="updateusersettings">
																	update users
																	   set regcomplete = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
																	       regcompletedate = <cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />
																	 where userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />
																</cfquery>

																<!--- // record the activity --->
																<cfquery name="activitylog">
																	insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																	 values(
																			<cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />,
																			<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																			<cfqueryparam value="Registration" cfsqltype="cf_sql_varchar" />,
																			<cfqueryparam value="completed the videographer registration." cfsqltype="cf_sql_varchar" />																
																			);
																</cfquery>
																													
																<cflocation url="index.cfm?regcomplete=true" addtoken="no">				
															
												
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
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													<cfif not structkeyexists( url, "step" ) and not structkeyexists( url, "regcomplete" )>
														<div class="alert alert-danger">
															<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<p><i class="fa fa-warning"></i> Error:  Previous registration session detected.  Please <a href="index.cfm?reset=1&beginregistration=true&regcode=<cfif structkeyexists( url, "regcode" )>#trim( url.regcode )#<cfelse>XXXXX</cfif>&email=<cfif structkeyexists( url, "email" )>#trim( url.email )#<cfelse>uknown</cfif>">click here</a> to re-load.</p>								
														</div>
													</cfif>
														<cfif structkeyexists( url, "step" ) and url.step eq 1>
															<form id="form" method="post" action="" class="wizard-big wizard clearfix" role="application" novalidate="novalidate">
																<div class="steps clearfix">
																	<ul role="tablist">
																		<li role="tab" class="first current" aria-disabled="false" aria-selected="true"><a id="form-t-0" href="##form-h-0" aria-controls="form-p-0"><span class="current-info audible">current step: </span><span class="number">1.</span> Account</a></li>
																		<li role="tab" class="disabled" aria-disabled="false"><a id="form-t-1" href="index.cfm?step=2" aria-controls="form-p-1"><span class="number">2.</span> Profile</a></li>
																		<li role="tab" class="disabled" aria-disabled="false"><a id="form-t-2" href="index.cfm?step=3" aria-controls="form-p-2"><span class="number">3.</span> Block Dates</a></li>
																		<li role="tab" class="disabled last" aria-disabled="true"><a id="form-t-3" href="" aria-controls="form-p-3"><span class="number">4.</span> Finish</a></li>										
																	</ul>
																</div>
																
																<div class="content clearfix">																
																	<h1 id="form-h-0" tabindex="-1" class="title current">Account</h1>
																		<fieldset id="form-p-0" role="tabpanel" aria-labelledby="form-h-0" class="body current" aria-hidden="false">
																			<h2>Account Information</h2>
																				<div class="row">
																					<div class="col-lg-8">
																						<div class="form-group">
																							<label>Username</label>
																							<input id="userName" name="userName" type="text" class="form-control" value="#shooter.username#" readonly>
																						</div>
																						<div class="form-group">
																							<label>Password</label>
																							<input id="password" name="password" type="password" class="form-control">
																						</div>
																						<div class="form-group">
																							<label>Confirm Password</label>
																							<input id="confirm" name="confirmpassword" type="password" class="form-control">
																						</div>
																					</div>
																					<div class="col-lg-4">
																						<div class="text-center">
																							<div style="margin-top: 20px">
																								<i class="fa fa-sign-in" style="font-size: 180px;color: ##e5e5e5;"></i>
																							</div>
																						</div>
																					</div>
																				</div>												
																		</fieldset>																																						
																</div><!--- /.content --->
																<div class="actions clearfix">
																	<ul role="menu" aria-label="Pagination">																		
																		<li aria-hidden="false" aria-disabled="false"><button name="savestep1" class="btn btn-md btn-primary"><i class="fa fa-save"></i> Next</button></li>																		
																	</ul>
																</div>
															</form>		
													
														<cfelseif structkeyexists( url, "step" ) and url.step eq 2>
															<cfinvoke component="apis.com.register.registrationservice" method="getstates" returnvariable="statelist"></cfinvoke>
																<form id="form" action="" method="post" class="wizard-big wizard clearfix" role="application" novalidate="novalidate">
																	<div class="steps clearfix">
																		<ul role="tablist">
																			<li role="tab" class="disabled" ><a id="form-t-0" href="index.cfm?step=1"><span class="current-info audible">current step: </span><span class="number">1.</span> Account</a></li>
																			<li role="tab" class="disabled current"><a id="form-t-1" href="index.cfm?step=2"><span class="number">2.</span> Profile</a></li>
																			<li role="tab" class="disabled"><a id="form-t-2" href="index.cfm?step=3"><span class="number">3.</span> Block Dates</a></li>
																			<li role="tab" class="disabled last"><a id="form-t-3" href=""><span class="number">4.</span> Finish</a></li>										
																		</ul>
																	</div>
																
																	<div class="content clearfix" style="min-height:900px;">																
																		<h1 id="form-h-0" tabindex="-1" class="title current">Profile</h1>
																		<fieldset id="form-p-0" role="tabpanel" aria-labelledby="form-h-0" class="body current" aria-hidden="false">
																			<h2>Account Profile</h2>
																				<div class="row">
																					<div class="col-lg-8">
																						<div class="form-group">
																							<label>First Name</label>																					
																							<input type="text" class="form-control" placeholder="Shooter First Name" name="shooterfirstname" <cfif structkeyexists( form, "shooterfirstname" )>value="#trim( form.shooterfirstname )#"<cfelse>value="#trim( shooter.shooterfirstname )#"</cfif> />
																						</div>											
																				
																						<div class="form-group">
																							<label>Last Name</label>																					
																							<input type="text" class="form-control" placeholder="Shooter Last Name" name="shooterlastname" <cfif structkeyexists( form, "shooterlastname" )>value="#trim( form.shooterlastname )#"<cfelse>value="#trim( shooter.shooterlastname )#"</cfif> />
																						</div>											
																					
																						<div class="form-group">
																							<label>Address</label>																				
																							<input type="text" class="form-control" placeholder="Address 1" name="shooteradd1" <cfif structkeyexists( form, "shooteradd1" )>value="#trim( form.shooteradd1 )#"<cfelse>value="#trim( shooter.shooteraddress1 )#"</cfif> />
																						</div>											
																					
																						<div class="form-group">
																							<label>Address 2</label>																					
																							<input type="text" class="form-control" placeholder="Address 2" name="shooteradd2" <cfif structkeyexists( form, "shooteradd2" )>value="#trim( form.shooteradd2 )#"<cfelse>value="#trim( shooter.shooteraddress2 )#"</cfif> />
																						</div>											
																				
																						<div class="form-group">
																							<label>City</label>																					
																							<input type="text" class="form-control" placeholder="City" name="shootercity" <cfif structkeyexists( form, "shootercity" )>value="#trim( form.shootercity )#"<cfelse>value="#trim( shooter.shootercity )#"</cfif> />
																						</div>											
																					
																						<div class="form-group">
																							<label>State</label>																					
																								<select name="shooterstateid" id="shooterstateid" class="form-control">
																									<option value="" selected>Select State</option>
																									<cfloop query="statelist">
																										<option value="#stateid#"<cfif structkeyexists( form, "shooterstateid" )><cfif numberformat( form.shooterstateid ) eq statelist.stateid>selected</cfif><cfelse><cfif shooter.shooterstateid eq statelist.stateid>selected</cfif></cfif>>#statename#</option>
																									</cfloop>
																								</select>																					
																						</div>											
																				
																						<div class="form-group">
																							<label>Zip Code</label>																					
																							<input type="text" class="form-control" placeholder="Zip Code" name="shooterzip" <cfif structkeyexists( form, "shooterzip" )>value="#trim( form.shooterzip )#"<cfelse>value="#trim( shooter.shooterzip )#"</cfif> />
																						</div>											
																					
																						<div class="form-group">
																							<label>Email</label>																					
																							<input type="text" class="form-control" placeholder="Email Address" name="shooteremail" <cfif structkeyexists( form, "shooteremail" )>value="#trim( form.shooteremail )#"<cfelse>value="#trim( shooter.shooteremail )#"</cfif> />
																						</div>											
																				
																						<div class="form-group">
																							<label>Mobile</label>
																							<input type="text" class="form-control" placeholder="Mobile Phone Number" name="shootercellphone" <cfif structkeyexists( form, "shootercellphone" )>value="#trim( form.shootercellphone )#"<cfelse>value="#trim( shooter.shootercellphone )#"</cfif> />
																						</div>
																						
																						<div class="form-group">
																							<label>Service Provider</label>
																							<select name="shootercellprovider" id="shootercellprovider" class="form-control">
																								<option value="">Select Mobile Provider</option>															  
																								<option value="@txt.att.net">AT&amp;T</option>
																								<option value="@message.alltel.com">Alltel</option>
																								<option value="@myboostmobile.com">Boost Mobile</option>
																								<option value="@mycellone.com">Cellular South</option>
																								<option value="@cingularme.com">Consumer Cellular</option>
																								<option value="@mymetropcs.com">Metro PCS</option>
																								<option value="@messaging.nextel.com">Nextel</option>
																								<option value="@messaging.sprintpcs.com">Sprint</option>
																								<option value="@gmomail.net">T-Mobile</option>
																								<option value="@vtext.com">Verizon</option>
																								<option value="@vmobl.com">Virgin Mobile</option>
																								<option value="@noprovider">None of these</option>
																							</select>
																						</div>
																						
																						<div class="form-group">
																							<label>Alert Preference</label>																							
																							<select name="shooteralertpref" class="form-control">
																								<option value="txt">Text Message</option>
																								<option value="email">Email</option>
																							</select>
																						</div>
																						
																						
																					</div>
																					<div class="col-lg-4">
																						<div class="text-center">
																							<div style="margin-top: 20px">
																								<i class="fa fa-home" style="font-size: 180px;color: ##e5e5e5;"></i>
																							</div>
																						</div>
																					</div>
																				</div><!--- /.row --->
																		</fieldset>													
																	</div><!--- / .content --->
																
																	<div class="actions clearfix">
																		<ul role="menu" aria-label="Pagination">																		
																			<li aria-hidden="false" aria-disabled="false"><button name="savestep2" class="btn btn-md btn-primary"><i class="fa fa-save"></i> Next</button></li>																		
																		</ul>
																	</div>
																</form>
														
											
															<cfelseif structkeyexists( url, "step" ) and url.step eq 3>							
																<cfinvoke component="apis.com.register.registrationservice" method="getshooterdates" returnvariable="shooterdates">
																	<cfinvokeargument name="shooterid" value="#session.shooterid#">
																</cfinvoke>
																<form id="form-shooter-dates" method="post" action="" class="wizard-big wizard clearfix" role="application" novalidate="novalidate">
																	<div class="steps clearfix">
																		<ul role="tablist">
																			<li role="tab" class="disabled" aria-disabled="false" aria-selected="true"><a id="form-t-0" href="index.cfm?step=1" aria-controls="form-p-0"><span class="current-info audible">current step: </span><span class="number">1.</span> Account</a></li>
																			<li role="tab" class="disabled" aria-disabled="false"><a id="form-t-1" href="index.cfm?step=2" aria-controls="form-p-1"><span class="number">2.</span> Profile</a></li>
																			<li role="tab" class="disabled current" aria-disabled="false"><a id="form-t-2" href="index.cfm?step=3" aria-controls="form-p-2"><span class="number">3.</span> Block Dates</a></li>
																			<li role="tab" class="disabled last" aria-disabled="true"><a id="form-t-3" href="" aria-controls="form-p-3"><span class="number">4.</span> Finish</a></li>										
																		</ul>
																	</div>
																
																	<div class="content clearfix" style="min-height:500px;">																
																		<h1 id="form-h-0" tabindex="-1" class="title current">Profile</h1>
																		<fieldset id="form-p-0" role="tabpanel" aria-labelledby="form-h-0" class="body current" aria-hidden="false">
																			<h2>BLOCK OUT DATES</h2>
																				<div class="row">
																					<div class="col-lg-8">																						
																						<div class="ibox">
																							<div class="ibox-title">
																								<h5 class="text-orange">Dates Not Available</h5>
																							</div>
																							<div class="ibox-content">
																								<cfif shooterdates.recordcount gt 0>
																									<div class="table-responsive">
																										<table class="table table-striped table-hover">
																											<thead>
																												<th>From Date</th>
																												<th>To Date</th>																												
																											</thead>
																											<tbody>
																												<cfloop query="shooterdates">
																													<tr>
																														<td><i class="fa fa-calendar"></i></td>
																														<td>#dateformat( fromdate, "mm/dd/yyyy" )#</td>
																														<td>#dateformat( todate, "mm/dd/yyyy" )#</td>																														
																													</tr>
																												</cfloop>
																											</tbody>
																											<tfoot>
																												<tr>
																													<td colspan="3"><i class="fa fa-exclamation"></i> <span class="text-navy"> When you are finished adding block out dates, please click Next...</span></td>
																												</tr>
																											</tfoot>
																										</table>
																									</div>
																								<cfelse>
																									<div class="alert alert-info">
																										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																										<p><i class="fa fa-warning"></i> NO BLOCK OUT DATES...</p>								
																									</div>
																									
																									<span style="margin-top:25px;" class="text-navy"><i class="fa fa-exclamation"></i> If there are no block out dates, please click Next...</span>																									
																									
																								</cfif>
																							</div>
																						</div>																						
																					</div>
																					<div class="col-lg-4">
																						<div class="ibox">
																							<div class="ibox-title">
																								<h5>Add Dates NOT AVAILABLE</h5>
																							</div>
																							<div class="ibox-content">
																								<div class="form-group" id="data_5">
																									<label><small>Range select</small></label>
																									<div class="input-daterange input-group" id="datepicker">
																										<input type="text" class="input-sm form-control" name="start" value="#dateformat( today, "mm/dd/yyyy" )#">
																										<span class="input-group-addon">to</span>
																										<input type="text" class="input-sm form-control" name="end" value="#dateformat( today, "mm/dd/yyyy" )#">
																									</div>
																								</div>																								
																								<div class="hr-line-dashed"></div>									
																								<div class="form-group">																														
																									<button class="btn btn-sm btn-primary" name="addblockdates" type="submit"><i class="fa fa-save"></i> Add Block Out Dates</button>								
																								</div>																								
																							</div>
																						</div>
																					</div>
																				</div>
																		</fieldset>
																	</div>
																	<div class="actions clearfix">
																		<ul role="menu" aria-label="Pagination">																		
																			<li aria-hidden="false" aria-disabled="false"><a href="index.cfm?step=4" name="savestep3" class="btn btn-md btn-primary"><i class="fa fa-save"></i> Next</a></li>																		
																		</ul>
																	</div>
																</form>
												
											
															<cfelseif structkeyexists( url, "step" ) and url.step eq 4>
											
																<div class="row" style="margin-top:20px;">
																	<div class="ibox">							
																		<div class="jumbotron">
																			<h1><i class="fa fa-check-circle-o text-primary"></i> Almost Finished, #shooter.shooterfirstname#</h1>
																			<p>Your videographer registration is almost complete.</p>
																			<p class="small">Please agree to the terms...</p>
																			<form name="register-game-videographer-verify" method="post" action="">
																				<input id="acceptTerms" name="acceptTerms" type="checkbox" class="required" aria-required="true" value="1">
																				<label for="acceptTerms"> I agree with the <a href="terms.html" target="_blank">terms and conditions</a>.</label> <br /><br />
																				<button class="btn btn-primary btn-lg" name="finishregistration" type="submit"><i class="fa fa-arrow-circle-right"></i> Complete Registration</button>																				
																			</form>
																		</div>
																	</div>
																</div>
																
															<cfelseif structkeyexists( url, "regcomplete" ) and url.regcomplete eq "true">
											
																<div class="row" style="margin-top:20px;">
																	<div class="ibox">							
																		<div class="jumbotron">
																			<h1><i class="fa fa-check-circle-o text-primary"></i> Thanks, #shooter.shooterfirstname#</h1>
																			<p>Your videographer registration is now complete.</p>
																			<p>You will receive additional instructions from QwikCut shortly.</p>
																			<p>Thank you for completing your Game Day Videographer registration.</p>																			
																		</div>
																	</div>
																</div>

															</cfif>
													</cfif>
												</div><!--- // ibox-content --->
											</div><!--- // .ibox --->
									</cfif><!--- // close main condition ---->


									
										
								</div><!-- /.container -->
							</div><!-- /.wrapper-content -->
		

				
				
				
				
				</cfoutput>
				
				
				</div><!-- / .page-wrapper -->
        </div><!-- /.wrapper -->
		
		
		<!--- // footer --->	
		
		
		<cfoutput>
			<div class="footer fixed">
				<div class="pull-right">
					Game Video &amp; Analytics
				</div>
				<div>
					<strong>&copy; #year( now() )# Qwikcut.com.  All Rights Reserved.</strong>
				</div>				
			</div>
		</cfoutput>
		
		<!-- Mainly scripts -->
		<script src="../js/jquery-2.1.1.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		<script src="../js/plugins/metisMenu/jquery.metisMenu.js"></script>
		<script src="../js/plugins/slimscroll/jquery.slimscroll.min.js"></script>	
		
		<!-- Custom and plugin javascript -->
		<script src="../js/inspinia.js"></script>
		
		
		<!-- date picker -->
		<script src="../js/plugins/datapicker/bootstrap-datepicker.js"></script>
		<!-- Date range picker -->
		<script src="../js/plugins/daterangepicker/daterangepicker.js"></script>
			<script>
			$(document).ready(function(){
				$('#data_1 .input-group.date').datepicker({
					todayBtn: "linked",
					keyboardNavigation: false,
					forceParse: false,
					calendarWeeks: true,
					autoclose: true
				});
				$('#data_5 .input-daterange').datepicker({
					keyboardNavigation: false,
					forceParse: false,
					autoclose: true
				});
			});
		</script>
		
		
		

		<!-- Flot 
		<script src="js/plugins/flot/jquery.flot.js"></script>
		<script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
		<script src="js/plugins/flot/jquery.flot.resize.js"></script>		
		<script src="js/plugins/chartJs/Chart.min.js"></script>		
		<script src="js/plugins/peity/jquery.peity.min.js"></script>		
		<script src="js/demo/peity-demo.js"></script>
		-->
	</body>
</html>