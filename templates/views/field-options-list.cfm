



							
							
							<cfinvoke component="apis.com.admin.fieldadminservice" method="getfieldoptions" returnvariable="fieldoptions">
							</cfinvoke>
							
							<h4><i class="fa fa-table"></i> Field Options</h4>
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr class="small">
											<th>ID</th>
											<th>Description</th>
										</tr>
									</thead>
									<tbody>
										<cfoutput query="fieldoptions">
											<tr class="small">
												<td>#fieldoptionid#</td>
												<td>#fieldoptiondescr#</td>															
											</tr>
										</cfoutput>
									</tbody>
								</table>
							</div>
											
							<cfinclude template="field-options-form.cfm">