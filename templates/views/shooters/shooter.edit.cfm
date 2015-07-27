




				<cfoutput>
					<div class="row">
						<div class="ibox">					
							<div class="ibox-title">
								<h5><i class="fa fa-video-camera"></i> Edit Shooter | #shooter.shooterfirstname# #shooter.shooterlastname#</h5>
								<span class="pull-right">
									<a href="#application.root#admin.home" class="btn btn-xs btn-default btn-outline"><i class="fa fa-cog"></i> Admin Home</a>
									<a href="#application.root##url.event#" class="btn btn-xs btn-success btn-outline" style="margin-left:5px;"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
								</span>
							</div>
							<div class="ibox-content">
								<cfinclude template="shooter-form-control.cfm">
							</div>					
						</div>				
					</div>
				</cfoutput>