


					
					
				<cfinvoke component="apis.com.admin.gamealertservice" method="pollgames" returnvariable="gamealertsgenerated">				
					<cfinvokeargument name="gamedate" value="1/28/2017 12:00:00">
					<cfinvokeargument name="enddate" value="1/29/2017 12:00:00">
				</cfinvoke>




					<div class="wrapper wrapper-content animated fadeIn" style="margin-top:25px;">
						<div class="container">		
							<div class="row">
								<div class="col-md-12">
									<div class="ibox" style="margin-top:-15px;">
										<div class="ibox-title">
											<h5><i class="fa fa-text"></i> Game Alert Notification and Confirmation Service</h5>
										</div>
										
										<div class="ibox-content">
											<cfoutput>						
												#gamealertsgenerated#		
							
												<cfquery name="getalerts">
													select top 1 alertid
													from alerts
													where alertqueued = 1 
													  and alertsent <> 1
													  and alertsentdate is NULL
												</cfquery>
												
												<cfif getalerts.recordcount eq 1>
												
													<cfinvoke component="apis.com.admin.gamealertservice" method="sendgamealerts" returnvariable="msgstatus">				
														<cfinvokeargument name="alertid" value="#getalerts.alertid#">				
													</cfinvoke>
													
													<cfoutput>
														#msgstatus#
													</cfoutput>
													
												<cfelse>
													
													No alerts to send...
												
												</cfif>
											</cfoutput>
										</div>
									</div>
								</div>
							</div>									
						</div>
					</div>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			