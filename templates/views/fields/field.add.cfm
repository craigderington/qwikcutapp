			



									
						
						<cfoutput>
							
							<div class="row">							
									
								<div class="ibox" style="margin-top:-15px;">								
									
									<div class="ibox-title">
										<h5><i class="fa fa-stop"></i> Add Field Details <a href="#application.root##url.event#" style="margin-left:20px;margin-top:-2px;" class="btn btn-white btn-xs"><i class="fa fa-arrow-circle-left"></i> Cancel</a></h5>
									</div>
										
									<div class="ibox-content">
										
										<!--- // begin form processing --->
										<cfif isDefined( "form.fieldnames" )>
										
											<cfset form.validate_require = "stateid|Please select a state for this field.;fieldname|Please enter a name for this field.;fieldaddress1|Please enter the primary address.;fieldcity|Please enter the city for this field.;fieldzip|Please enter the field zip code.;fieldcontactname|Please enter the field contact name.;fieldcontactnumber|Please enter the primary contacts phone number.;fieldcontacttitle|Please enter the field contact title." />
											
											<cfscript>
												objValidation = createobject( "component","apis.udfs.validation" ).init();
												objValidation.setFields( form );
												objValidation.validate();
											</cfscript>

											<cfif objValidation.getErrorCount() is 0>							
												
												<!--- define our form structure and set form values --->
												<cfset f = structnew() />
												<cfset f.stateid = form.stateid />
												<cfset f.fieldname = trim( form.fieldname ) />
												<cfset f.fieldactive = 1 />
												<cfset f.fieldaddress1 = trim( form.fieldaddress1 ) />
												<cfset f.fieldaddress2 = trim( form.fieldaddress2 ) />
												<cfset f.fieldcity = trim( form.fieldcity ) />												
												<cfset f.fieldzip = form.fieldzip />
												<cfset f.fieldcontactname = trim( form.fieldcontactname ) />
												<cfset f.fieldcontacttitle = trim( form.fieldcontacttitle ) />
												<cfset f.fieldcontactnumber = trim( form.fieldcontactnumber ) />
												
													<cfquery name="addfield">
														insert into fields(stateid, fieldname, fieldactive, fieldaddress1, fieldaddress2, fieldcity, fieldzip, fieldcontactname, fieldcontacttitle, fieldcontactnumber)
														 values(
																<cfqueryparam value="#f.stateid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#f.fieldname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#f.fieldactive#" cfsqltype="cf_sql_bit" />,
																<cfqueryparam value="#f.fieldaddress1#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#f.fieldaddress2#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#f.fieldcity#" cfsqltype="cf_sql_varchar" maxlength="50" />,																
																<cfqueryparam value="#f.fieldzip#" cfsqltype="cf_sql_numeric" />,
																<cfqueryparam value="#f.fieldcontactname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#f.fieldcontacttitle#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																<cfqueryparam value="#f.fieldcontactnumber#" cfsqltype="cf_sql_varchar" maxlength="50" />
																);
													</cfquery>										
													
													<cflocation url="#application.root##url.event#" addtoken="no">				
												
									
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
											<fieldset class="form-horizontal">				
												<div class="form-group"><label class="col-sm-2 control-label">Field:</label>
													<div class="col-sm-10"><input type="text" name="fieldname" class="form-control" placeholder="Field Name" <cfif isdefined( "form.fieldname" )>value="#form.fieldname#"</cfif> /></div>
												</div>											
												<div class="form-group"><label class="col-sm-2 control-label">Address:</label>
													<div class="col-sm-10"><input type="text" name="fieldaddress1" class="form-control" placeholder="Address 1" <cfif isdefined( "form.fieldaddress1" )>value="#form.fieldaddress1#"</cfif> /></div>
												</div>
												<div class="form-group"><label class="col-sm-2 control-label">Address:</label>
													<div class="col-sm-10"><input type="text" name="fieldaddress2" class="form-control" placeholder="Address 2" <cfif isdefined( "form.fieldaddress2" )>value="#form.fieldaddress2#"</cfif> /></div>
												</div>
												<div class="form-group"><label class="col-sm-2 control-label">City:</label>
													<div class="col-sm-10"><input type="text" name="fieldcity" class="form-control" placeholder="City" <cfif isdefined( "form.fieldcity" )>value="#form.fieldcity#"</cfif> /></div>
												</div>
												<div class="form-group"><label class="col-sm-2 control-label">State:</label>
													<div class="col-sm-10">
														<select class="form-control" name="stateid">
															<option value="">Select State</option>
																<cfloop query="statelist">															
																	<option value="#stateid#"<cfif isdefined( "form.stateid" )><cfif form.stateid = statelist.stateid>selected</cfif></cfif>>#statename#</option>
																</cfloop>
														</select>
													</div>
												</div>
												<div class="form-group"><label class="col-sm-2 control-label">Zip:</label>
													<div class="col-sm-10"><input type="text" name="fieldzip" maxlength="5" class="form-control" placeholder="Zip Code" <cfif isdefined( "form.fieldzip" )>value="#form.fieldzip#"</cfif> /></div>
												</div>													
												<div class="form-group"><label class="col-sm-2 control-label">Contact:</label>
													<div class="col-sm-10"><input type="text" name="fieldcontactname" class="form-control" placeholder="Primary Contact" <cfif isdefined( "form.fieldcontactname" )>value="#form.fieldcontactname#"</cfif> /></div>
												</div>
												<div class="form-group"><label class="col-sm-2 control-label">Title:</label>
													<div class="col-sm-10"><input type="text" name="fieldcontacttitle" class="form-control" placeholder="Primary Contact Title" <cfif isdefined( "form.fieldcontacttitle" )>value="#form.fieldcontacttitle#"</cfif>  /></div>
												</div>
												<div class="form-group"><label class="col-sm-2 control-label">Number:</label>
													<div class="col-sm-10"><input type="text" name="fieldcontactnumber" class="form-control" placeholder="Contact Phone Number" <cfif isdefined( "form.fieldcontactnumber" )>value="#form.fieldcontactnumber#"</cfif> /></div>
												</div>
												<br />
												<div class="hr-line-dashed" style="margin-top:25px;"></div>
												<div class="form-group">
													<div class="col-lg-offset-2 col-lg-10">
														<button class="btn btn-primary" type="submit" name="stateFieldRecord"><i class="fa fa-save"></i> Save Field</button>
														<a href="#application.root##url.event#" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
													</div>
												</div>																
											</fieldset>
										</form>
									</div>		
								</div>						
							</div>
						</cfoutput>