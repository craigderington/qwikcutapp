


			<cfinvoke component="apis.com.admin.teamadminservice" method="getteamdetail" returnvariable="teamdetail">
				<cfinvokeargument name="id" value="#url.id#">
			</cfinvoke>


			<cfoutput>			
				<div class="row">
					<div class="ibox">
						<div class="ibox-title">							
							<h5><i class="fa fa-edit"></i> Edit Team Details | #teamdetail.teamname# </h5>							
								<span class="pull-right">
									<a href="#application.root##url.event#" class="btn btn-xs btn-primary"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
									<a style="margin-right:5px;" href="" class="btn btn-xs btn-default btn-outline"><i class="fa fa-trophy"></i> Teams by Conference</a>
								</span>
						</div>
						<div class="ibox-content">					
							<cfinclude template="team-form-edit.cfm">							
						</div>
					</div>
				</div>
			</cfoutput>