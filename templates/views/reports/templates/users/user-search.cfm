<cfoutput>
<h3><i class="fa fa-briefcase"></i> #reporttemplate.reportname# <span class="pull-right"><a href="#application.root##url.event#&reports=#url.reports#" class="btn btn-xs btn-default btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to #trim( ucase( url.reports ))# Reports</a></span></h3>
<p>&nbsp;</p>
<p>&nbsp;</p>



									
																			
											<form class="form-horizontal" name="searchgames" method="post" action="index.cfm?event=admin.games">
												<fieldset>
													<div class="input-group">
														<input type="text" placeholder="Search Users" name="search" class="input-sm form-control"> 
														<span class="input-group-btn">
															<button type="submit" name="dosearch" class="btn btn-sm btn-primary"> Go!</button> 
														</span>
													</div>
												</fieldset>
											</form>										
</cfoutput>
									