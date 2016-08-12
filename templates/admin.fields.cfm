

			
		
		<!--- // set data filters to session objects --->
		<cfif structkeyexists( form, "filterresults" )>
			<cfif structkeyexists( form, "stateid" ) and form.stateid neq "">
				<cfset session.fieldstateid = numberformat( form.stateid, "99" ) />
			</cfif>			
		</cfif>
		
		<!--- // reset the data filter session --->		
		<cfif structkeyexists( url, "resetfilter" )>
			<cfset tempf = structdelete( session, "fieldstateid" ) />			
			<cflocation url="#application.root##url.event#" addtoken="no">
		</cfif>	
	

		<!--- admin.fields administration --->
		<cfinvoke component="apis.com.admin.fieldadminservice" method="getfields" returnvariable="fieldlist">
			<cfinvokeargument name="stateid" value="#session.stateid#">
		</cfinvoke>
		
		<cfinvoke component="apis.com.admin.fieldadminservice" method="getfieldoptions" returnvariable="fieldoptions">
		</cfinvoke>
		
		<cfinvoke component="apis.com.admin.fieldadminservice" method="getregions" returnvariable="regionlist">
			<cfinvokeargument name="stateid" value="#session.stateid#">
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
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
					
						<!--- // check the users role --->
						<cfif isuserinrole( "admin" )>

							<!--- system wide alerts --->
							<cfif structkeyexists( url, "scope" )>
								<div style="margin-top:12px;">
									<cfif trim( url.scope ) eq "f1">
										<div class="alert alert-info alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-plus"></i> The new field was successfully added to the database...
										</div>
									<cfelseif trim( url.scope ) eq "f2">
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-check-circle-o"></i> The field was successfully updated!
										</div>
									<cfelseif trim( url.scope ) eq "f3">
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-warning"></i> The field was successfully deleted.  All related data was also removed.
										</div>
									</cfif>
								</div>
							</cfif>
						
						
							<!-- // include the page heading --->
							<cfinclude template="views/field-admin-page-heading.cfm">
						
												
						
							<!-- // include the view state -->
							<cfif not structkeyexists( url, "fuseaction" )>				
								<cfinclude template="views/fields/field.list.cfm">
							<cfelseif structkeyexists( url, "fuseaction" )>
								<cfif trim( url.fuseaction ) eq "field.edit">
									<cfinclude template="views/fields/field.edit.cfm">
								<cfelseif trim( url.fuseaction ) eq "field.delete">
									<cfinclude template="views/fields/field.delete.cfm">
								<cfelseif trim( url.fuseaction ) eq "field.add">
									<cfinclude template="views/fields/field.add.cfm">
								<cfelseif trim( url.fuseaction ) eq "field.view">
									<cfinclude template="views/fields/field.view.cfm">
								<cfelseif trim( url.fuseaction ) eq "field.contacts">
									<cfinclude template="views/fields/field.contacts.cfm">
								<cfelseif trim( url.fuseaction ) eq "field.games">
									<cfinclude template="views/fields/field.games.cfm">
								<cfelseif trim( url.fuseaction ) eq "field.map">
									<cfinclude template="views/fields/field.map.cfm">
								<cfelseif trim( url.fuseaction ) eq "field.regions">
									<cfinclude template="views/fields/manage-regions.cfm">
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
						
							<!-- // no view found, show message -->
								<div class="alert alert-danger" style="margin-top:10px;">
									<h4><i class="fa fa-warning fa-3x"></i> SYSTEM ALERT</h4>
									<p>You are attempting to access a restricted resource within this system without proper authorization.   Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate away from this page.</p>
								</div>
						
						</cfif>
						
						
						
					</div><!-- /.container -->
				</div><!-- /.wrapper-content -->
			</cfoutput>
