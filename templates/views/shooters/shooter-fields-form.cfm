



												

				
				
				
												<div class="ibox">
													<div class="ibox-title">
														<h5>
															<cfif not structkeyexists( url, "sfid" )>
																<i class="fa fa-plus"></i> Assign Fields
															</cfif>
															
															<cfif structkeyexists( url, "id" ) and structkeyexists( url, "sfid" )>
																<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooterfielddetails" returnvariable="shooterfielddetails">
																	<cfinvokeargument name="sfid" value="#url.sfid#">
																</cfinvoke>
																<i class="fa fa-remove-circle-o"></i> Delete Field Assignment
															</cfif>
														</h5>
													</div>
													<div class="ibox-content">								
														
														<!--- // begin form processing --->
														<cfif isDefined( "form.fieldnames" )>
														
															<cfset form.validate_require = "sfid|Ops, form error...;fieldid|Sorry, there was a problem with the form submission.;shooterid|There was a problem with the form." />																
														
															<cfscript>
																objValidation = createobject( "component","apis.udfs.validation" ).init();
																objValidation.setFields( form );
																objValidation.validate();
															</cfscript>

															<cfif objValidation.getErrorCount() is 0>							
																
																<cfset sf = structnew() />
																<cfset sf.sfid = form.sfid />
																<cfset sf.fieldid = form.fieldid />
																<cfset sf.shooterid = form.shooterid />
																
																
																<cfif sf.sfid eq 0>
																
																	<cfquery name="addfieldassign">
																		insert into shooterfields(fieldid, shooterid)
																		 values(
																				<cfqueryparam value="#sf.fieldid#" cfsqltype="cf_sql_integer" />,																				
																				<cfqueryparam value="#sf.shooterid#" cfsqltype="cf_sql_integer" />																				
																				);
																	</cfquery>										
																	
																	<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&scope=1" addtoken="no">			
																
																<cfelse>
																
																	<cfquery name="deletefield">
																		delete 
																		  from shooterfields																		   
																		 where shooterfieldid = <cfqueryparam value="#sf.sfid#" cfsqltype="cf_sql_integer" />																			
																	</cfquery>										
																	
																	<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&scope=2" addtoken="no">			
																
																
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
																<cfif not structkeyexists( url, "sfid" )>
																<cfinvoke component="apis.com.admin.shooteradminservice" method="getfields" returnvariable="fieldlist"></cfinvoke>
																	<p class="small">Please assign work fields...</p>
																	<div class="form-group">
																		<label class="col-lg-2 control-label">Field</label>
																			<div class="col-lg-10">
																				<select name="fieldid" id="fieldid" class="form-control">
																					<option value="">Select Field</option>
																					<cfloop query="fieldlist">
																						<option value="#fieldid#">#fieldname# Field - #fieldcity# - #stateabbr#</option>
																					</cfloop>
																				</select>
																			</div>
																	</div>
																<cfelse>
																	<p class="small">Please confirm deletion...</p>
																	<div class="form-group">
																		<label class="col-lg-2 control-label">Name</label>
																			<div class="col-lg-10">
																				<p class="form-control-static">#shooterfielddetails.fieldname#</p>							
																			</div>
																	</div>
																</cfif>
																
																
																		                                
																<div class="form-group">
																	<div class="col-lg-offset-2 col-lg-10">
																		<input type="hidden" name="shooterid" value="#url.id#" />
																		<cfif not structkeyexists( url, "sfid" )>
																			<button class="btn btn-md btn-primary" type="submit"><i class="fa fa-save"></i> Assign Field</button>
																			<input type="hidden" name="sfid" value="0" />
																		<cfelse>
																			<input type="hidden" name="sfid" value="#url.sfid#" />
																			<input type="hidden" name="fieldid" value="#shooterfielddetails.fieldid#" />
																			<button class="btn btn-md btn-danger" type="submit"><i class="fa fa-save"></i> Delete Assignment</button>
																			<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#" class="btn btn-md btn-default"><i class="fa fa-remove"></i> Cancel</a>
																		</cfif>										
																	</div>
																</div>
															</form>
														</cfoutput>
													</div>
												</div>

