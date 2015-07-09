

			

				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> Add New State</h5>
							<div class="ibox-tools">
								<a href="#application.root##url.event#" class="btn btn-xs btn-white"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</div>
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
											<cfset state.statename = trim( form.statename ) />
											<cfset state.stateabbr = trim( form.stateabbr ) />										
											
												<cfquery name="addstate">
													insert into states(statename, stateabbr)
													 values(
															<cfqueryparam value="#state.statename#" cfsqltype="cf_sql_varchar" maxlength="50" />,
															<cfqueryparam value="#state.stateabbr#" cfsqltype="cf_sql_varchar" maxlength="2" />
															);
												</cfquery>										
												
												<cflocation url="#application.root#admin.states" addtoken="no">				
											
								
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
							
							
							
							
							
							<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#">
                                <p></p>
                                <div class="form-group">
									<label class="col-md-2 control-label">State Name</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="State Name" class="form-control" name="statename" /> 
											<span class="help-block m-b-none">Please enter the name of the state.</span>
                                    </div>
                                </div>
                                <div class="form-group">
									<label class="col-md-2 control-label">State Abbreviation</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="State Abbreviation" class="form-control" maxlength="2" name="stateabbr" />
											<span class="help-block m-b-none">Please enter the two letter state abbreviation.</span>
									</div>
                                </div>
								<br />
                                <div class="hr-line-dashed" style-="margin-top:25px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-primary" type="submit" name="stateSaveRecord"><i class="fa fa-save"></i> Save State</button>
										<a href="#application.root#admin.states" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
										<input name="validate_require" type="hidden" value="statename|The state name is required to add a new record.;stateabbr|The state abbreviation is required to add a new state." />																
									</div>
                                </div>
                            </form>
                        </div>
                    </div>
				</cfoutput>