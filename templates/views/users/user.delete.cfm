



			

			

				<cfoutput>
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5><i class="fa fa-database"></i> Delete User Profile | #userdetail.firstname# #userdetail.lastname#</h5>
                        </div>						
                        
                        <div class="ibox-content">
                            
							<!--- // begin form processing --->
									<cfif isDefined( "form.fieldnames" )>
										<cfscript>
											objValidation = createobject( "component","apis.udfs.validation" ).init();
											objValidation.setFields( form );
											objValidation.validate();
										</cfscript>

										<cfif objValidation.getErrorCount() is 0>							
											
											<!--- define our form structure and set form values --->
											<cfset user = structnew() />
											<cfset user.userid = form.userid />
																		
												<!--- // check our user id against the shooters table and throw error if found --->
												<cfquery name="chkshooterprofiles">
													select u.userid, s.userid, s.shooterid
													  from users u, shooters s
													 where u.userid = s.userid
													   and u.userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />
												</cfquery>
												
												
												<cfif chkshooterprofiles.recordcount neq 0>											
												
													<div class="alert alert-danger alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<h5><error>Sorry, <cfoutput> #chkshooterprofiles.userid#</cfoutput> can not be deleted:</error></h2>
															<ul>
																<li class="formerror">Forgeign key constraint on shooters table.</li>
															</ul>
													</div>
												
												<cfelse>
													
													<!--- // no conferences or related data found, allow the delete record operation --->
													<cfquery name="deleteuserprofile">
														delete 
														  from users													   
														 where userid = <cfqueryparam value="#user.userid#" cfsqltype="cf_sql_integer" />												
													</cfquery>										
												
												<cflocation url="#application.root#admin.users" addtoken="no">
												
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
								<p>This action can not be un-done.  Are you sure you want to delete <i>#userdetail.username#</i> from the database?</p>                             
								<br /><br /><br />
                                <div class="hr-line-dashed" style-="margin-top:25px;"></div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-danger" type="submit" name="stateSaveRecord"><i class="fa fa-save"></i> Delete User Profile</button>
										<a href="#application.root#admin.users" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
										<input type="hidden" name="userid" value="#userdetail.userid#" />
										<input name="validate_require" type="hidden" value="userid|The form encountered an unexpected error." />
                                </div>
                            </form>
                        </div>
                    </div>
				</cfoutput>