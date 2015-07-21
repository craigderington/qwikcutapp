



				<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
					<cfinvokeargument name="id" value="#url.id#">
				</cfinvoke>



				<cfoutput>			
					<div class="row">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-database"></i> Delete Team | #teamdetail.teamname#   <a style="margin-left:10px;" href="#application.root##url.event#" class="btn btn-xs btn-white btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to List</a></h5>
								<span class="pull-right">
									<a href="" class="btn btn-xs btn-primary"><i class="fa fa-check-circle-o"></i> Button A</a>
									<a style="margin-right:5px;" href="" class="btn btn-xs btn-default btn-outline"><i class="fa fa-cog"></i> Button B</a>
								</span>
							</div>
							<div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
									
										<cfset form.validate_require = "teamid|Sorry, the form encountered an unexpected error." />
											
											<cfscript>
												objValidation = createobject( "component","apis.udfs.validation" ).init();
												objValidation.setFields( form );
												objValidation.validate();
											</cfscript>

											<cfif objValidation.getErrorCount() is 0>							
												
												<!--- define our form structure and set form values --->
												<cfset t = structnew() />
												<cfset t.teamid = form.teamid />
																			
													<!--- // check our user id against the shooters table and throw error if found --->
													<cfquery name="chkdata">
														select t.teamid, t.confid, g.gameid
														  from teams t, games g
														 where (t.teamid = g.hometeamid 
															   or t.teamid = g.awayteamid)
														   and t.teamid = <cfqueryparam value="#t.teamid#" cfsqltype="cf_sql_integer" />
													</cfquery>
													
													
													<cfif chkdata.recordcount neq 0>											
													
														<div class="alert alert-danger alert-dismissable">
															<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																<h5><i class="fa fa-warning"></i> <error>Sorry, <cfoutput> #chkdata.conferencename#</cfoutput> can not be deleted:</error></h2>
																<ul>
																	<li class="formerror">Foreign key constraint on the Teams table.  Operation aborted....</li>
																</ul>
														</div>
													
													<cfelse>
														
														<!--- // no teams or related foreign data found, allow the delete record operation --->
														<cfquery name="deleteteam">
															delete 
															  from teams												   
															 where teamid = <cfqueryparam value="#t.teamid#" cfsqltype="cf_sql_integer" />												
														</cfquery>										
													
													<cflocation url="#application.root##url.event#" addtoken="no">
													
													</cfif>
									
											<!--- If the required data is missing - throw the validation error --->
											<cfelse>
											
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h2>
														<ul>
															<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
																<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
															</cfloop>
														</ul>
												</div>				
												
											</cfif>										
											
									</cfif>
									<!--- // end form processing --->
							
							
									<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#">
										<h4><i class="fa fa-warning" style="color:##f00;"></i> Delete Confirmation</h4>
										<p>This action can not be un-done.  Are you sure you want to delete <i>#teamdetail.teamname#</i> &nbsp;from the database?</p>                             
										<br /><br /><br />
										<div class="hr-line-dashed" style-="margin-top:25px;"></div>
										<div class="form-group">
											<div class="col-lg-offset-2 col-lg-10">
												<button class="btn btn-danger" type="submit" name="deleteTeamRecord"><i class="fa fa-save"></i> Delete Conference</button>
												<a href="#application.root##url.event#" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
												<input type="hidden" name="teamid" value="#teamdetail.teamid#" />
											</div>
										</div>
									</form>
							</div>
						</div>
					</div>
				</cfoutput>