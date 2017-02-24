



				<cfif structkeyexists( session, "vsid" )>
					<cfset tempr = structdelete( session, "vsid" ) />
				</cfif>
				
				<cfif structkeyexists( session, "shooterid" )>
					<cfset tempr = structdelete( session, "shooterid" ) />
				</cfif>		
				
				<!--- // some date/time vars for the page --->
				<cfset currentdatetime = now() />
				<cfset currentdatetime = ParseDateTime( currentdatetime ) />								
				
				<cfoutput>
				<!--- // main wrapper --->
					<div class="wrapper wrapper-content animated fadeIn">
						<div class="container">
							<div class="row" style="margin-top:15px;">
								<div class="text-center animated fadeInRightBig">
									<div class="col-lg-12 white-bg" style="padding:50px;">                        
										<h3><i class="fa fa-video-camera"></i> #session.username# </h3>
										<h5>New Game Assignments</h5>							
											<p><span class="label -label-warning"><i class="fa fa-clock-o"></i> Game check-in 15 minutes prior to game start.</span></p> 
										
											<p><i class="fa fa-calendar-o"></i> <strong>Current Server Time:</strong></p> 
											<p>#dateformat( currentdatetime, "mm-dd-yyyy" )# : #timeformat( currentdatetime, "hh:mm:ss tt" )#</p>
											<cfinclude template="views/shooters/shooter-assignments.cfm">
									</div>
								</div>
							</div>
						</div>
					</div>
				</cfoutput>	