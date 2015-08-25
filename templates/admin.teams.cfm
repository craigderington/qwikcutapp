

			
			<!--- // set data filters to session objects --->
			<cfif structkeyexists( form, "filterresults" )>
				<cfif structkeyexists( form, "conferenceid" ) and form.conferenceid neq "">
					<cfset session.conferenceid = numberformat( form.conferenceid, "99" ) />
				</cfif>
				<cfif structkeyexists( form, "teamlevelid" ) and form.teamlevelid neq "">
					<cfset session.teamlevelid = numberformat( form.teamlevelid, "99" ) />
				</cfif>
			</cfif>
			
			<cfif structkeyexists( url, "resetfilter" )>
				<cfset tempa = structdelete( session, "conferenceid" ) />
				<cfset tempb = structdelete( session, "teamlevelid" ) />
				<cflocation url="#application.root##url.event#" addtoken="no">
			</cfif>
		
		
			<!--- // get our data components --->			
			<cfinvoke component="apis.com.admin.conferenceadminservice" method="getconferences" returnvariable="conferencelist">
				<cfinvokeargument name="stateid" value="#session.stateid#">
			</cfinvoke>
			
			<cfif conferencelist.recordcount gt 0>
				<cfinvoke component="apis.com.admin.teamadminservice" method="getteams" returnvariable="teamlist">
					<cfinvokeargument name="conferenceid" value="#conferencelist.confid#">
					<cfinvokeargument name="stateid" value="#session.stateid#">
				</cfinvoke>
			<cfelse>
				<cflocation url="#application.root#admin.conferences" addtoken="yes">
			</cfif>
			
			
			<cfinvoke component="apis.com.admin.teamadminservice" method="getteamlevels" returnvariable="teamlevels">
			</cfinvoke>		
			
			
			<cfoutput>
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">

						<!--- // check the users role --->
						<cfif isuserinrole( "admin" )>
						
							<!--- system wide alerts --->
							<cfif structkeyexists( url, "scope" )>
								<div style="margin-top:12px;">
									<cfif trim( url.scope ) eq "t1">
										<div class="alert alert-info alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-plus"></i> The new team was successfully added to the database...
										</div>
									<cfelseif trim( url.scope ) eq "t2">
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-check-circle-o"></i> The team was successfully updated!
										</div>
									<cfelseif trim( url.scope ) eq "t3">
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-warning"></i> The team was successfully deleted.  All related data was also removed.
										</div>
									</cfif>
								</div>
							</cfif>
							
						
							<!--- // include the page heading --->
							<cfinclude template="views/teams-admin-page-heading.cfm">
							
							<!--- // include the view state --->
							<cfif not structkeyexists( url, "fuseaction" )>				
								<cfinclude template="views/teams/team.list.cfm">
							<cfelseif structkeyexists( url, "fuseaction" )>
								<cfif trim( url.fuseaction ) eq "team.edit">
									<cfinclude template="views/teams/team.edit.cfm">
								<cfelseif trim( url.fuseaction ) eq "team.delete">
									<cfinclude template="views/teams/team.delete.cfm">
								<cfelseif trim( url.fuseaction ) eq "team.add">
									<cfinclude template="views/teams/team.add.cfm">
								<cfelseif trim( url.fuseaction ) eq "team.view">
									<cfinclude template="views/teams/team.view.cfm">
								<cfelseif trim( url.fuseaction ) eq "teams.view">
									<cfinclude template="views/teams/teams.view.cfm">
								<cfelseif trim( url.fuseaction ) eq "team.levels">
									<cfinclude template="views/teams/team.levels.cfm">								
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
