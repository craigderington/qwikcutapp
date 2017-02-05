



		<cfset today = now() />
		<cfset todayplus4 = dateadd( "d", 3, today ) />
		
		
		
		<cfif structkeyexists( url, "sDate" ) and structkeyexists( url, "eDate" )>
			<cfset gamedate = url.sDate />
			<cfset endgamedate = url.eDate />
		<cfelse>
			<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&sDate=#dateformat( today, "mm/dd/yyyy" )#&eDate=#dateformat( todayplus4, "mm/dd/yyyy" )#" addtoken="no">
		</cfif>
		
		
		
		
		
		
		
		<cfoutput>
			<div class="ibox">
				
					<div class="row">
						<div class="ibox-content">
							<div align="left">
								<h3><i class="fa fa-play-circle-o"></i> Games By Week  <a href="#application.root##url.event#&fuseaction=#url.fuseaction#" style="margin-left:15px;" class="btn btn-sm btn-success btn-outline"><i class="fa fa-refresh"></i> RESET DATES</a></h3>
							</div>
							<div align="center">
								<cfset prevdate = dateadd( "d", -4, gamedate ) />
								<cfset nextdate = dateadd( "d", 4, endgamedate ) />
								<a title="Show Previous 4 Days" href="#application.root##url.event#&fuseaction=#url.fuseaction#&sDate=#dateformat( prevdate, "mm/dd/yyyy" )#&eDate=#dateformat( gamedate - 1, "mm/dd/yyyy" )#"><i class="fa fa-fast-backward fa-3x"></i> </a>							
								<a title="Show Next 4 Days" href="#application.root##url.event#&fuseaction=#url.fuseaction#&sDate=#dateformat( endgamedate + 1, "mm/dd/yyyy" )#&eDate=#dateformat( nextdate, "mm/dd/yyyy" )#" style="margin-left:25px;"><i class="fa fa-fast-forward fa-3x"></i> </a>
							</div>							
						</div>
					</div>
				
					<div class="row">
						<div class="ibox-content">		
							<div class="row">						
								<cfset count = 1 />
								<cfloop index="loopgamedate" from="#gamedate#" to="#endgamedate#" step="1">							
									<div class="col-lg-3">
										<div class="panel <cfif datecompare( loopgamedate, today, "d" ) eq 0>panel-primary<cfelse>panel-success</cfif>">
											<div class="panel-heading">
												#dayofweekasstring(dayofweek( loopgamedate ))# : #dateformat( loopgamedate, "mm/dd/yyyy" )#								
											</div>
											<div class="panel-body">
												<div class="table-responsive">
													<table class="table table-border table-hover">
														<thead>
															<!--- // loop index output hours from 6 am to 11 pm --->
															<cfloop index="hour" from="7" to="20" step="1">
																<tr align="left">
																	<th>#timeformat( createtime( hour, 0, 0 ), "hh:mm tt" )#</th>
																</tr> 
														</thead>
														<tbody>
															
															<cfinvoke component="apis.com.admin.gameadminservice" method="getversuslist" returnvariable="versuslist">
																<cfinvokeargument name="gamedate" value="#dateformat( loopgamedate, "mm/dd/yyyy" )#">
																<cfinvokeargument name="gametime" value="#timeformat( createtime( hour, 0, 0 ), "HH:mm:ss" )#">
																<cfinvokeargument name="endgametime" value="#timeformat( createtime( hour, 59, 59), "HH:mm:ss" )#">
															</cfinvoke>
															
															<cfinvoke component="apis.com.admin.gameadminservice" method="getgameshooters" returnvariable="gameshooters">
																<cfinvokeargument name="vsid" value="#numberformat( versuslist.vsid, "9999" )#">
															</cfinvoke>														
															
															
															<cfloop query="versuslist">																
																<tr>
																	<td class="small"><span class="label label-info">Game #count#</span> #hometeam# vs. #awayteam# @ #fieldname#</td> 
																</tr>
																<tr>
																	<td class="small">																		
																		<cfif gameshooters.recordcount gt 0>
																			Shooters Assigned: 
																			<cfloop query="gameshooters">
																				<span class="text-success">#shooterfirstname# #shooterlastname#</span>																				
																			</cfloop>
																		<cfelse>
																			<span class="text-danger">No shooter assigned.</span>
																		</cfif>
																	</td>
																</tr>
																<cfset count = count + 1 />
															</cfloop>															
														</cfloop>
														</tbody>
														<tfoot>
															<tr>
																<td>this is a table footer </td>
															</tr>
														</tfoot>
													</table>								
												</div>
											</div>
											<div class="panel-footer">
												Panel Footer
											</div>
										</div><!--- // panel --->
									</div>									
								</cfloop>
							</div>
						</div>
						<div class="ibox-footer">
							this is the ibox footer...
						</div>
					</div>
				
		</cfoutput>