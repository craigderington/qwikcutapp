

	

		<!--- admin.states- administration --->
		<cfinvoke component="apis.com.admin.useradminservice" method="getusers" returnvariable="userlist">
		</cfinvoke>
		
		<cfif structkeyexists( url, "fuseaction" )>
			<cfif structkeyexists( url, "id" )>
				<cfif url.id neq 0>
					<cfinvoke component="apis.com.admin.useradminservice" method="getuserdetail" returnvariable="userdetail">
						<cfinvokeargument name="userid" value="#url.id#">
					</cfinvoke>
				</cfif>
			</cfif>
		</cfif>
		
			<cfoutput>
				<div class="wrapper wrapper-content">
					<div class="container">				
						<!-- // include the page heading --->
						<cfinclude template="views/user-admin-page-heading.cfm">
						
						<!-- // include the user view -->
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
						
						
						
					</div><!-- /.container -->
				</div><!-- /.wrapper-content -->
			</cfoutput>
