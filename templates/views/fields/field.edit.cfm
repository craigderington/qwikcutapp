

			



						<!--- // get the google map geocoder api --->
						<cfinclude template="../../../apis/udfs/geocoder.cfm">			
						
						
						
						<cfoutput>
							<div class="row">							
									
								<div class="ibox" style="margin-top:-15px;">								
									<div class="ibox-title">
										<h5>Edit Field Details | #fielddetail.fieldname# Field <a href="#application.root##url.event#" style="margin-left:20px;margin-top:-2px;" class="btn btn-white btn-xs"><i class="fa fa-arrow-circle-left"></i> Return to Fields</a></h5>
									</div>
										
									<div class="ibox-content">									
										<div class="tabs-container">
											<ul class="nav nav-tabs">
												<li class="active"><a data-toggle="tab" href="##tab-1"><i class="fa fa-stop"></i> Edit Field Details</a></li>
												<li class=""><a href="#application.root##url.event#&fuseaction=field.contacts&id=#url.id#"><i class="fa fa-group"></i> Field Contacts</a></li>
												<li class=""><a href="#application.root##url.event#&fuseaction=field.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>
												<li class=""><a href="#application.root##url.event#&fuseaction=field.map&id=#url.id#"><i class="fa fa-map-marker"></i> Field Map</a></li>
											</ul>
											
											<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBy6kNfIxQ6yP_Q0wbyqdH-v93-gfh0miU"></script>
																					
											<div class="tab-content">
												<div id="tab-1" class="tab-pane active">
													<div class="panel-body">
														<div class="col-md-6">
														
															<!--- // begin form processing --->
															<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "saveFieldRecord" )>
															
																<cfset form.validate_require = "fieldid|Sorry, and internal error has occurred.;stateid|The state is required to edit this record.;fieldname|Please enter a name for this field.;fieldaddress1|Please enter the primary address.;fieldcity|Please enter the city for this field.;fieldzip|Please enter the field zip code.;fieldcontactname|Please enter the field contact name.;fieldcontactnumber|Please enter the primary contacts phone number.;fieldcontacttitle|Please enter the field contact title." />
																
																<cfscript>
																	objValidation = createobject( "component","apis.udfs.validation" ).init();
																	objValidation.setFields( form );
																	objValidation.validate();
																</cfscript>

																<cfif objValidation.getErrorCount() is 0>							
																	
																	<!--- define our form structure and set form values --->
																	<cfset f = structnew() />
																	<cfset f.fieldid = form.fieldid />
																	<cfset f.stateid = form.stateid />
																	<cfset f.fieldname = trim( form.fieldname ) />
																	<cfset f.fieldactive = form.fieldactive  />
																	<cfset f.fieldaddress1 = trim( form.fieldaddress1 ) />
																	<cfset f.fieldaddress2 = trim( form.fieldaddress2 ) />
																	<cfset f.fieldcity = trim( form.fieldcity ) />																	
																	<cfset f.fieldzip = form.fieldzip />
																	<cfset f.fieldcontactname = trim( form.fieldcontactname ) />
																	<cfset f.fieldcontacttitle = trim( form.fieldcontacttitle ) />
																	<cfset f.fieldcontactnumber = trim( form.fieldcontactnumber ) />
																	<cfset f.fieldoptionid = form.fieldoptionid />
																	
																		<cfquery name="savefielddetails">
																			update fields
																			   set stateid = <cfqueryparam value="#f.stateid#" cfsqltype="cf_sql_integer" />,
																				   fieldname = <cfqueryparam value="#f.fieldname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				   fieldactive = <cfqueryparam value="#f.fieldactive#" cfsqltype="cf_sql_bit" />,
																				   fieldaddress1 = <cfqueryparam value="#f.fieldaddress1#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				   fieldaddress2 = <cfqueryparam value="#f.fieldaddress2#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				   fieldcity = <cfqueryparam value="#f.fieldcity#" cfsqltype="cf_sql_varchar" maxlength="50" />,																				   
																				   fieldzip = <cfqueryparam value="#f.fieldzip#" cfsqltype="cf_sql_numeric" />,
																				   fieldcontactname = <cfqueryparam value="#f.fieldcontactname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				   fieldcontacttitle =<cfqueryparam value="#f.fieldcontacttitle#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				   fieldcontactnumber = <cfqueryparam value="#f.fieldcontactnumber#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				   fieldoptionid = <cfqueryparam value="#f.fieldoptionid#" cfsqltype="cf_sql_integer" />
																			 where fieldid = <cfqueryparam value="#f.fieldid#" cfsqltype="cf_sql_integer" /> 
																		</cfquery>

																		<!--- // record the activity --->
																		<cfquery name="activitylog">
																			insert into activity(userid, activitydate, activitytype, activitytext)														  													   
																			 values(
																					<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																					<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																					<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
																					<cfqueryparam value="updated the field #f.fieldname# in the system." cfsqltype="cf_sql_varchar" />																
																					);
																		</cfquery>
																		
																		<cflocation url="#application.root##url.event#&scope=f2" addtoken="no">				
																	
														
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
														
															<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#">
																<fieldset class="form-horizontal">
																	<div class="form-group"><label class="col-sm-2 control-label">Field ID:</label>
																		<div class="col-sm-10"><input type="text" class="form-control" placeholder="Field ID" value="#fielddetail.fieldid#" readonly></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Field:</label>
																		<div class="col-sm-10"><input type="text" name="fieldname" class="form-control" placeholder="Field Name" value="#fielddetail.fieldname#"></div>
																	</div>																
																	<!---
																	<div class="form-group"><label class="col-sm-2 control-label">Conference:</label>
																		<div class="col-sm-10">
																			<select class="form-control" >
																				<option>option 1</option>
																				<option>option 2</option>
																			</select>
																		</div>
																	</div>
																	--->
																	<div class="form-group"><label class="col-sm-2 control-label">Address:</label>
																		<div class="col-sm-10"><input type="text" name="fieldaddress1" class="form-control" placeholder="Address" value="#fielddetail.fieldaddress1#"></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Address:</label>
																		<div class="col-sm-10"><input type="text" name="fieldaddress2" class="form-control" placeholder="Address 2" value="#fielddetail.fieldaddress2#"></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">City:</label>
																		<div class="col-sm-10"><input type="text" name="fieldcity" class="form-control" placeholder="City" value="#fielddetail.fieldcity#"></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">State:</label>
																		<div class="col-sm-10">
																			<select class="form-control" name="stateid">
																				<option value="4">Select Field Option</option>
																				<cfloop query="statelist">
																					<option value="#statelist.stateid#"<cfif fielddetail.stateid eq statelist.stateid>selected</cfif>>#statelist.statename#</option>
																				</cfloop>
																			</select>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Zip:</label>
																		<div class="col-sm-10"><input type="text" name="fieldzip" class="form-control" placeholder="Zip Code" value="#fielddetail.fieldzip#"></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Status:</label>
																		<div class="col-sm-10">
																			<select class="form-control" name="fieldactive">
																				<option value="1"<cfif trim( fielddetail.fieldactive ) eq 1>selected</cfif>>Field Active</option>
																				<option value="0"<cfif trim( fielddetail.fieldactive ) eq 0>selected</cfif>>Field Inactive</option>
																			</select>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Contact:</label>
																		<div class="col-sm-10"><input type="text" name="fieldcontactname" class="form-control" placeholder="Primary Contact" value="#fielddetail.fieldcontactname#"></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Title:</label>
																		<div class="col-sm-10"><input type="text" name="fieldcontacttitle" class="form-control" placeholder="Title" value="#fielddetail.fieldcontacttitle#"></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Number:</label>
																		<div class="col-sm-10"><input type="text" name="fieldcontactnumber" class="form-control" placeholder="Contact Phone Number" value="#fielddetail.fieldcontactnumber#"></div>
																	</div>
																	<div class="form-group"><label class="col-sm-2 control-label">Option:</label>
																		<div class="col-sm-10">
																			<select class="form-control" name="fieldoptionid">
																				<option value="">Select Field Option</option>
																				<cfloop query="fieldoptions">
																					<option value="#fieldoptionid#"<cfif fielddetail.fieldoptionid eq fieldoptions.fieldoptionid>selected</cfif>>#fieldoptiondescr#</option>
																				</cfloop>
																			</select>
																		</div>
																	</div>
																	<br />
																	<div class="hr-line-dashed" style="margin-top:15px;"></div>
																	<div class="form-group">
																		<div class="col-lg-offset-2 col-lg-10">
																			<button class="btn btn-primary" type="submit" name="saveFieldRecord"><i class="fa fa-save"></i> Save Field</button>
																			<a href="#application.root##url.event#" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
																			<input type="hidden" name="fieldid" value="#fielddetail.fieldid#" />
																		</div>
																	</div>															
																</fieldset>
															</form>
														</div>
														<div class="col-md-6">
															<div class="ibox ">
																<div class="ibox-title">
																	<h5><i class="fa fa-map-marker"></i> Field Map  <span style="margin-left:10px;"><small>#fielddetail.fieldaddress1# #fielddetail.fieldaddress2# #fielddetail.fieldcity# #fielddetail.fieldstate# #fielddetail.fieldzip#</small></span></h5>
																</div>
																<div class="ibox-content">																
																	<div class="google-map" id="map1"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
													
													
													<!--- // google maps api --->												
													
													<script type="text/javascript">
														// When the window has finished loading google map
														google.maps.event.addDomListener(window, 'load', init);

														function init() {
															// Options for Google map															
															var mapOptions1 = {
																zoom: 15,
																center: new google.maps.LatLng(<cfoutput>#thislat#, #thislong#</cfoutput>),
															};					
															
															// Get all html elements for map
															var mapElement1 = document.getElementById('map1');														

															// Create the Google Map using elements
															var map1 = new google.maps.Map(mapElement1, mapOptions1);
															
														}
													</script>	
												
												
												
												
											</div><!-- / .tab-content -->
										</div><!-- / .tab-container -->		
									</div>
								</div>							
							</div>
						</cfoutput>