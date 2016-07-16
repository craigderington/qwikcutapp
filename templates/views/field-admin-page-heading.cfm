<cfoutput>

	<div class="row wrapper border-bottom white-bg page-heading" style="margin-top:15px;">		
		<div class="col-lg-12">
			
			<cfif structkeyexists(url, "fuseaction" ) and trim( url.fuseaction ) eq "field.regions">
			
				<h2><i class="fa fa-bookmark" style="color:##7fb539;"></i> <strong>Regions Admin</strong></h2>
					<ol class="breadcrumb">
						<li>
							<a href="#application.root#user.home">Home</a>
						</li>
						<li>
							<a href="#application.root#admin.home">Administration</a>
						</li>
						<li class="active">
							<a href="#application.root##url.event#">Fields</a>
						</li>
						<li class="active">
							<strong>Regions</strong>
						</li>
					</ol>
			
			<cfelse>
			
				<h2><i class="fa fa-bookmark" style="color:##7fb539;"></i> <strong>Game Fields Admin</strong></h2>
				<ol class="breadcrumb">
					<li>
						<a href="#application.root#user.home">Home</a>
					</li>
					<li>
						<a href="#application.root#admin.home">Administration</a>
					</li>
					<li class="active">
						<strong>Fields</strong>
					</li>
				</ol>
			
			</cfif>
		
		
		</div>		
	</div>

</cfoutput>