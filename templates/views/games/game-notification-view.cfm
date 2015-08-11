



						<cfinvoke component="apis.com.admin.gamesnotificationservice" method="getgamenotifications" returnvariable="gamenotifications">
							<cfinvokeargument name="vsid" value="#session.vsid#">
						</cfinvoke>
						




					






						<cfoutput>
							<div class="row">
								<div class="ibox-title">
									<h5><i class="fa fa-mobile"></i> Game Notifications</h5>
									<span class="pull-right">
										<cfif isuserinrole( "admin" )>
											<cfif not structkeyexists( url, "manage" )>
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=send-notify" class="btn btn-xs btn-primary"><i class="fa fa-mobile"></i> Send</a>
											<cfelse>
												<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-xs btn-success"><i class="fa fa-times-circle"></i> Finished Notifications</a>
											</cfif>
										</cfif>
									</span>
								</div>
								
								<div class="ibox-content ibox-heading text-center border-bottom">
									<cfif gamenotifications.recordcount gt 0>
										<small class="text-navy">#gamenotifications.recordcount# game notification<cfif ( gamenotifications.recordcount gt 1 ) or ( gamenotifications.recordcount eq 0 )>s</cfif></small>
									<cfelse>
										<small class="text-danger">No notification for this game.</small>
									</cfif>									
								</div>
								
								<div class="ibox-content">
									<div class="feed-activity-list">									
										<cfif gamenotifications.recordcount gt 0>
											<cfloop query="gamenotifications">
												<div class="feed-element">
													<div>													
														<small class="pull-right">#notificationstatus#</small>
														<strong>#trim( notificationtype )#</strong>
														<cfif shooterfirstname neq "" and shooterlastname neq "">
														<div>#shooterfirstname# #shooterlastname# </div>
														</cfif>
														<div>#trim( notificationtext )#</div>											
														<small class="text-muted">#dateformat( notificationtimestamp, "mm-dd-yyyy" )# : #timeformat( notificationtimestamp, "hh:mm tt" )#</small>
													</div>
												</div>
											</cfloop>
										</cfif>
									</div>
								</div>			
							
							</div>
						</cfoutput>	
						
						
						
						
						
						
						