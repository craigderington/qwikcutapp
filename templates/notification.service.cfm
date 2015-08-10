



				<cfinvoke component="apis.com.admin.gamesnotificationservice" method="getnotificationsfromqueue" returnvariable="notificationqueue">
				</cfinvoke>




				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
						<div class="row" style="margin-top:25px;">
							<div class="ibox">
								<div class="ibox-title">
									<h5><i class="fa fa-envelope"></i> QC+ Notification Service</h5>
								</div>
								
								<div class="ibox-content ibox-heading text-center text-navy">								
									<strong>QC+ Notification Service | Processing Notifications</strong>								
								</div>	
									
								<div class="ibox-content">	
									<cfif notificationqueue.recordcount eq 0>
										
										<div class="alert alert-danger">
											<h5><i class="fa fa-times-circle"></i> Zero Notifications in Queue...  Operation aborted! </h5>
										</div>
										<!--- // cease all processing --->
										<cfabort>
										
									<cfelse>
										
										<!--- // params --->
										<cfset shooterid = notificationqueue.shooterid />
										<cfset notificationid = notificationqueue.notificationid />
											
											<cfif shooterid eq 0>
											
												<cfquery name="updatenotificationservice">
													update notifications
													   set notificationstatus = <cfqueryparam value="Sent" cfsqltype="cf_sql_varchar" />,
														   notificationqueued = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
														   notificationsent = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
													 where notificationid = <cfqueryparam value="#notificationid#" cfsqltype="cf_sql_integer" /> 
												</cfquery>
												
												<div class="alert alert-success">
													<h5><i class="fa fa-check-circle-o"></i> Game Schedule Notification Updated... </h5>
												</div>
												
											
											<cfelse>
											
												<!--- // this is a game notification // alert the shooters --->
												<!--- // get the shooter details --->
												
												<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooter" returnvariable="shooter">			
													<cfinvokeargument name="id" value="#shooterid#">
												</cfinvoke>					
												
												
												<cfif shooter.shooterisactive>
												
													<cfif trim( shooter.shooteralertpref ) eq "email">
													
														<!--- // send by email --->
														<cfinvoke component="apis.com.admin.gamesnotificationservice" method="sendgamenotifications" returnvariable="msgstatus">
															<cfinvokeargument name="shooteremail" value="#shooter.shooteremail#">
															<cfinvokeargument name="senderemail" value="info@qwikcut.com">
															<cfinvokeargument name="sendtype" value="email">
															<cfinvokeargument name="shootername" value="#shooter.shooterfirstname# #shooter.shooterlastname#">
															<cfinvokeargument name="notificationtype" value="#notificationqueue.notificationtype#">				
														</cfinvoke>
														
														<!--- // update the notification service, mark as sent --->
														<cfquery name="updatenotificationservice">
															update notifications
															   set notificationstatus = <cfqueryparam value="Sent" cfsqltype="cf_sql_varchar" />,
																   notificationqueued = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
																   notificationsent = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
															 where notificationid = <cfqueryparam value="#notificationid#" cfsqltype="cf_sql_integer" /> 
														</cfquery>
														
														<div class="alert alert-success">
															<h5><i class="fa fa-check-circle-o"></i> Shooter Notification Email Sent... </h5>
														</div>
														
														<!--- // cease all processing --->
														<cfabort>
														
														
													
													<cfelse>
													
														<!--- // send by text message --->
														<cfinvoke component="apis.com.admin.gamesnotificationservice" method="sendgamenotifications" returnvariable="msgstatus">
															<cfinvokeargument name="shooteremail" value="#shooter.shootercellphone##shooter.shootercellprovider#">
															<cfinvokeargument name="senderemail" value="info@qwikcut.com">
															<cfinvokeargument name="sendtype" value="txt">
															<cfinvokeargument name="shootername" value="#shooter.shooterfirstname# #shooter.shooterlastname#">
															<cfinvokeargument name="notificationtype" value="#notificationqueue.notificationtype#">				
														</cfinvoke>
														
														<!--- // update the notification service, mark as sent --->
														<cfquery name="updatenotificationservice">
															update notifications
															   set notificationstatus = <cfqueryparam value="Sent" cfsqltype="cf_sql_varchar" />,
																   notificationqueued = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
																   notificationsent = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
															 where notificationid = <cfqueryparam value="#notificationid#" cfsqltype="cf_sql_integer" /> 
														</cfquery>
														
														<div class="alert alert-success">
															<h5><i class="fa fa-check-circle-o"></i> Shooter Notification Text Message Sent... </h5>
														</div>
														
														<!--- // cease all processing --->
														<cfabort>
													
													
													</cfif>
												
												
												<!--- // shooter is not active, do not send notification --->
												
												<cfelse>
													
													<!--- // update the notification service // mark not sent - shooter inactive --->
													<cfquery name="updatenotificationservice">
														update notifications
														   set notificationstatus = <cfqueryparam value="Not Sent" cfsqltype="cf_sql_varchar" />,
															   notificationqueued = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
															   notificationsent = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
															   notificationtext = <cfqueryparam value="#notificationqueue.notificationtext# & ' ' & Shooter Inactive" cfsqltype="cf_sql_varchar" />
														 where notificationid = <cfqueryparam value="#notificationid#" cfsqltype="cf_sql_integer" /> 
													</cfquery>
													
													<div class="alert alert-success">
														<h5><i class="fa fa-check-circle-o"></i> Shooter Inactive.  Notification Not Sent.... </h5>
													</div>
												
												</cfif>						
											
											</cfif>					
									
									</cfif>
								</div>							
							</div>
						</div>
					</div>
				</div>