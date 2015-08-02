

	

		<!--- admin.states- administration --->
		<cfinvoke component="apis.com.admin.stateadminservice" method="getstates" returnvariable="statelist">
		</cfinvoke>
		
		<cfif structkeyexists( url, "fuseaction" )>
			<cfif structkeyexists( url, "stateid" )>
				<cfif url.stateid neq 0>
					<cfinvoke component="apis.com.admin.stateadminservice" method="getstatedetail" returnvariable="statedetail">
						<cfinvokeargument name="stateid" value="#url.stateid#">
					</cfinvoke>
				</cfif>
			</cfif>
		</cfif>
		
			<cfoutput>
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">					

						<!--- // check the users role --->
						<cfif isuserinrole( "admin" )>
						
						
							<!--- system wide alerts --->
							<cfif structkeyexists( url, "scope" )>
								<div style="margin-top:12px;">
									<cfif trim( url.scope ) eq "s1">
										<div class="alert alert-info alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-plus"></i> The new state was successfully added to the database...
										</div>
									<cfelseif trim( url.scope ) eq "s2">
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-check-circle-o"></i> The state was successfully updated!
										</div>
									<cfelseif trim( url.scope ) eq "s3">
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-warning"></i> The state was successfully deleted.
										</div>
									</cfif>
								</div>
							</cfif>
						
							<!-- // include the page heading --->
							<cfinclude template="views/state-admin-page-heading.cfm">
							
							<!-- // include the view state -->
							<cfif not structkeyexists( url, "fuseaction" )>				
								<cfinclude template="views/states/state.list.cfm">
							<cfelseif structkeyexists( url, "fuseaction" )>
								<cfif trim( url.fuseaction ) eq "state.edit">
									<cfinclude template="views/states/state.edit.cfm">
								<cfelseif trim( url.fuseaction ) eq "state.delete">
									<cfinclude template="views/states/state.delete.cfm">
								<cfelseif trim( url.fuseaction ) eq "state.add">
									<cfinclude template="views/states/state.add.cfm">
								<cfelse>
									<!-- // no view found, show message -->
									<div class="alert alert-danger" style="margin-top:10px;">
										<h4><i class="fa fa-warning"></i> SYSTEM ALERT</h4>
										<p>The selected view could not be found...  Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate to the homepage.</p>
									</div>						
								</cfif>
							<cfelse>
								<!-- // no view found, show message -->
								<div class="alert alert-danger" style="margin-top:10px;">
									<h4><i class="fa fa-warning"></i> SYSTEM ALERT</h4>
									<p>The selected view could not be found...  Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate to the homepage.</p>
								</div>
							</cfif>
						
						<cfelse>
						
								<!-- // security issue detected, show message -->
								<div class="alert alert-danger" style="margin-top:10px;">
									<h4><i class="fa fa-warning fa-3x"></i> SYSTEM ALERT</h4>
									<p>You are attempting to access a restricted resource within this system without proper authorization.   Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate away from this page.</p>
								</div>
						
						</cfif>
					</div><!-- /.container -->
				</div><!-- /.wrapper-content -->
			</cfoutput>
