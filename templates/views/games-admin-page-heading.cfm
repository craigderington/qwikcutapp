		
		
		
		
		
		
			<cfoutput>
				<div class="row wrapper border-bottom white-bg page-heading" style="margin-top:15px;">		
					<div class="col-lg-12">
						<h2><i class="fa fa-play-circle" style="color:##7fb539;"></i> <strong>Games Admin</strong></h2>
							<ol class="breadcrumb">
								<li>
									<a href="#application.root#user.home">Home</a>
								</li>
								<cfif isuserinrole( "admin" )>
								<li>
									<a href="#application.root#admin.home">Administration</a>
								</li>
								</cfif>
								<li class="active">
									<strong>Games</strong>
								</li>
							</ol>
					</div>		
				</div>
			</cfoutput>