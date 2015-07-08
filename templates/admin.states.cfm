

	

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
		
		
			<div class="wrapper wrapper-content">
				<div class="container">				
					<!-- // include the page heading --->
					<cfinclude template="views/state-admin-page-heading.cfm">
					
					<!-- // include the state view -->
					<cfif not structkeyexists( url, "fuseaction" )>				
						<cfinclude template="views/states/state.list.cfm">
					<cfelseif structkeyexists( url, "fuseaction" )>
						<cfif trim( url.fuseaction ) eq "state.edit">
							<cfinclude template="views/states/state.edit.cfm">
						<cfelseif trim( url.fuseaction ) eq "state.delete">
							<cfinclude template="views/states/state.delete.cfm">
						<cfelseif trim( url.fuseaction ) eq "state.add">
							<cfinclude template="views/states/state.add.cfm">
						</cfif>
					<cfelse>
						<!-- // no view found, show message -->
						<div class="alert alert-danger">
							<a class="alert-link" href="#"><i class="fa fa-warning-sign"> System Alert</a>.  The view could not be found...
                        </div>
					</cfif>
					
					
					
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
		
