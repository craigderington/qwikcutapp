
			
		
	
			
			
			
			<!--- // main wrapper --->
			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">
					
					<cfoutput>
					
					
						<!--- // show message if user attempts to circumvent security settings --->
						<cfif structkeyexists( url, "accessdenied" )>
							<div class="row">
								<div class="alert alert-danger alert-dismissable">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
									<h3><i class="fa fa-lock fa-2x"></i>  You have attempted to access a restricted resource.  Access Denied.</h3>								
								</div>
							</div>
						</cfif>
						<!--- // end system messages --->				
					
							<!--- // show view based on user's role --->
							
							<!--- // admin user dashboard --->
							<cfif isuserinrole( "admin" )>								
								<cfinclude template="views/users/user-admin-dashboard.cfm">					
							<!--- // data & analytics user dashboard --->
							<cfelseif isuserinrole( "data" )>							
								<cfinclude template="views/users/user-data-dashboard.cfm">							
							<!--- // shooter dashboard - game day app --->
							<cfelseif isuserinrole( "shooter" )>								
								<cfinclude template="views/users/user-shooter-dashboard.cfm">							
							<!--- // role undefined --->
							<cfelse>				
								<div class="alert alert-info">
									<h2><i class="fa fa-warning fa-3x">USER ROLE NOT FOUND</h2>
									<p>This system can not determine your logged in user's role.  Please contact the system administrator for more information.</p>
								</div>					
							</cfif>			
					
							<!--- // show user's recent activity - all users --->
							<cfinclude template="views/users/user-activity.cfm">						
						
					</cfoutput>		
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
		
