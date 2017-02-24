



					<cfinvoke component="apis.com.user.usershooterservice" method="getshooterassignments" returnvariable="shooterassignments">
						<cfinvokeargument name="userid" value="#session.userid#">
					</cfinvoke>
					
					<cfset today = now() />
					
					<cfoutput>	
						
						<cfif shooterassignments.recordcount gt 0>
									
							<cfloop query="shooterassignments">
								
								<button 
									type="button" 
									class="btn btn-success btn-lg btn-block"
									onclick="window.location.href='#application.root#shooter.accept&saID=#shooterassignmentid#&vsid=#vsid#&acceptdate=#dateformat( today, "mm/dd/yyyy" )#';">							
									<i class="fa fa-soccer-ball-o"></i>								
										#dateformat( gamedate, "mm-dd-yyyy" )# : #timeformat( gametime, "hh:mm tt" )# <br />
								
										#hometeam# <br /> vs. <br /> #awayteam# <br />
										@ <br />
										#fieldname# Field							
								</button>	
							</cfloop>
							<small class="help-block">* You must accept assignments to confirm your filming schedule.</small>
												
						<cfelse>
							<div class="alert alert-info">
								<p class="small"><i class="fa fa-clock-o"></i> You have no recent assignments.</p>
							</div>
						</cfif>
											
					</cfoutput>