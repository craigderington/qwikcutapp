									
								

								
								
								
								<cfparam name="sdate" default="">
								<cfparam name="edate" default="">
								
								<cfset sdate = createdatetime(year(now()), month(now()), 01, 06, 00, 00 ) />
								<cfset edate = now() />

								<cfinvoke component="apis.com.store.storeservice" method="getrecentgames" returnvariable="recentgames">
									<cfinvokeargument name="sdate" value="#sdate#">
									<cfinvokeargument name="edate" value="#edate#">
								</cfinvoke>
								
									
									
									
									
								<cfoutput>
									<div class="ibox">
										<div class="ibox-title">
											<h5><i class="fa fa-clock-o"></i> Recent Games</h5>
										</div>
										<div class="ibox-content">
											<cfif isdefined( "errormsg" )>
												<div class="alert alert-info">
													<h5>#errormsg#</h5>
												</div>
											</cfif>
											<cfif recentgames.recordcount gt 0> 
											<div class="feed-activity-list">
                                                <cfloop query="recentgames">
													<div class="feed-element">
														<a href="index.cfm?fuseaction=getgames&vsid=#vsid#&startpage=recent" class="pull-left">
															<img alt="image" class="img-circle" src="img/qwikcut_logo_reel.jpg">
														</a>
														<div class="media-body ">
															<small class="pull-right">#teamlevelname#</small>
															<strong>#awayteam# <i>vs.</i> #hometeam# @ #fieldname# field.</strong>  <br>
															<small class="text-muted">#dateformat( gamedate, "mm-dd-yyyy" )# | #timeformat( gamestart, "hh:mm tt" )#</small>
														</div>
													</div>
												</cfloop>
                                            </div>
											<cfelse>
												<div class="alert alert-info">
													<h5>No recent games to display...</h5>
												</div>
											</cfif>
										</div>
									</div>
								</cfoutput>