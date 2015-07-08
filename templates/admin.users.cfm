

	

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
						</cfif>
					<cfelse>
						<!-- // no view found, show message -->
						<div class="alert alert-danger">
							<a class="alert-link" href="#"><i class="fa fa-warning-sign"> System Alert</a>.  The view could not be found...
                        </div>
					</cfif>
					
					
					
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
		
