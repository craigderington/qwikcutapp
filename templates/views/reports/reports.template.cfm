








						

							
								<cfif isnumeric( url.reportid )>
									<cfset myreportid = url.reportid />
									<cfinvoke component="apis.com.reports.reportservice" method="getreport" returnvariable="reporttemplate">
										<cfinvokeargument name="reportid" value="#myreportid#">
									</cfinvoke>
									
									<cfinclude template="#reporttemplate.reporttemplatepath#">
									
								<cfelse>
								
									<small>
										<div class="alert alert-danger alert-dismissable">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
											<i class="fa fa-warning"></i>  Error fetching report.  There was a problem with the report ID.  <a class="alert-link" href="index.cfm?event=admin.reports">Report Home</a>.
										</div>
									</small>
								
								</cfif>
							
							
						
							
							