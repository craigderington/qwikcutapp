									
									
									
									
									
									
								<cfoutput>	
									<form name="team-form-conference" method="post" class="form-horizontal" action="">							
										<div class="form-group">
											<label class="col-lg-2 control-label">Conference</label>
											<div class="col-lg-10">
												<select class="form-control m-b" name="conference" onchange="javascript:this.form.submit();">
													<option value="">Select Conference</option>
													<cfloop query="conferencelist">
														<option value="#confid#">#confname#</option>
													</cfloop>													
												</select>
												<input type="hidden" name="getconference" value="true" />												
												<span class="help-block m-b-none">Please begin by selecting the conference.</span>
											</div>
										</div>
										<div class="hr-line-dashed" style="min-height:50px;"></div>
									</form>
								</cfoutput>