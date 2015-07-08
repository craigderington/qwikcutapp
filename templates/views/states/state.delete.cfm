

			

				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> Delete State | #statedetail.statename#</h5>
                        </div>						
                        
                        <div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset state = structnew() />
											<cfset state.stateid = form.stateid />
																		
												<!--- // check our state id against the conferences table and throw error if found --->
												<cfquery name="chkstate">
													select c.confid, s.statename
													  from conferences c, states s
													 where c.stateid = s.stateid
													   and s.stateid = <cfqueryparam value="#state.stateid#" cfsqltype="cf_sql_integer" />
												</cfquery>
												
												
												<cfif chkstate.recordcount neq 0>											
												
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<h5><error>Sorry, <cfoutput> #chkstate.statename#</cfoutput> can not be deleted:</error></h2>
															<ul>
																<li class="formerror">Forgeign key constraint on conferences.</li>
															</ul>
													</div>
												
												<cfelse>
													
													<!--- // no conferences or related data found, allow the delete record operation --->
													<cfquery name="deletestate">
														delete 
														  from states													   
														 where stateid = <cfqueryparam value="#state.stateid#" cfsqltype="cf_sql_integer" />														
													</cfquery>										
												
												<cflocation url="#application.root#admin.states" addtoken="no">
												
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
										<input name="validate_require" type="hidden" value="stateid|The form encountered an unexpected error." />
                                </div>
                            </form>
                        </div>
                    </div>
				</cfoutput>