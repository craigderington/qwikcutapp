


				<cfinvoke component="apis.com.admin.stateadminservice" method="getstates" returnvariable="statelist"></cfinvoke>

				<cfif not structkeyexists( url, "id" )>
					<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooters" returnvariable="shooterlist"></cfinvoke>
					<cfinvoke component="apis.com.admin.fieldadminservice" method="getfields" returnvariable="fieldlist"></cfinvoke>				
				<cfelseif structkeyexists( url, "id" )>					
					<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooter" returnvariable="shooter">			
						<cfinvokeargument name="id" value="#url.id#">
					</cfinvoke>
					<cfif shooter.recordcount eq 0>
						<cflocation url="#application.root##url.event#&error=1" addtoken="yes">
					</cfif>
				</cfif>			
				
				
					
				


				<cfoutput>
					<div class="wrapper wrapper-content animated fadeIn">
						<div class="container">
							<!--- // include the page heading --->
							<cfinclude template="views/shooters-admin-page-heading.cfm">
							
							<!--- // include the user view --->
							<cfif not structkeyexists( url, "fuseaction" )>				
								<cfinclude template="views/shooters/shooter.list.cfm">
							<cfelseif structkeyexists( url, "fuseaction" )>
								<cfif trim( url.fuseaction ) eq "shooter.edit">
									<cfinclude template="views/shooters/shooter.edit.cfm">
								<cfelseif trim( url.fuseaction ) eq "shooter.delete">
									<cfinclude template="views/shooters/shooter.delete.cfm">
								<cfelseif trim( url.fuseaction ) eq "shooter.add">
									<cfinclude template="views/shooters/shooter.add.cfm">
								<cfelseif trim( url.fuseaction ) eq "shooter.view">
									<cfinclude template="views/shooters/shooter.view.cfm">
								<cfelseif trim( url.fuseaction ) eq "shooter.fields">
									<cfinclude template="views/shooters/shooter.fields.cfm">
								<cfelseif trim( url.fuseaction ) eq "shooter.games">
									<cfinclude template="views/shooters/shooter.games.cfm">
								<cfelseif trim( url.fuseaction ) eq "shooter.dates">
									<cfinclude template="views/shooters/shooter.dates.cfm">
								<cfelseif trim( url.fuseaction ) eq "shooter.comments">
									<cfinclude template="views/shooters/shooter.comments.cfm">
								<cfelse>
									<!-- // no view found, show message --->
									<div class="alert alert-danger" style="margin-top:10px;">
										<h4><i class="fa fa-warning"></i> SYSTEM ALERT</h4>
										<p>The selected view could not be found...  Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate to the homepage.</p>
									</div>
								</cfif>								
							<cfelse>
								<!--- // no view found, show message --->
								<div class="alert alert-danger" style="margin-top:10px;">
									<h4><i class="fa fa-warning"></i> SYSTEM ALERT</h4>
									<p>The selected view could not be found...  Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate to the homepage.</p>
								</div>
							</cfif>							
						</div>							
					</div>							
				</cfoutput>