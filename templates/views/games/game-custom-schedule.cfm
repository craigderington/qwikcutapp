
							
							
							
							
							<cfif structkeyexists( session, "vsid" )>
								<cfset tempr = structdelete( session, "vsid" )>
							<cfelseif not structkeyexists( session, "vsid" )>
								<cfif structkeyexists( url, "fuseaction" ) and trim( url.fuseaction ) eq "game.start">
									<cfif structkeyexists( url, "vsid" ) and url.vsid neq 0>
										<cfset session.vsid = numberformat( url.vsid, "99" )>
										<cflocation url="#application.root##url.event#&fuseaction=games.mgr" addtoken="no">
									</cfif>
								</cfif>					
							</cfif>					
								
								
								
								
								<cfinvoke component="apis.com.admin.gameadminservice" method="getcustomgames" returnvariable="customgames">



								<div class="row">
									
									<div class="ibox-title">
										<h5><i class="fa fa-trophy"></i> Recent Custom Matchups</h5>
									</div>
									
									
									<cfif customgames.recordcount gt 0>
										<div class="table-responsive">
											<table class="table table-striped table-hover">
												<thead>
													<tr>
														<th>Game ID</th>
														<th>Versus</th>
														<th>Game Date</th>
														<th>Game Time</th>
													</tr>
												</thead>
												<tbody>
													<cfoutput query="customgames">
														<tr>
															<td><a href="#application.root##url.event#&fuseaction=game.start&vsid=#vsid#">#numberformat( vsid, "999" )#</a></td>
															<td>(#teamlevelname#) #awayteam# <i>vs.</i> <strong>#hometeam#</strong></td>
															<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>
															<td>#timeformat( gamestart, "hh:mm tt")#</td>
														</tr>
													</cfoutput>
												</tbody>
											</table>
										</div>
									<cfelse>
										<div class="alert alert-warning">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<h5><i class="fa fa-check-circle-o"></i> NO RECORDS FOUND!</h5>
											<p>There are no custom match ups to display in this view.  Please use the form to the left to schedule custom match ups.</p>
										</div>
									</cfif>									
								</div>