

	

		<!--- admin.states- administration --->
		<cfinvoke component="apis.com.admin.useradminservice" method="getusers" returnvariable="userlist">
			<cfif structkeyexists( session, "userrole" )>
				<cfinvokeargument name="userrole" value="#session.userrole#">
			<cfelse>
				<cfinvokeargument name="userrole" value="admin">
			</cfif>
		</cfinvoke>
		
		<cfinvoke component="apis.com.admin.stateadminservice" method="getstates" returnvariable="statelist">
		</cfinvoke>	
		
		
		<cfif structkeyexists( url, "fuseaction" )>
			<cfif structkeyexists( url, "id" )>
				<cfif url.id neq 0>
					<cfinvoke component="apis.com.admin.useradminservice" method="getuserdetail" returnvariable="userdetail">
						<cfinvokeargument name="userid" value="#url.id#">
					</cfinvoke>
					<cfif trim( userdetail.userrole ) eq "confadmin">
						<cfinvoke component="apis.com.admin.conferenceadminservice" method="getconferences" returnvariable="conferencelist">
							<cfinvokeargument name="stateid" value="#session.stateid#">
						</cfinvoke>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		
			<cfoutput>
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
					
						<!-- // include the user view -->
						<cfif isuserinrole( "admin" )>				
						
							<!--- system wide alerts --->
							<cfif structkeyexists( url, "scope" )>
								<div style="margin-top:12px;">
									<cfif trim( url.scope ) eq "u1">
										<div class="alert alert-info alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-plus"></i> The new user was successfully added to the database...
										</div>
									<cfelseif trim( url.scope ) eq "u2">
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-check-circle-o"></i> The user was successfully updated!
										</div>
									<cfelseif trim( url.scope ) eq "u3">
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-warning"></i> The user was successfully deleted.  All related data was also removed.
										</div>
									</cfif>
								</div>
							</cfif>
							
							<!-- // include the page heading --->
							<cfinclude template="views/user-admin-page-heading.cfm">					
						
							<cfif not structkeyexists( url, "fuseaction" )>				
								<cfinclude template="views/users/user.list.cfm">
							<cfelseif structkeyexists( url, "fuseaction" )>
								<cfif trim( url.fuseaction ) eq "user.edit">
									<cfinclude template="views/users/user.edit.cfm">
								<cfelseif trim( url.fuseaction ) eq "user.delete">
									<cfinclude template="views/users/user.delete.cfm">
								<cfelseif trim( url.fuseaction ) eq "user.add">
									<cfinclude template="views/users/user.add.cfm">
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
