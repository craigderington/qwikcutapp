










						<!--- // shooter accepts assignment --->
						<cfif structkeyexists( url, "event" ) and trim( url.event ) eq "shooter.accept">
							<cfif structkeyexists( url, "saID" ) and structkeyexists( url, "acceptdate" )  >
								<cfif isnumeric( url.saID ) and isdate( url.acceptdate )>
									<cfset saID = url.saID />
									<cfset acceptdate = url.acceptdate />
									<cfset vsid = url.vsid />
									<cfset today = now() />
									
									<cfquery name="getshooterid">
										select shooterid, userid
										  from shooters
										 where shooters.userid = <cfqueryparam value="#session.userid#" />
									</cfquery>
									
									<cfquery name="getshooterassignment">
										select shooterassignmentid, shooterid, vsid, gameid
										  from shooterassignments
										 where shooterassignmentid = <cfqueryparam value="#saID#" cfsqltype="cf_sql_integer" />
										   and vsid = <cfqueryparam value="#vsid#" cfsqltype="cf_sql_integer" />
									</cfquery>
									
									<cfif getshooterid.shooterid eq getshooterassignment.shooterid>
									
										<cfquery name="acceptassignment">
											update shooterassignments
											   set shooterassignstatus = <cfqueryparam value="Accepted" cfsqltype="cf_sql_varchar" />,
											       shooterassignlastupdated = <cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />,
												   shooteracceptedassignment = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
												   shooteracceptdate = <cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />
											 where shooterassignmentid = <cfqueryparam value="#saID#" cfsqltype="cf_sql_integer" />
										</cfquery>
										
										<cfset session.vsid = getshooterassignment.vsid />
										
										<!--- // set some vars for notification service --->
										<cfset notificationtype = "Shooter Notification" />
										<cfset notificationtext = "Accepted the game assignment." />
										<cfset notificationstatus = "Queued" />
										
										
										<cfquery name="createshooternotification">
											<!--- // add shooter accept to the notification service queue --->											
												insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)														  													   
													values(
															<cfqueryparam value="#vsid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#getshooterassignment.gameid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#notificationtype#" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#notificationtext#" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />,
															<cfqueryparam value="#notificationstatus#" cfsqltype="cf_sql_varchar" />,
															<cfqueryparam value="#getshooterid.shooterid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
															<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
															);
										</cfquery>
										
										<!--- // redirect to the shooter games list --->
										<cflocation url="#application.root#shooter.game&ac=1" addtoken="no">				
									
									<cfelse>
										
										<!--- // redirect back to home and show alert --->
										<cflocation url="#application.root#user.home&accessdenied=1" addtoken="yes">
									
									</cfif>								
									
								<cfelse>
									{{ the URL params are malformed }}
								</cfif>
							<cfelse>
								{{ invalid event broadcast name }}
							</cfif>
						<cfelse>
							{{ no event registered }}
						</cfif>