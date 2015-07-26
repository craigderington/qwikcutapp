

			
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
			<cfinvoke component="apis.com.admin.teamadminservice" method="getteams" returnvariable="teamlist">
			</cfinvoke>
			
			
			<cfinvoke component="apis.com.admin.conferenceadminservice" method="getconferences" returnvariable="conferencelist">
			</cfinvoke>
			
			<cfinvoke component="apis.com.admin.teamadminservice" method="getteamlevels" returnvariable="teamlevels">
			</cfinvoke>		
			
			
			<cfoutput>
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">				
						<!-- // include the page heading --->
						<cfinclude template="views/teams-admin-page-heading.cfm">
						
						<!-- // include the view state -->
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
						
						
						
					</div><!-- /.container -->
				</div><!-- /.wrapper-content -->
			</cfoutput>
