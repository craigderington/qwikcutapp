





			

			

				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> Add New Conference</h5>
							<div class="ibox-tools">
								<a href="#application.root##url.event#" class="btn btn-xs btn-white"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</div>
                        </div>						
                        
                        <div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
										
										<cfset form.validate_require = "stateid|The state is required to add a new conference.;conferencename|The conference name is required to save the record.;conferencetype|Please select a conference type." />
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset c = structnew() />
											<cfset c.stateid = form.stateid />
											<cfset c.conferencename = trim( form.conferencename ) />
											<cfset c.conferencetype = trim( form.conferencetype ) />										
											
												<cfquery name="addconference">
													insert into conferences(stateid, confname, conftype, confactive)
													 values(
															<cfqueryparam value="#c.stateid#" cfsqltype="cf_sql_integer" />,
															<cfqueryparam value="#c.conferencename#" cfsqltype="cf_sql_varchar" maxlength="50" />,
															<cfqueryparam value="#c.conferencetype#" cfsqltype="cf_sql_varchar" maxlength="2" />,
															<cfqueryparam value="1" cfsqltype="cf_sql_bit" />															
															);
												</cfquery>										
												
												<cflocation url="#application.root#admin.conferences" addtoken="no">				
											
								
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
                               
							   <div class="form-group">
									<label class="col-md-2 control-label">State</label>
                                    <div class="col-md-4">
										<select class="form-control m-b" name="stateid">
											<option value="">Select a State</option>
											<cfloop query="statelist">
												<option value="#stateid#">#statename#</option>
											</cfloop>
										</select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-2 control-label">Conference Name</label>
                                    <div class="col-md-4">
										<input type="text" placeholder="Conference Name" class="form-control" name="conferencename" /> 
											<span class="help-block m-b-none">Please enter the name of the conference.</span>
                                    </div>
                                </div>
                                <div class="form-group">
									<label class="col-md-2 control-label">Conference Type</label>
                                    <div class="col-md-4">
										<label style="margin-top:7px;"> 
											<input value="YF" id="conferencetype" name="conferencetype" type="radio"> Youth Football 
										</label>																				
										<br />
										<label style="margin-top:5px;"> 
											<input value="HS" id="conferencetype" name="conferencetype" type="radio"> High School Football 
										</label>																				
									</div>
                                </div>
								<br />
                                <div class="hr-line-dashed" style-="margin-top:25px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-primary" type="submit" name="stateSaveRecord"><i class="fa fa-save"></i> Save Conference</button>
										<a href="#application.root#admin.conferences" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
									</div>
                                </div>
                            </form>
                        </div>
                    </div>
				</cfoutput>