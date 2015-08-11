
			

			

				
				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> Delete Field | #fielddetail.fieldname# Field</h5>
							<div class="ibox-tools">
								<a href="#application.root##url.event#" class="btn btn-xs btn-white"><i class="fa fa-arrow-circle-left"></i> Return to List</a>
							</div>
                        </div>						
                        
                        <div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
									
										<cfset form.validate_require = "fieldid|Sorry, the form encountered an unexpected error.  Please return to the list to continue..." />
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset f = structnew() />
											<cfset f.fieldid = form.fieldid />
											<cfset f.fieldname = trim( form.fieldname ) />
																		
												<!--- // check our user id against the shooters table and throw error if found --->
												<cfquery name="chkdata">
													select f.fieldid, f.fieldname, sf.shooterfieldid
													  from fields f, shooterfields sf
													 where f.fieldid = sf.fieldid
													   and f.fieldid = <cfqueryparam value="#f.fieldid#" cfsqltype="cf_sql_integer" />
												</cfquery>
												
												
												<cfif chkdata.recordcount neq 0>											
												
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<h5><i class="fa fa-warning"></i> <error>Sorry, <cfoutput> #chkdata.fieldname#</cfoutput> can not be deleted:</error></h2>
															<ul>
																<li class="formerror">Foreign key constraint on the Fields table.  Operation aborted....</li>
															</ul>
													</div>
												
												<cfelse>
													
													<!--- // no teams or related foreign data found, allow the delete record operation --->
													<cfquery name="deletefield">
														delete 
														  from fields												   
														 where fieldid = <cfqueryparam value="#f.fieldid#" cfsqltype="cf_sql_integer" />												
													</cfquery>

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Delete Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="deleted the field #f.fieldname# from the system." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>
												
													<cflocation url="#application.root##url.event#&scope=f3" addtoken="no">
												
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
							
							
							
							
							
							<form class="form-horizontal" method="post" action="#application.root##url.event#&fuseaction=#url.fuseaction#&id=#url.id#">
                                <h4><i class="fa fa-warning" style="color:##f00;"></i> Delete Confirmation</h4>
								<p>This action can not be un-done.  Are you sure you want to delete <i>#fielddetail.fieldname#</i> &nbsp;from the database?</p>                             
								<br /><br /><br />
                                <div class="hr-line-dashed" style="margin-top:25px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-danger" type="submit" name="killFieldRecord"><i class="fa fa-save"></i> Delete Field</button>
										<a href="#application.root##url.event#" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
										<input type="hidden" name="fieldid" value="#fielddetail.fieldid#" />
										<input type="hidden" name="fieldname" value="#fielddetail.fieldname#" />
									</div>
								</div>
                            </form>
                        </div>
                    </div>
				</cfoutput>