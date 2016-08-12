



												

				
				
				
												<div class="ibox">
													<div class="ibox-title">
														<h5>
															<cfif not structkeyexists( url, "sfid" )>
																<i class="fa fa-plus"></i> Assign Regions
															</cfif>
															
															<cfif structkeyexists( url, "id" ) and structkeyexists( url, "srid" )>
																<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooterregiondetails" returnvariable="shooterregiondetails">
																	<cfinvokeargument name="srid" value="#url.srid#">
																</cfinvoke>
																<i class="fa fa-remove-circle-o"></i> Delete Region Assignment
															</cfif>
														</h5>
													</div>
													<div class="ibox-content">								
														
														<!--- // begin form processing --->
														<cfif isDefined( "form.fieldnames" )>
														
															<cfset form.validate_require = "srid|Ops, form error...;regionid|Sorry, there was a problem with the form submission.  Please select a region to add for the selected shooter.;shooterid|There was a problem with the form." />																
														
															<cfscript>
																objValidation = createobject( "component","apis.udfs.validation" ).init();
																objValidation.setFields( form );
																objValidation.validate();
															</cfscript>

															<cfif objValidation.getErrorCount() is 0>							
																
																<cfset sr = structnew() />
																<cfset sr.srid = form.srid />																
																<cfset sr.shooterid = form.shooterid />
																
																
																<cfif sr.srid eq 0>
																
																	<cfquery name="addregionassign">
																		insert into shooterregions(regionid, shooterid)
																		 values(
																				<cfqueryparam value="#sr.regionid#" cfsqltype="cf_sql_integer" />,																				
																				<cfqueryparam value="#sr.shooterid#" cfsqltype="cf_sql_integer" />																				
																				);
																	</cfquery>										
																	
																	<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&scope=1" addtoken="no">			
																
																<cfelse>
																
																	<cfquery name="deleteregion">
																		delete 
																		  from shooterregions																		   
																		 where shooterregionid = <cfqueryparam value="#sr.srid#" cfsqltype="cf_sql_integer" />																			
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
																<cfif structkeyexists( url, "srid" )>															
																	<p class="small">Please confirm deletion...</p>
																	<div class="form-group">
																		<label class="col-lg-2 control-label">Name</label>
																			<div class="col-lg-10">
																				<p class="form-control-static">#shooterregiondetails.region_name#</p>							
																			</div>
																	</div>
																	
																<cfelse>
																	
																	<cfinvoke component="apis.com.admin.fieldadminservice" method="getregions" returnvariable="regionlist">
																		<cfinvokeargument name="stateid" value="#session.stateid#">
																	</cfinvoke>
																		<p class="small">Please assign work regions</p>
																		<div class="form-group">
																			<label class="col-lg-2 control-label">Region</label>
																				<div class="col-lg-10">
																					<select name="regionid" id="regionid" class="form-control">
																						<option value="">Select Region</option>
																						<cfloop query="regionlist">
																							<option value="#regionid#">#region_name#</option>
																						</cfloop>
																					</select>
																				</div>
																		</div>
																</cfif>
																
																
																		                                
																<div class="form-group">
																	<div class="col-lg-offset-2 col-lg-10">
																		<input type="hidden" name="shooterid" value="#url.id#" />
																		<cfif structkeyexists( url, "srid" )>
																			<input type="hidden" name="srid" value="#url.srid#" />
																			<input type="hidden" name="regionid" value="#shooterregiondetails.regionid#" />
																			<button class="btn btn-md btn-danger" type="submit"><i class="fa fa-save"></i> Delete Assignment</button>
																			<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#" class="btn btn-md btn-default"><i class="fa fa-remove"></i> Cancel</a>
																		<cfelse>
																			<button class="btn btn-md btn-primary" type="submit"><i class="fa fa-save"></i> Assign Region</button>
																			<input type="hidden" name="srid" value="0" />																		
																		</cfif>										
																	</div>
																</div>
															</form>
														</cfoutput>
													</div>
												</div>

