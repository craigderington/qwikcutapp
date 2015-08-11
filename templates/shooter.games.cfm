



				<cfif structkeyexists( session, "vsid" )>
					<cfset tempr = structdelete( session, "vsid" ) />
				</cfif>



				<!--- // main wrapper --->
				<div class="wrapper wrapper-content animated fadeIn">
					<div class="container">
						<cfoutput>
							<div class="row" style="margin-top:15px;">						
								<div class="ibox">
									<div class="ibox-title">
										<h5><i class="fa fa-play-circle"></i> #session.username# | Games List</h5>
										<span class="pull-right">
											<a href="#application.root#user.home" class="btn btn-xs btn-success"><i class="fa fa-home"></i> Home</a>
											<a href="#application.root#user.settings" class="btn btn-xs btn-primary" style="margin-left:5px;"><i class="fa fa-user"></i> My Profile</a>
										</span>
									</div>							
									<div class="ibox-content">
										{{ show data grid of games , completed and pending }}
									</div>
								</div>						
							</div>
						</cfoutput>						
					</div>
				</div>