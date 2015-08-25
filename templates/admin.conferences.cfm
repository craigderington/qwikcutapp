

	

		<!--- admin.conferences - administration --->
		<cfinvoke component="apis.com.admin.conferenceadminservice" method="getconferences" returnvariable="conferencelist">
			<cfinvokeargument name="stateid" value="#session.stateid#">
		</cfinvoke>
		<cfinvoke component="apis.com.admin.stateadminservice" method="getstates" returnvariable="statelist"></cfinvoke>	
		<cfif structkeyexists( url, "fuseaction" )>				
			<cfif structkeyexists( url, "id" )>
				<cfif url.id neq 0>
					<cfinvoke component="apis.com.admin.conferenceadminservice" method="getconferencedetail" returnvariable="conferencedetail">
						<cfinvokeargument name="id" value="#url.id#">
					</cfinvoke>
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
									<cfif trim( url.scope ) eq "s1">
										<div class="alert alert-info alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-plus"></i> The new conference was successfully added to the database...
										</div>
									<cfelseif trim( url.scope ) eq "s2">
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-check-circle-o"></i> The conference was successfully updated!
										</div>
									<cfelseif trim( url.scope ) eq "s3">
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-warning"></i> The conference was successfully deleted.  All related data was also removed.
										</div>
									</cfif>
								</div>
							</cfif>
						
						
						
							
							<!-- // include the page heading --->
							<cfinclude template="views/conference-admin-page-heading.cfm">
						
							<!-- // include the conference view state -->
							<cfif not structkeyexists( url, "fuseaction" )>				
								<cfinclude template="views/conferences/conference.list.cfm">
							<cfelseif structkeyexists( url, "fuseaction" )>
								<cfif trim( url.fuseaction ) eq "conference.edit">
									<cfinclude template="views/conferences/conference.edit.cfm">
								<cfelseif trim( url.fuseaction ) eq "conference.delete">
									<cfinclude template="views/conferences/conference.delete.cfm">
								<cfelseif trim( url.fuseaction ) eq "conference.add">
									<cfinclude template="views/conferences/conference.add.cfm">
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
