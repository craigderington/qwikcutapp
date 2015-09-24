

													
								
								
								
								
								<cfoutput>
									<div class="row">
									
										<div class="ibox-title">
											<h5><i class="fa fa-search"></i> Search Recent Games</h5>
										</div>								
									
										<div class="col-md-1">
											<a type="button" id="loading-example-btn" class="btn btn-success btn-sm btn-outline" href="#application.root##url.event#">
												<i class="fa fa-refresh"></i> Reset
											</a>
										</div>
											
										<div class="col-md-11">										
											<form class="form-horizontal" name="searchgames" method="post" action="#application.root##url.event#">
												<fieldset>
													<div class="input-group">
														<input type="text" placeholder="Search Teams, Conferences or Game Dates" name="search" class="input-sm form-control" onblur="javascript:this.form.submit();" <cfif structkeyexists( form, "search" )>value="#trim( form.search )#"</cfif>> 
														<span class="input-group-btn">
															<button type="submit" name="dosearch" class="btn btn-sm btn-primary"> Go!</button> 
														</span>
													</div>
												</fieldset>
											</form>										
										</div>
									</div>
								
							
							
							
									<cfif structkeyexists( form, "search" )>
										<cfif trim( form.search ) neq "">
											<cfif isdate( form.search )>
												<cfset searchvartype = "date" />
												<cfset searchvar = dateformat( form.search ) />
											<cfelse>
												<cfset searchvartype = "teams" />
												<cfset searchvar = trim( form.search ) />
											</cfif>
											
											<cfinvoke component="apis.com.admin.gameadminservice" method="searchgames" returnvariable="gamesearchresults">
												<cfinvokeargument name="searchvartype" value="#searchvartype#">
												<cfinvokeargument name="searchvar" value="#searchvar#">
											</cfinvoke>
											
											<cfif gamesearchresults.recordcount gt 0>
											
											<div class="row" style="margin-top:20px;">												
												<div class="table-responsive">													
													<h4 class="text-success"><i class="fa fa-th-list"></i> Search Results | #gamesearchresults.recordcount# game<cfif gamesearchresults.recordcount gt 1>s</cfif> found.  Click Go to View Details.</h4>
													
													<table class="table table-bordered table-hover table-striped">
															<thead>
																<tr>
																	<th class="text-center">Go</th>
																	<th>Teams</th>
																	<th>Conference</th>
																	<th>Date</th>
																	<th>Game Count</th>
																</tr>
															</thead>
															<tbody>
																<cfoutput query="gamesearchresults">
																	<tr>
																		<td class="text-center text-primary"><a href="#application.root##url.event#&fuseaction=games.filter&vsid=#vsid#"><i class="fa fa-play-circle fa-2x"></i></a></td>
																		<td>#trim( awayteam )# <i>vs.</i> <strong>#trim( hometeam )#</strong></td>
																		<td>#confname#</td>
																		<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>
																		<td><span class="label label-warning">#totalgames#</span></td>
																	</tr>
																</cfoutput>													
															</tbody>
															<tfoot>
																<tr>
																	<td colspan="5"><span class="help-block"><i class="fa fa-exclamation-circle"></i><small> Home teams shown in bold.</small></span></td>
																</tr>
															</tfoot>
													</table>
												</div>
											</div>
											
											<cfelse>
											
												<div style="padding:20px;">
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<p><i class="fa fa-exclamation-circle"></i> <a class="alert-link" href="">Sorry!</a>  Your search for <i>#trim( form.search )#</i> did not match any results in the database.  Search Options are team name, conference name or game date.</p>
														<p><strong>Please try again...</strong>
													</div>
												</div>
											
											</cfif>
											
										<cfelse>
											<div style="padding:20px;">
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
													<a class="alert-link" href="">Opps.  You can't search for nothing....</a>  Search Options are team name, conference name or game date.
												</div>
											</div>
											
										</cfif>										
									</cfif>
								</cfoutput>
											