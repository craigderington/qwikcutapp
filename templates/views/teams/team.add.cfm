





			<cfoutput>			
				<div class="row">
					<div class="ibox">
						<div class="ibox-title">							
							<h5><i class="fa fa-plus"></i> Add New Team</h5>							
								<span class="pull-right">
									<a href="#application.root##url.event#" class="btn btn-xs btn-primary"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
									<a style="margin-right:5px;" href="" class="btn btn-xs btn-default btn-outline"><i class="fa fa-trophy"></i> Teams by Conference</a>
								</span>
						</div>
						<div class="ibox-content">					
							<cfif not structkeyexists( form, "getconference" )>
								<cfinclude template="team-form-conference.cfm">
							<cfelseif structkeyexists( form, "getconference" )>
								<cfinclude template="team-form-new.cfm">
							</cfif>
						</div>
					</div>
				</div>
			</cfoutput>