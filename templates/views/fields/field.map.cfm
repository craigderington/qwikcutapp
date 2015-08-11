





				<cfoutput>
				<div class="row">
					<div class="ibox">
						<div class="ibox-title">
							<h5><i class="fa fa-map-marker"></i> Game Field Map | #fielddetail.fieldname# Field <a href="#application.root##url.event#" style="margin-left:20px;margin-top:-2px;" class="btn btn-white btn-xs"><i class="fa fa-arrow-circle-left"></i> Return to Fields</a><cfif isuserinrole( "admin" )><a href="#application.root##url.event#&fuseaction=field.edit&id=#url.id#" style="margin-left:10px;margin-top:-2px;" class="btn btn-default btn-xs"><i class="fa fa-edit"></i> Edit Field</a></cfif></h5>
						</div>
						
						<div class="ibox-content">			
							<div class="tabs-container">
								<ul class="nav nav-tabs">
									<li class=""><a href="#application.root##url.event#&fuseaction=field.view&id=#url.id#"><i class="fa fa-stop"></i> Field Details</a></li>
									<li class=""><a href="#application.root##url.event#&fuseaction=field.contacts&id=#url.id#"><i class="fa fa-group"></i> Field Contacts</a></li>
									<li class=""><a href="#application.root##url.event#&fuseaction=field.games&id=#url.id#"><i class="fa fa-play"></i> Scheduled Games</a></li>
									<li class="active"><a href="#application.root##url.event#&fuseaction=field.map&id=#url.id#"><i class="fa fa-map-marker"></i> Field Map</a></li>
								</ul>							
								<div class="tab-content">
									<div id="tab-1" class="tab-pane active">
										<div class="panel-body">
											<div class="col-md-12">
												<cfinclude template="field-map-view.cfm">
											</div>
										</div>
									</div>
								</div>						
							</div>
						</div>				
					</div>			
				</div>
			</cfoutput>