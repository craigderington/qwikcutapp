
				
				
				
				
				<cfset today = now() />



				<cfoutput>
					<div class="row">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-calendar"></i> Block Out Dates</h5>							
							</div>
							<div class="ibox-content">
								
								<cfif isdefined( "form.fieldnames" ) and structkeyexists( form, "shooterid" )>
										
									<cfset form.validate_require = "shooterid|Opps, internal form error.;start|Please select the block out start date;end|Please select the block out end date.;blockreason|Please enter the block out date reason." />
										
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>																											
																	
											<!--- define our form structure and set form values --->
											<cfset s = structnew() />
											<cfset s.shooterid = numberformat( form.shooterid, "99" ) />
											<cfset s.fromdate = form.start  />
											<cfset s.todate = form.end />
											<cfset s.blockreason = trim( blockreason ) />
											
											
											<cfif datecompare( s.fromdate, s.todate, "d" ) eq -1>
											
												<!--- add the new user record --->
												<cfquery name="addshooterdates">
													insert into shooterblockoutdates(shooterid, fromdate, todate, blockreason)
														values(
																<cfqueryparam value="#s.shooterid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#s.fromdate#" cfsqltype="cf_sql_date" />,
																<cfqueryparam value="#s.todate#" cfsqltype="cf_sql_date"  />,
																<cfqueryparam value="#s.blockreason#" cfsqltype="cf_sql_varchar" maxlength="50" />															
															);
												</cfquery>

												<!--- // send shooter invitation // to do --->													
												<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#" addtoken="no">
											
											<cfelse>
											
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
													<p><i class="fa fa-warning"></i> Error.  The <i>to date</i> can not be earlier than the <i>from date</i>.  Please try again...</p>								
												</div>
											
											</cfif>
														
										<!--- If the required data is missing - throw the validation error --->
										<cfelse>
											
												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h2>
															<ul>
																<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
																	<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
																</cfloop>
															</ul>
												</div>				
											
										</cfif>										
															
								</cfif>
								<!--- // end form processing --->
							
								<form name="shooter-dates-add" method="post" action="">
									<div class="form-group" id="data_5">
										<label><small>Range select</small></label>
										<div class="input-daterange input-group" id="datepicker">
											<input type="text" class="input-sm form-control" name="start" value="#dateformat( today, "mm/dd/yyyy" )#">
											<span class="input-group-addon">to</span>
											<input type="text" class="input-sm form-control" name="end" value="#dateformat( today, "mm/dd/yyyy" )#">
										</div>
									</div>			
									<div class="hr-line-dashed"></div>
									<div class="form-group">					
										<input type="text" class="form-control" placeholder="Block Reason" name="blockreason" />										
									</div>
									<div class="hr-line-dashed"></div>									
									<div class="form-group">									
										<input type="hidden" name="shooterid" value="#url.id#" />								
										<button class="btn btn-sm btn-primary" type="submit"><i class="fa fa-save"></i> Add Block Out Dates</button>								
									</div>
								</form>
							</div>
						</div>
					</div>
				</cfoutput>
								
								