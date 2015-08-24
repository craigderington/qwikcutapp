



					<cfinvoke component="apis.com.admin.gameadminservice" method="chkDeleteGames" returnvariable="allowDeleteGames">
						<cfinvokeargument name="id" value="#session.vsid#">					
					</cfinvoke>



		
			
				
				
				<cfoutput>
					<div class="row">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-trash"></i> Delete Games </h5>
								<span class="pull-right">
									<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-xs btn-default btn-outline"><i class="fa fa-arrow-circle-left"></i> Cancel Delete</a>
								</span>
							</div>
							<div class="ibox-content">
							
								<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "gameVersusTeams" )>
									<cfset form.validate_require = "killme|A required value is missing to complete this action.;vsid|A form error has occured.  Please go back and try again." />
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>
										
											<cfset vsid = session.vsid />
											
											<!--- delete in order --->
											<cfquery name="deletenotifications">
												delete from notifications
												  where vsid = <cfqueryparam value="#vsid#" cfsqltype="cf_sql_integer" />
											</cfquery>
											
											<cfquery name="deleteshooterassignments">
												delete from shooterassignments
												  where vsid = <cfqueryparam value="#vsid#" cfsqltype="cf_sql_integer" />
											</cfquery>
											
											<cfquery name="killgames">
												delete from games
												  where vsid = <cfqueryparam value="#vsid#" cfsqltype="cf_sql_integer" />
											</cfquery>
											
											<cfquery name="byeversus">
												delete from versus
												  where vsid = <cfqueryparam value="#vsid#" cfsqltype="cf_sql_integer" />
											</cfquery>
											
											<!--- // record the activity --->
											<cfquery name="activitylog">
												insert into activity(userid, activitydate, activitytype, activitytext)														  													   
													values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Delete Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="deleted team games in the Versus collection with ID: #vsid#." cfsqltype="cf_sql_varchar" />																
																);
											</cfquery>
											
											<cfset temp_vr = structdelete( session, "vsid" ) />
											
											<!--- // redirect to the Games Manager --->
											<cflocation url="#application.root##url.event#&scope=g1" addtoken="yes">			
											
										
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
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
								
								<cfif structkeyexists( allowDeleteGames, "shooterassignstatus" )>
									<cfif ( isNumeric( allowDeleteGames.shooterassignstatus ) and allowDeleteGames.shooterassignstatus eq 0 )
									       or ( trim( allowDeleteGames.shooterassignstatus ) eq "assigned" ) >
											<!--- // show the form to delete the games --->
											
											<cfif structkeyexists( allowDeleteGames, "gamestatus") and allowDeleteGames.gamestatus eq 0>											
												
													<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#">
														<fieldset>
															<h4><i class="fa fa-warning" style="color:##f00;"></i> Delete Confirmation</h4>
															<p>This action can not be un-done.  Are you sure you want to delete Versus ID: <i>#session.vsid#</i> from the database?</p>                             
															<br />
															<div class="hr-line-dashed" style="margin-top:15px;"></div>
															<div class="form-group">
																<div class="col-lg-offset-2 col-lg-10">
																	<button class="btn btn-danger" type="submit" name="gameVersusTeams" onclick="return confirm('Confirm Delete?');"><i class="fa fa-save"></i> Delete Games</button>
																	<a href="#application.root##url.event#" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
																	<input type="hidden" name="killme" value="true" />
																	<input type="hidden" name="vsid" value="#session.vsid#-1r5" />
																</div>
															</div>
														</fieldset>
													</form>
												
											<cfelse>
												<div class="alert alert-info">
													<h4><i class="fa fa-warning"></i> Warning.  Can Not Delete</h4>
													<p>The selected games can not be deleted because there are game status updates for the games and teams asscoaited with this match.</p>
												</div>
											</cfif>
									<cfelse>										
										<div class="alert alert-warning">
											<h4><i class="fa fa-warning"></i> Warning.  Can Not Delete</h4>
											<p>The selected games can not be deleted because the videographer has already accepted the assignment.</p>
										</div>
									</cfif>
								<cfelse>
									<div class="alert alert-danger">
										<h4><i class="fa fa-warning"></i> Warning.  Can Not Delete</h4>
										<p>The selected games can not be deleted because due to an error fetching the game records.  Please try again later...</p>
									</div>
								</cfif>
							</div>						
						</div>					
					</div>
				</cfoutput>