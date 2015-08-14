
					
					
					
					
					<!--- // get the field detail for the geocoder --->
					<cfinvoke component="apis.com.admin.fieldadminservice" method="getfielddetail" returnvariable="fielddetail">
						<cfinvokeargument name="id" value="#versus.fieldid#">
					</cfinvoke>					
					
					<!--- // get the google map geocoder api --->
					<cfinclude template="../../../apis/udfs/geocoder.cfm">					
					
					<!--- call google map api --->
					<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBy6kNfIxQ6yP_Q0wbyqdH-v93-gfh0miU"></script>
					


					<cfoutput>
						<div class="row">
							<cfif structkeyexists( url, "scope" )>
								<cfif url.scope eq "gf1">
									<div class="alert alert-success alert-dismissable">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-save"></i> Game field changed.										
									</div>									
								</cfif>
							</cfif>
							
							<div class="ibox-title">
								<h5><i class="fa fa-map-marker"></i> Game Field</h5>
								<cfif isuserinrole( "admin" )>
									<span class="pull-right">
										<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=field" class="btn btn-xs btn-primary"><i class="fa fa-edit"></i> Change</a>
									</span>
								</cfif>
							</div>
							
							<div class="ibox-content ibox-heading text-center border-bottom">
								<small>#versus.fieldname# Field  <cfif structkeyexists( session, "shooterid" )>- #fielddetail.fieldaddress1# #fielddetail.fieldcity#, #fielddetail.stateabbr# #fielddetail.fieldzip#</cfif></small>
							</div>
							
							<div class="ibox-content">
								
								<cfif versus.fieldid neq 155>
									<div class="google-map" id="map1"></div>
								
									<br />
									<br />
								<cfelse>
									<div class="alert alert-info text-center">
										<small>No map to display...</small>
									</div>
								</cfif>
								
								<div class="well" style="padding:5px;">
									<h5><i class="fa fa-bullhorn"></i> <strong>Field Contacts</strong></h5>
									<small>
										#fielddetail.fieldcontactname# <br />
										#fielddetail.fieldcontacttitle# <br />
										#fielddetail.fieldcontactnumber# <a style="margin-left:5px;" href="">More &raquo;&raquo;</a>
									</small>
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
				</cfoutput>

							
							
							
							
							