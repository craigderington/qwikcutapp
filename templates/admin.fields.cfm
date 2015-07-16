

			

	

		<!--- admin.fields administration --->
		<cfinvoke component="apis.com.admin.fieldadminservice" method="getfields" returnvariable="fieldlist">
		</cfinvoke>
		
		<!--- // data filters --->
		<cfinvoke component="apis.com.admin.stateadminservice" method="getstates" returnvariable="statelist">
		</cfinvoke>	
		
		<!--- // invoke our data components --->
		<cfif structkeyexists( url, "fuseaction" )>
			<cfif structkeyexists( url, "id" )>
				<cfif url.id neq 0>
					<cfinvoke component="apis.com.admin.fieldadminservice" method="getfielddetail" returnvariable="fielddetail">
						<cfinvokeargument name="id" value="#url.id#">
					</cfinvoke>
				</cfif>
			</cfif>
		</cfif>
		
			<cfoutput>
				<div class="wrapper wrapper-content">
					<div class="container">				
						<!-- // include the page heading --->
						<cfinclude template="views/field-admin-page-heading.cfm">
						
						<!-- // include the view state -->
						<cfif not structkeyexists( url, "fuseaction" )>				
							<cfinclude template="views/fields/field.list.cfm">
						<cfelseif structkeyexists( url, "fuseaction" )>
							<cfif trim( url.fuseaction ) eq "field.edit">
								<cfinclude template="views/field/field.edit.cfm">
							<cfelseif trim( url.fuseaction ) eq "field.delete">
								<cfinclude template="views/fields/field.delete.cfm">
							<cfelseif trim( url.fuseaction ) eq "field.add">
								<cfinclude template="views/fields/field.add.cfm">
							<cfelseif trim( url.fuseaction ) eq "field.view">
								<cfinclude template="views/fields/field.view.cfm">
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
