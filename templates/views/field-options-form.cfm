





						
							
									<!--- // begin form processing --->
									<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "addFieldOption" )>
										
										<cfset form.validate_require = "fieldoptiondescr|The field option description is required to save this input." />
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset fo = structnew() />
											<cfset fo.fieldoptiondescr = trim( form.fieldoptiondescr ) />
																				
											
												<cfquery name="addfieldoption">
													insert into fieldoptions(fieldoptiondescr)
													 values(
															<cfqueryparam value="#fo.fieldoptiondescr#" cfsqltype="cf_sql_varchar" />																												
															);
												</cfquery>

												<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="added field option #fo.fieldoptiondescr# to the system." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>
												
												<cflocation url="#application.root##url.event#&scope=s1" addtoken="no">				
											
								
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
							
							
							<cfoutput>
							
							<form role="form" class="form-inline" method="post" action="#application.root##url.event#">
                                <div class="form-group">                                    
									<div class="col-md-2">
										<label for="fieldoptiondescr" class="sr-only">Field Option</label>
										<input type="text" placeholder="Enter Field Option" name="fieldoptiondescr" id="fieldoptiondescr" class="form-control" <cfif structkeyexists( form, "fieldoptiondescr" )>value="#trim( form.fieldoptiondescr )#"</cfif> />
									</div>
								</div>                              
                                <button style="margin-top:4px;" class="btn btn-sm btn-success btn-outline" type="submit" name="addFieldOption">Add Field Option</button>
                            </form>
						</cfoutput>