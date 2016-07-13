





					<!--- // get the google map geocoder api --->
					<cfinclude template="../../../apis/udfs/geocoder.cfm">
					
					
					<cfoutput>
						<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=#application.googlemapsbrowserkey#"></script>
											
						<div class="ibox">
							<div class="ibox-title">
								<h5>							
									<i class="fa fa-map-marker"></i> <span style="margin-left:5px;"><small>#fielddetail.fieldaddress1# #fielddetail.fieldaddress2# #fielddetail.fieldcity# #fielddetail.fieldstate# #fielddetail.fieldzip#</small></span>
								</h5>						
								<div class="ibox-tools">							
									<a class="dropdown-toggle" data-toggle="dropdown" href="##">
										<i class="fa fa-wrench"></i>
									</a>							
									<ul class="dropdown-menu dropdown-user">
										<li><a href="http://maps.google.com/maps?saddr=&daddr=#urlencodedformat(fielddetail.fieldaddress1)#+#fielddetail.fieldcity#+#fielddetail.stateabbr#+#fielddetail.fieldzip#" target="_blank">Get Directions</a></li>
										<li><a href="http://maps.google.com/maps?saddr=#urlencodedformat(fielddetail.fieldaddress1)#+#fielddetail.fieldcity#+#fielddetail.stateabbr#+#fielddetail.fieldzip#" target="_blank">View in Google Maps</a></li>
									</ul>							
									
								</div>
							</div>
							<div class="ibox-content">																
								<div class="google-map" id="map1"></div>
								<cfif fielddetail.fieldaddress1 neq "">
									<br />
									<a href="http://maps.google.com/maps?saddr=&daddr=#urlencodedformat(fielddetail.fieldaddress1)#+#fielddetail.fieldcity#+#fielddetail.stateabbr#+#fielddetail.fieldzip#" target="_blank"><i class="fa fa-map-marker"></i> Get Directions</a>
								</cfif>				
							</div>
						</div>					
					</cfoutput>
					
					
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
					
					
					