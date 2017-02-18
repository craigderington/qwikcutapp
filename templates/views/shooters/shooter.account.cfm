





					<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooteraccountdetails" returnvariable="shooteraccountdetails">
						<cfinvokeargument name="id" value="#url.id#">
					</cfinvoke>
					
					
					





				


					




				<cfoutput>
					<div class="row">
						<div class="ibox">					
							<div class="ibox-title">
								<h5><i class="fa fa-video-camera"></i> Shooter Account Details | #shooter.shooterfirstname# #shooter.shooterlastname#   <cfif isuserinrole( "admin" )><a href="#application.root##url.event#&fuseaction=shooter.edit&id=#shooter.shooterid#" class="btn btn-xs btn-primary btn-outline" style="margin-left:15px;"><i class="fa fa-edit"></i> Edit Shooter</a></cfif></h5>
								<span class="pull-right">
									<a href="#application.root#admin.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-cog"></i> Admin Home</a>
									<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline" style="margin-left:5px;"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
								</span>
							</div>
							<div class="ibox-content">
								
								<!--- // system messages --->
								<cfif structkeyexists( url, "scope" )>									
									<cfif numberformat( url.scope, "99" ) eq 6>						
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<p><i class="fa fa-check-circle-o"></i> Shooter Account Details Saved...</p>								
										</div>									
									</cfif>					
								</cfif>
							
									
							
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li><a data-toggle="tab" href="##tab-1"><i class="fa fa-video-camera"></i> Shooter Details</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.regions&id=#url.id#"><i class="fa fa-map-marker"></i> Regions</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.dates&id=#url.id#"><i class="fa fa-calendar"></i> Availability</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>
										<li class="active"><a href="#application.root##url.event#&fuseaction=shooter.account&id=#url.id#"><i class="fa fa-money"></i> Account</a></li>
										<li class=""><a href="#application.root##url.event#&fuseaction=shooter.comments&id=#url.id#"><i class="fa fa-comments"></i> Rating &amp; Comments</a></li>																							
									</ul>			
											
																					
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">

												<!--- // process the invitation form --->
												<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "saveShooterAccountDetails" )>
													<cfset form.validate_require = "shooterid|Opps, internal form error.;bankname|The shooters bank name is required to save the form.;accountnumber|The account number is required to save the form.;routingnumber|The routing number is required to asave the form." />
					
													<cfscript>
															objValidation = createobject( "component","apis.udfs.validation" ).init();
															objValidation.setFields( form );
															objValidation.validate();
														</cfscript>
														<cfif objValidation.getErrorCount() is 0>												
															
															<cfset sh = structnew() />
															<cfset sh.shooterid = form.shooterid />															
															<cfset sh.shooterbankname = form.bankname />
															<cfset sh.bankname = trim( form.bankname ) />
															<cfset sh.routingnumber = trim( form.routingnumber ) />
															<cfset sh.accountnumber = trim( form.accountnumber ) />															
															
															<cfquery name="saveshooteraccountdetails">
																update shooters
																   set shooterbankname = <cfqueryparam value="#sh.bankname#" cfsqltype="cf_sql_varchar" />,
																	   shooterbankroutingnumber = <cfqueryparam value="#sh.routingnumber#" cfsqltype="cf_sql_varchar" />,
																	   shooterbankaccountnumber = <cfqueryparam value="#sh.accountnumber#" cfsqltype="cf_sql_varchar" />
																 where shooterid = <cfqueryparam value="#sh.shooterid#" cfsqltype="cf_sql_integer" />
															</cfquery>															
															
															<!--- // record the activity --->
															<cfquery name="activitylog">
																insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																	values(
																			<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																			<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																			<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																			<cfqueryparam value="updated the shooter's account settings for #shooter.shooterfirstname# #shooter.shooterlastname#." cfsqltype="cf_sql_varchar" />																
																		);
															</cfquery>										
															
															<!--- // redirect to shooter page --->
															<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&scope=6" addtoken="no">
															
															
															
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



												<cfif shooteraccountdetails.recordcount eq 1>
													<form class="form-horizontal" method="post" name="savesettings" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#">																					
														<fieldset>
															<!--- // mask the account details for extra security --->
															<cfif len( shooteraccountdetails.shooterbankaccountnumber ) gt 6>
																<cfset accountmask = repeatstring( "*", len( shooteraccountdetails.shooterbankaccountnumber ) - 6 ) />
															<cfelse>
																<cfset accountmask = "" />
															</cfif>
															<cfif len( shooteraccountdetails.shooterbankroutingnumber ) gt 5>
																<cfset routingmask = repeatstring( "*", len( shooteraccountdetails.shooterbankroutingnumber ) - 5 ) />
															<cfelse>
																<cfset routingmask = "" />
															</cfif>
															
															<cfif shooter.shooterisactive neq 1>

																<div class="alert alert-box alert-danger alert-dismissable fade in">
																	<a href="##" class="close" data-dismiss="alert" aria-label="close">&times;</a>
																	<h3><strong><i class="fa fa-warning"></i> WARNING!</strong> This shooter is not active.  </h3>
																	<p>No changes to this shooter's account settings are allowed while the shooter is not active.  Re-activate the shooter first before changing the account settings.</p>
																</div>																
															
															<cfelse>											
																<!--- // account settings for payroll --->
																<div class="form-group"><label class="col-sm-2 control-label">Name of Bank:</label>
																	<div class="col-sm-6">
																		<input type="text" class="form-control" placeholder="Name of Bank" name="bankname" value="<cfif structkeyexists( form, "bankname" )>#trim( form.bankname )#<cfelse>#trim( shooteraccountdetails.shooterbankname )#</cfif>" />
																		<span class="help-block m-b-none">Example: Wells Fargo</span> 
																	</div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Routing Number:</label>
																	<div class="col-sm-6"><input type="text" class="form-control" placeholder="Routing Number" name="routingnumber" value="<cfif structkeyexists( form, "routingnumber" )>#trim( form.routingnumber )#<cfelse>#routingmask##trim( right( shooteraccountdetails.shooterbankroutingnumber, 5 ))#</cfif>" /></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Account Number:</label>
																	<div class="col-sm-6"><input type="text" class="form-control" placeholder="Account Number" name="accountnumber" value="<cfif structkeyexists( form, "accountnumber" )>#trim( form.accountnumber )#<cfelse>#accountmask##trim( right( shooteraccountdetails.shooterbankaccountnumber, 6 ))#</cfif>" /></div>
																</div>													
																													
																<div class="hr-line-dashed" style="margin-top:25px;"></div>
														
																<div class="form-group">
																	<div class="col-lg-offset-2 col-lg-6">
																		<button class="btn btn-primary" type="submit" name="saveShooterAccountDetails"><i class="fa fa-save"></i> Save Account</button>
																		<input type="hidden" name="shooterid" value="#url.id#" />
																		<a href="#application.root#admin.shooters" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
																	</div>
																</div>
															</cfif>
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