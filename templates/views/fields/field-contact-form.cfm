


												<div class="ibox">
													<div class="ibox-title">
														<h5>
															<cfif not structkeyexists( url, "contactid" )>
																<i class="fa fa-plus"></i> Add Contact
															<cfelse>
																<cfinvoke component="apis.com.admin.fieldadminservice" method="getfieldcontact" returnvariable="fieldcontactdetails">
																	<cfinvokeargument name="id" value="#url.contactid#">
																</cfinvoke>
																<i class="fa fa-edit"></i> Edit Field Contact
															</cfif>
														</h5>
													</div>
													<div class="ibox-content">								
														
														<!--- // begin form processing --->
														<cfif isDefined( "form.fieldnames" )>
														
															<cfset form.validate_require = "fcid|Ops, form error...;fieldid|Sorry, there was a problem with the form submission.;fieldcontactname|Please enter a contact name.;fieldcontacttitle|Please enter a contact title.;fieldcontactnumber|Please enter a contact number.;fieldcontactemail|Please enter the contact email address." />																
														
															<cfscript>
																objValidation = createobject( "component","apis.udfs.validation" ).init();
																objValidation.setFields( form );
																objValidation.validate();
															</cfscript>

															<cfif objValidation.getErrorCount() is 0>							
																
																<cfset fc = structnew() />
																<cfset fc.fcid = form.fcid />
																<cfset fc.fieldid = form.fieldid />
																<cfset fc.fieldcontactname = trim( form.fieldcontactname ) />
																<cfset fc.fieldcontacttitle = trim( form.fieldcontacttitle ) />
																<cfset fc.fieldcontactnumber = trim( form.fieldcontactnumber ) />
																<cfset fc.fieldcontactemail = trim( form.fieldcontactemail ) />
																<cfset fc.fieldcontactorg = trim( form.fieldcontactorg ) />
																
																<cfif fc.fcid eq 0>
																
																	<cfquery name="addfieldcontact">
																		insert into fieldcontacts(fieldid, fieldcontactname, fieldcontacttitle, fieldcontactnumber, fieldcontactemail, fieldcontactorg)
																		 values(
																				<cfqueryparam value="#fc.fieldid#" cfsqltype="cf_sql_integer" />,																				
																				<cfqueryparam value="#fc.fieldcontactname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#fc.fieldcontacttitle#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#fc.fieldcontactnumber#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#fc.fieldcontactemail#" cfsqltype="cf_sql_varchar" maxlength="80" />,
																				<cfqueryparam value="#fc.fieldcontactorg#" cfsqltype="cf_sql_varchar" maxlength="50" />
																				);
																	</cfquery>										
																	
																	<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&fc.scope=1" addtoken="no">			
																
																<cfelse>
																
																	<cfquery name="editfieldcontact">
																		update fieldcontacts
																		   set fieldcontactname = <cfqueryparam value="#fc.fieldcontactname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																			   fieldcontacttitle = <cfqueryparam value="#fc.fieldcontacttitle#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																			   fieldcontactnumber = <cfqueryparam value="#fc.fieldcontactnumber#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																			   fieldcontactemail = <cfqueryparam value="#fc.fieldcontactemail#" cfsqltype="cf_sql_varchar" maxlength="80" />,
																			   fieldcontactorg = <cfqueryparam value="#fc.fieldcontactorg#" cfsqltype="cf_sql_varchar" maxlength="50" />
																		 where fieldcontactid = <cfqueryparam value="#fc.fcid#" cfsqltype="cf_sql_integer" />																			
																	</cfquery>										
																	
																	<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&fc.scope=2" addtoken="no">			
																
																
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
														
														
														
														
														<cfoutput>
															<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#">
																<cfif not structkeyexists( url, "contactid" )>
																	<p class="small">Please enter the contact details...</p>
																<cfelse>
																	<p class="small">Please edit the contact details...</p>
																</cfif>
																
																<div class="form-group">
																	<label class="col-lg-2 control-label">Name</label>
																	<div class="col-lg-10">
																		<input type="name" placeholder="Contact Name" name="fieldcontactname" class="form-control" <cfif structkeyexists( form, "fieldcontactname" )>value="#trim( form.fieldcontactname )#"<cfelseif structkeyexists( url, "contactid" )>value="#trim( fieldcontactdetails.fieldcontactname )#"</cfif> />									
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-lg-2 control-label">Title</label>
																	<div class="col-lg-10">
																		<input type="text" placeholder="Contact Title" name="fieldcontacttitle" class="form-control" <cfif structkeyexists( form, "fieldcontacttitle" )>value="#trim( form.fieldcontacttitle )#"<cfelseif structkeyexists( url, "contactid" )>value="#trim( fieldcontactdetails.fieldcontacttitle )#"</cfif> />									
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-lg-2 control-label">Org</label>
																	<div class="col-lg-10">
																		<input type="text" placeholder="Contact Organization" name="fieldcontactorg" class="form-control" <cfif structkeyexists( form, "fieldcontactorg" )>value="#trim( form.fieldcontactorg )#"<cfelseif structkeyexists( url, "contactid" )>value="#trim( fieldcontactdetails.fieldcontactorg )#"</cfif> />									
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-lg-2 control-label">Number</label>
																	<div class="col-lg-10">
																		<input type="text" placeholder="Contact Number" name="fieldcontactnumber" class="form-control" <cfif structkeyexists( form, "fieldcontactnumber" )>value="#trim( form.fieldcontactnumber )#"<cfelseif structkeyexists( url, "contactid" )>value="#trim( fieldcontactdetails.fieldcontactnumber )#"</cfif> />							
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-lg-2 control-label">Email</label>
																	<div class="col-lg-10">
																		<input type="email" placeholder="Contact Email" name="fieldcontactemail" class="form-control" <cfif structkeyexists( form, "fieldcontactemail" )>value="#trim( form.fieldcontactemail )#"<cfelseif structkeyexists( url, "contactid" )>value="#trim( fieldcontactdetails.fieldcontactemail )#"</cfif> />
																	</div>
																</div>				                                
																<div class="form-group">
																	<div class="col-lg-offset-2 col-lg-10">
																		<cfif not structkeyexists( url, "contactid" )>
																			<button class="btn btn-sm btn-white" type="submit"><i class="fa fa-save"></i> Add Contact</button>
																		<cfelse>
																			<button class="btn btn-sm btn-white" type="submit"><i class="fa fa-save"></i> Save Contact</button>
																			<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#" class="btn btn-sm btn-default"><i class="fa fa-remove"></i> Cancel</a>
																		</cfif>
																		
																		<input type="hidden" name="fieldid" value="#url.id#" />
																		<cfif structkeyexists( url, "contactid" )>
																			<input type="hidden" name="fcid" value="#url.contactid#" />
																		<cfelse>
																			<input type="hidden" name="fcid" value="0" />
																		</cfif>
																	</div>
																</div>
															</form>
														</cfoutput>
													</div>
												</div>