





					<cfinvoke component="apis.com.admin.fieldadminservice" method="getfieldcontacts" returnvariable="fieldcontacts">
						<cfinvokeargument name="id" value="#url.id#">
					</cfinvoke>
					
					
					
					<!--- // delete field contact --->
					<cfif structkeyexists( url, "deletecontact" ) and trim( url.deletecontact ) eq "true">
						<cfif structkeyexists( url, "contactid" ) and url.contactid neq "">
							<cfinvoke component="apis.com.admin.fieldadminservice" method="getfieldcontact" returnvariable="fieldcontactdetails">
								<cfinvokeargument name="id" value="#url.contactid#">
							</cfinvoke>
							<cfquery name="killcontact">
								delete 
								  from fieldcontacts
								 where fieldcontactid = <cfqueryparam value="#url.contactid#" cfsqltype="cf_sql_integer" />								  
							</cfquery>
							<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&fc.scope=3" addtoken="no">					
						</cfif>					
					</cfif>
					<!--- // end delete field contact --->
					
					
					
					
					
					
					<!--- // system messages --->
					<cfif structkeyexists( url, "fc.scope" )>
						<cfif url.fc.scope eq 1>
							<div class="alert alert-success alert-dismissable">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
								<p><i class="fa fa-check-circle-o"></i> Field Contact Added</p>								
							</div>
						<cfelseif url.fc.scope eq 2>						
							<div class="alert alert-info alert-dismissable">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
								<p><i class="fa fa-check"></i> Field Contact Saved</p>								
							</div>
						<cfelseif url.fc.scope eq 3>
							<div class="alert alert-danger alert-dismissable">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
								<p><i class="fa fa-warning"></i> Field Contact Deleted</p>								
							</div>
						</cfif>					
					</cfif>
					
					
					
					
					
					
					
					
					<div class="ibox">
						<div class="ibox-title">
							<h5><i class="fa fa-database"></i> <cfoutput>The database found #fieldcontacts.recordcount# field contact<cfif ( fieldcontacts.recordcount gt 1 ) or ( fieldcontacts.recordcount eq 0 )>s</cfif>.</cfoutput></h5>
						</div>
						<div class="ibox-content">
							<cfif fieldcontacts.recordcount gt 0>
							<div class="table-responsive">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>Actions</th>
											<th>Contact Name</th>
											<th>Number</th>
											<th>Email</th>
										</tr>
									</thead>
									<tbody>
										<cfoutput query="fieldcontacts">
											<tr>
												<td><a href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&contactid=#fieldcontactid#" title="Edit Field Contact"><i class="fa fa-edit"></i></a> <a style="margin-left:5px;" href="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#&contactid=#fieldcontactid#&deletecontact=true" title="Delete Field Contact" onclick="javascript:confirm('Are you sure you want to delete this field contact?')"><i class="fa fa-trash"></i></a> </td>
												<td>#fieldcontactname# <br /><small>#fieldcontacttitle#</small></td>
												<td>#fieldcontactnumber#</td>
												<td>#fieldcontactemail# <a style="margin-left:4px;" href=""><small><i class="fa fa-envelope"></i></small></a></td>
											</tr>
										</cfoutput>
									</tbody>
								</table>
							</div>
							<cfelse>
								<div class="alert alert-danger alert-dismissable">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<h5><i class="fa fa-warning"></i> NO RECORDS FOUND</h5>
										<p>Sorry, no field contacts were found.Please use the form to add field contacts</p>
								</div>
							</cfif>
						</div>
					</div>
					