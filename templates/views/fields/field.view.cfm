





			



									
						<cfoutput>
							<div class="row">							
									
								<div class="ibox" style="margin-top:-15px;">								
									<div class="ibox-title">
										<h5>Field Details | #fielddetail.fieldname#</h5>
									</div>
										
									<div class="ibox-content">									
										<div class="tabs-container">
											<ul class="nav nav-tabs">
												<li class="active"><a data-toggle="tab" href="##tab-1"> Field Details</a></li>
												<li class=""><a data-toggle="tab" href="##tab-2"> Edit Field</a></li>
												<li class=""><a data-toggle="tab" href="##tab-3"> Field Contacts</a></li>
												<li class=""><a data-toggle="tab" href="##tab-4"> More &raquo;</a></li>
											</ul>
											
											<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBy6kNfIxQ6yP_Q0wbyqdH-v93-gfh0miU"></script>
																					
											<div class="tab-content">
												<div id="tab-1" class="tab-pane active">
													<div class="panel-body">
														<div class="col-md-6">
															<fieldset class="form-horizontal">
																<div class="form-group"><label class="col-sm-2 control-label">Field ID:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Field ID" value="#fielddetail.fieldid#" readonly></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Field:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Address" value="#fielddetail.fieldname#"></div>
																</div>																
																<div class="form-group"><label class="col-sm-2 control-label">Conference:</label>
																	<div class="col-sm-10">
																		<select class="form-control" >
																			<option>option 1</option>
																			<option>option 2</option>
																		</select>
																	</div>
																</div>
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
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="State" value="#fielddetail.fieldstate#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Zip:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Zip Code" value="#fielddetail.fieldzip#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Status:</label>
																	<div class="col-sm-10">
																		<select class="form-control" >
																			<option>option 1</option>
																			<option>option 2</option>
																		</select>
																	</div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Contact:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Primary Contact" value="#fielddetail.fieldcontactname#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Title:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Title" value="#fielddetail.fieldcontacttitle#"></div>
																</div>
																<div class="form-group"><label class="col-sm-2 control-label">Number:</label>
																	<div class="col-sm-10"><input type="text" class="form-control" placeholder="Contact Phone Number" value="#fielddetail.fieldcontactnumber#"></div>
																</div>																
															</fieldset>
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
																zoom: 13,
																center: new google.maps.LatLng(28.720768, -81.310818),
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