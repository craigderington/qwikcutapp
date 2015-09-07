

				
				
				
				
				
				<cfinvoke component="apis.com.admin.gameadminservice" method="getgameshooters" returnvariable="gameshooters">
					<cfinvokeargument name="vsid" value="#session.vsid#">
				</cfinvoke>


				<cfif isuserinrole( "admin" )>
					<cfif structkeyexists( url, "id" )>
						<cfif isnumeric( url.id )>
							<cfset assignid = url.id />
							<cfquery name="killassignment">
								delete 
								  from shooterassignments
								 where shooterassignmentid = <cfqueryparam value="#assignid#" cfsqltype="cf_sql_integer" />
							</cfquery>
							<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#" addtoken="no">
						</cfif>				
					</cfif>
				</cfif>


				<cfoutput>
					<div class="row">
						<div class="ibox-title">
							<h5><i class="fa fa-video-camera"></i> Game Shooters</h5>
							<cfif isuserinrole( "admin" ) or isuserinrole( "confadmin" )>
								<cfif structkeyexists( url, "manage" )>
									<span class="pull-right">
										<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-xs btn-success"><i class="fa fa-video-camera"></i> Finished Assignments</a>
									</span>
								<cfelse>
									<span class="pull-right">
										<a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=shooter" class="btn btn-xs btn-primary"><i class="fa fa-plus"></i> Manage</a>
									</span>
								</cfif>
							</cfif>
						</div>
						
						<div class="ibox-content ibox-heading text-center border-bottom">
							<cfif gameshooters.recordcount eq 0>
								<small class="text-danger">No Shooters Assigned</small>
							<cfelse>
								<small class="text-primary">#gameshooters.recordcount# Shooter<cfif ( gameshooters.recordcount gt 1 ) or ( gameshooters.recordcount eq 0 )>s</cfif> Assigned</small>
							</cfif>
						</div>
						
						<div class="ibox-content">
							<div>
                                <div class="feed-activity-list">
                                    <cfloop query="gameshooters">
										<cfinvoke component="apis.udfs.relativeTimeDiff" method="relativeDate" returnvariable="relativeDiff">
											<cfinvokeargument name="originaldate" value="#shooterassigndate#">
										</cfinvoke>
										<div class="feed-element">
											<a href="" class="pull-left">
												<cfif trim( userprofileimagepath ) neq "">
													<img alt="image" class="img-circle" src="#userprofileimagepath#">
												<cfelse>
													<i class="fa fa-video-camera fa-2x text-primary"></i>
												</cfif>
											</a>
											<div class="media-body ">
												<small class="pull-right">#relativeDiff#</small>
												<strong>#shooterfirstname# #shooterlastname#</strong> <cfif trim( shooterassignstatus ) eq "accepted"><span class="label label-primary"><cfelse><span class="label label-danger"></cfif><small>#ucase( shooterassignstatus )#</small></span><br>
												<small class="text-muted">Updated: #dateformat( shooterassignlastupdated, "mm-dd-yyyy" )# : #timeformat( shooterassignlastupdated, "hh:mm tt" )#</small><cfif structkeyexists( url, "manage" )><span class="pull-right"><a href="#application.root##url.event#&fuseaction=#url.fuseaction#&manage=#url.manage#&id=#shooterassignmentid#" onclick="javascript:return confirm('Are you sure you want to delete this shooter assignment?');"><i class="fa fa-trash"></i></a></cfif></span>
											</div>
										</div>
									</cfloop>
								</div>
							</div>
						</div>				
					</div>
				</cfoutput>