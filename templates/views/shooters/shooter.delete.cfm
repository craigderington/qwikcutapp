





			<cfoutput>
				<div class="row">
					<div class="ibox">
						<div class="ibox-title">
							<h5><i class="fa fa-database"></i> Delete Shooter | #shooter.shooterfirstname# #shooter.shooterlastname#</h5>
							<span class="pull-right">
								<a href="#application.root##url.event#" class="btn btn-xs btn-default btn-outline"><i class="fa fa-cog"></i> Admin Home</a>
								<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</span>
						</div>
						<div class="ibox-content">
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
									
										<cfset form.validate_require = "shooterid|The form encountered an unexpected error." />                              
									
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset sh = structnew() />
											<cfset sh.shooterid = form.shooterid />
																		
												<!--- // check our state id against the conferences table and throw error if found --->
												<cfquery name="chkshooter">
													select sh.shooterid, sh.shooterfirstname, sh.shooterlastname, g.gameid
													  from shooters sh, games g
													 where sh.shooterid = g.gameid
													   and sh.shooterid = <cfqueryparam value="#sh.shooterid#" cfsqltype="cf_sql_integer" />
												</cfquery>
												
												
												<cfif chkshooter.recordcount neq 0>											
												
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<h5><error>Sorry, <cfoutput> #chkshooter.shooterfirstname# #chkshooter.shooterlastname#</cfoutput> can not be deleted from this system:</error></h2>
															<ul>
																<li class="formerror">Forgeign key constraint on GAMES. The selected shooter has games on record.</li>
															</ul>
													</div>
												
												<cfelse>
													
													<!--- // no games or other related data found, allow the delete record operation --->
													<cfquery name="deleteshooter">
														delete 
														  from shooters												   
														 where shooterid = <cfqueryparam value="#sh.shooterid#" cfsqltype="cf_sql_integer" />														
													</cfquery>

													<!--- // clean up the shooter block out dates table --->
													<cfquery name="deleteshooterdates">
														delete 
														  from shooterblockoutdates												   
														 where shooterid = <cfqueryparam value="#sh.shooterid#" cfsqltype="cf_sql_integer" />														
													</cfquery>
													
													<!--- // clean up the shooter assigned fields table --->
													<cfquery name="deleteshooterfields">
														delete 
														  from shooterfields												   
														 where shooterid = <cfqueryparam value="#sh.shooterid#" cfsqltype="cf_sql_integer" />														
													</cfquery>
												
												<cflocation url="#application.root##url.event#&scope=s3" addtoken="no">
												
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
						
						
						
						
						
						
						
						
						
						
							<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#shooter.shooterid#">
                                <h4><i class="fa fa-warning" style="color:##f00;"></i> Delete Confirmation</h4>
								<p>This action can not be un-done.  Are you sure you want to delete #shooter.shooterfirstname# #shooter.shooterlastname# videographer profile?</p>                               
								<br /><br /><br />
                                <div class="hr-line-dashed" style-="margin-top:25px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-danger" type="submit" name="killShooterRecord"><i class="fa fa-save"></i> Delete Shooter</button>
										<a href="#application.root##url.event#" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
										<input type="hidden" name="shooterid" value="#shooter.shooterid#" />
									</div>
								</div>
                            </form>
						</div>					
					</div>			
				</div>			
			</cfoutput>