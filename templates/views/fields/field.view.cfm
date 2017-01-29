




					<!--- // get the google map geocoder api --->
					<cfinclude template="../../../apis/udfs/geocoder.cfm">


									
						<cfoutput>
							<div class="row">							
									
								<div class="ibox" style="margin-top:-15px;">								
									<div class="ibox-title">
										<h5>Field Details | #fielddetail.fieldname# Field <a href="#application.root##url.event#" style="margin-left:20px;margin-top:-2px;" class="btn btn-white btn-xs"><i class="fa fa-arrow-circle-left"></i> Return to Fields</a><cfif isuserinrole( "admin" )><a href="#application.root##url.event#&fuseaction=field.edit&id=#url.id#" style="margin-left:10px;margin-top:-2px;" class="btn btn-default btn-xs"><i class="fa fa-edit"></i> Edit Field</a></cfif></h5>
									</div>
										
									<div class="ibox-content">									
										<div class="tabs-container">
											<ul class="nav nav-tabs">
												<li class="active"><a data-toggle="tab" href="##tab-1"><i class="fa fa-stop"></i> Field Details</a></li>
												<li class=""><a href="#application.root##url.event#&fuseaction=field.contacts&id=#url.id#"><i class="fa fa-group"></i> Field Contacts</a></li>
												<li class=""><a href="#application.root##url.event#&fuseaction=field.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>
												<li class=""><a href="#application.root##url.event#&fuseaction=field.map&id=#url.id#"><i class="fa fa-map-marker"></i> Field Map</a></li>
												<!--- // remove until needed 
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog"></i> Fields Options <span class="caret"></span></a>
													<ul role="menu" class="dropdown-menu">
														<li><a href="">Options Item 1</a></li>
														<li><a href="">Options Item 2</a></li>
														<li><a href="">Options Item 3</a></li>
														<li><a href="">Options Item 4</a></li>
													</ul>
												</li>
												--->												
											</ul>
											
											<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=#application.googlemapsbrowserkey#"></script>
																					
											<div class="tab-content">
												<div id="tab-1" class="tab-pane active">
													<div class="panel-body">
														<div class="col-md-6">
															<fieldset class="form-horizontal">
																<div class="form-group"><label class="col-sm-2 control-label">Field ID:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Field ID" value="#fielddetail.fieldid#" readonly></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Region:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Region ID" value="#fielddetail.region_name#" readonly></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Field:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Field Name" value="#fielddetail.fieldname#"></div>
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
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Address" value="#fielddetail.fieldaddress1#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Address:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Address 2" value="#fielddetail.fieldaddress2#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">City:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="City" value="#fielddetail.fieldcity#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">State:</label>
																	<div class="col-sm-10">
																		<select class="form-control" name="stateid">
																			<option value=""></option>
																			<cfloop query="statelist">
																				<option value="#statelist.stateid#"<cfif fielddetail.stateid eq statelist.stateid>selected</cfif>>#statelist.statename#</option>
																			</cfloop>
																		</select>
																	</div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Zip:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Zip Code" value="#fielddetail.fieldzip#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Status:</label>
																	<div class="col-sm-10">
																		<select class="form-control" >
																			<option value="1"<cfif trim( fielddetail.fieldactive ) eq 1>selected</cfif>>Field Active</option>
																			<option value="0"<cfif trim( fielddetail.fieldactive ) eq 0>selected</cfif>>Field Inactive</option>
																		</select>
																	</div>
																</div>
																<!---
																<div class="form-group"><label class="col-sm-2 control-label">Contact:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Primary Contact" value="#fielddetail.fieldcontactname#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Title:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Title" value="#fielddetail.fieldcontacttitle#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Number:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Contact Phone Number" value="#fielddetail.fieldcontactnumber#"></div>
																</div>--->
																<div class="form-group"><label class="col-sm-2 control-label">Option:</label>
																		<div class="col-sm-10">
																			<select class="form-control" name="fieldoptionid" disabled>
																				<option value="4">No Field Options Selected - Edit Field to Add</option>
																				<cfloop query="fieldoptions">
																					<option value="#fieldoptionid#"<cfif fielddetail.fieldoptionid eq fieldoptions.fieldoptionid>selected</cfif>>#fieldoptiondescr#</option>
																				</cfloop>
																			</select>
																		</div>
																	</div>
															</fieldset>
														</div>
														<div class="col-md-6">
															<div class="ibox ">
																<div class="ibox-title">
																	<h5><i class="fa fa-map-marker"></i> <span style="margin-left:10px;"><small>#fielddetail.fieldaddress1# #fielddetail.fieldaddress2# #fielddetail.fieldcity# #fielddetail.stateabbr# #fielddetail.fieldzip#</small></span></h5>
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