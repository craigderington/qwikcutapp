

			

				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> Delete State | #statedetail.statename#</h5>
							<div class="ibox-tools">
								<a href="#application.root##url.event#" class="btn btn-xs btn-white"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</div>
						</div>						
                        
                        <div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
									
										<cfset form.validate_require = "stateid|The form encountered an unexpected error." />                              
									
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset state = structnew() />
											<cfset state.stateid = form.stateid />
											<cfset state.statename = trim( form.statename ) />
																		
												<!--- // check our state id against the conferences table and throw error if found --->
												<cfquery name="chkstate">
													select c.confid
													  from conferences c
													 where c.stateid = <cfqueryparam value="#state.stateid#" cfsqltype="cf_sql_integer" />
												</cfquery>

												<cfquery name="chkuser">
												    select users.userid 
													  from users
													 where users.stateid = <cfqueryparam value="#state.stateid#" cfsqltype="cf_sql_integer" />
												</cfquery>
												
												<cfif chkstate.recordcount GT 0 and chkuser.recordcount GT 0>											
												
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<h5><error>Sorry, <cfoutput> #state.statename#</cfoutput> can not be deleted:</error></h2>
															<ul>
																<li class="formerror">The database threw a referential integrity error. </li> 
																<li class="formerror">The state ID of the state selected to be deleted exists in tables:  conferences and users  </li>
															</ul>
													</div>												
												
												<cfelse>
													
													<!--- // no conferences or related data found, allow the delete record operation --->
													<cfquery name="deletestate">
														delete 
														  from states													   
														 where stateid = <cfqueryparam value="#state.stateid#" cfsqltype="cf_sql_integer" />														
													</cfquery>

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Delete Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="deleted the state of #state.statename# from the system." cfsqltype="cf_sql_varchar" />																
																);
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
							
							
							
							
							
							<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&stateid=#url.stateid#">
                                <h4><i class="fa fa-warning" style="color:##f00;"></i> Delete Confirmation</h4>
								<p>This action can not be un-done.  Are you sure you want to delete the #statedetail.statename# record?</p>                               
								<br /><br /><br />
                                <div class="hr-line-dashed" style-="margin-top:25px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-danger" type="submit" name="stateSaveRecord"><i class="fa fa-save"></i> Delete State</button>
										<a href="#application.root#admin.states" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
										<input type="hidden" name="stateid" value="#statedetail.stateid#" />
										<input type="hidden" name="statename" value="#statedetail.statename#" />
									</div>
								</div>
                            </form>
                        </div>
                    </div>
				</cfoutput>