


				<cfinvoke component="apis.com.admin.stateadminservice" method="getstates" returnvariable="statelist"></cfinvoke>

				<cfif not structkeyexists( url, "id" )>
					<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooters" returnvariable="shooterlist">
						<cfinvokeargument name="stateid" value="#session.stateid#">
					</cfinvoke>
					<cfinvoke component="apis.com.admin.fieldadminservice" method="getfields" returnvariable="fieldlist"></cfinvoke>				
				<cfelseif structkeyexists( url, "id" )>	
					<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooter" returnvariable="shooter">			
						<cfinvokeargument name="id" value="#url.id#">
					</cfinvoke>			
						<cfif url.id neq 0>						
							<cfif shooter.recordcount eq 0>
								<cflocation url="#application.root##url.event#&error=1" addtoken="yes">
							</cfif>
						</cfif>
				</cfif>			
				
				
					
				


				<cfoutput>
					<div class="wrapper wrapper-content animated fadeIn">
						<div class="container">
							
							<!--- system wide alerts --->
							<cfif structkeyexists( url, "scope" )>
								<div style="margin-top:12px;">
									<cfif trim( url.scope ) eq "s1">
										<div class="alert alert-info alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-plus"></i> The new shooter was successfully added to the database...
										</div>
									<cfelseif trim( url.scope ) eq "s2">
										<div class="alert alert-success alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-check-circle-o"></i> The shooter was successfully updated!
										</div>
									<cfelseif trim( url.scope ) eq "s3">
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-warning"></i> Operation Success.  The shooter was successfully deleted.  All related data was also removed.
										</div>
									<cfelseif trim( url.scope ) eq "s4">
										<div class="alert alert-warning alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-check-square"></i> Success.  The shooter registration invitation was successfully re-sent.
										</div>
									</cfif>
								</div>
							</cfif>
							
							
							<!--- // check the users role --->
							<cfif isuserinrole( "admin" )>
							
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
									<cfelseif trim( url.fuseaction ) eq "shooter.invite">
										<cfinclude template="views/shooters/shooter.invite.cfm">
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
						
							<cfelse>
						
								<!-- // security issue detected, show message -->
								<div class="alert alert-danger" style="margin-top:10px;">
									<h4><i class="fa fa-warning fa-3x"></i> SYSTEM ALERT</h4>
									<p>You are attempting to access a restricted resource within this system without proper authorization.   Please <a class="alert-link" href="#application.root#user.home">click here</a> to navigate away from this page.</p>
								</div>
						
							</cfif>
						</div>							
					</div>							
				</cfoutput>