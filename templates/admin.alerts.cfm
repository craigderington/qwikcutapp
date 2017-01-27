

	
			<cfif not isuserinrole( "admin" )>
				<cflocation url="#application.root#user.home&accessdenied=1" addtoken="yes">
			</cfif>		
		
			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">				
					
					<!-- // include the page heading --->
					<cfinclude template="views/admin-alerts-center-page-heading.cfm">
						
						<cfoutput>
							<div class="row">							
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<h5><i class="fa fa-dashboard"></i> Alert Center</h5>
										<span class="pull-right">
											<a href="#application.root#admin.home" class="btn btn-xs btn-success btn-outline"><i class="fa fa-home"></i> Admin Home</a>
											<a href="#application.root#admin.reports" class="btn btn-xs btn-info btn-outline" style="margin-left:5px;><i class="fa fa-archive"></i> Reports</a>
											<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
											<a href="#application.root#admin.payroll" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-money"></i> Payroll</a>
										</span>
									</div>
										
									<div class="ibox-content">
									
										<!--- // create the game from the form data --->
										<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "createAlert" )>
											<cfset form.validate_require = "contactid|The contact is required.;alerttype|The alert type is required.;msgtext|Please enter content for the message." />
											<cfset form.validate_dateus = "alertdate|The alert date and time is required." />
											
											<cfscript>
												objValidation = createobject( "component","apis.udfs.validation" ).init();
												objValidation.setFields( form );
												objValidation.validate();
											</cfscript>

											<cfif objValidation.getErrorCount() is 0>

												<cfset m = structnew() />
												<cfset m.contactid = form.contactid />
												<cfset m.alerttype = trim( form.alerttype ) />
												<cfset m.alertdate = dateformat( form.alertdate, "mm/dd/yyyy" ) />
												<cfset m.alerttime = timeformat( form.alerttime, "hh:mm:ss" ) />
												<cfset m.alerttext = trim( form.msgtext ) />
												<cfset m.gameid = form.gameid />												
												<cfset m.alertdatetime = m.alertdate & ' ' & m.alerttime  />												
												
												<cfquery name="addalert">
													insert into alerts(contactid, alertdatetime, alerttype, alerttext, alertqueued, gameid)
														values(
															   <cfqueryparam value="#m.contactid#" cfsqltype="cf_sql_integer" />,
															   <cfqueryparam value="#m.alertdatetime#" cfsqltype="cf_sql_timestamp" />,
															   <cfqueryparam value="#m.alerttype#" cfsqltype="cf_sql_varchar" />,
															   <cfqueryparam value="#m.alerttext#" cfsqltype="cf_sql_varchar" />,
															   <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
															   <cfqueryparam value="#m.gameid#" cfsqltype="cf_sql_integer" />
														      );
												</cfquery>
												
												<!--- // record the activity --->
												<cfquery name="activitylog">
													insert into activity(userid, activitydate, activitytype, activitytext)
														values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="created a new SMS #m.alerttype#." cfsqltype="cf_sql_varchar" />
																);
												</cfquery>
																								
												
												<!--- // redirect to page --->
												<cflocation url="#application.root##url.event#" addtoken="no">


											<cfelse>

												<div class="alert alert-danger alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h5>
															<ul>
																<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
																	<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
																</cfloop>
															</ul>
												</div>

											</cfif>


										</cfif>				
										
										<div class="row">												
											<div class="col-lg-12">			
												<form name="createalerts" method="post" action="" class="form-horizontal">
													<cfif not structkeyexists( form, "alerttype" )>
														<div class="alert alert-warning alert-dismissable">
															<button type="button" class="close" data-dismiss="alert" aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
															<p><i class="fa fa-mobile"></i> To Create A New Alert, Select an Alert Type</p>													
														</div>
													</cfif>
													<div class="form-group">
														<label class="col-lg-2 control-label">Alert Type:</label>
														<div class="col-lg-6">
															<select name="alerttype" class="form-control" onchange="javascript:this.form.submit()">
																<option value="">Select Alert Type</option>
																<option value="Game Alert"<cfif structkeyexists( form, "alerttype" )><cfif trim( form.alerttype ) is "Game Alert">selected</cfif></cfif>>Game Alert</option>
																<option value="Shooter Alert"<cfif structkeyexists( form, "alerttype" )><cfif trim( form.alerttype ) is "Shooter Alert">selected</cfif></cfif>>Shooter Alert</option>
																<option value="Field Admin Alert"<cfif structkeyexists( form, "alerttype" )><cfif trim( form.alerttype ) is "Field Admin Alert">selected</cfif></cfif>>Field Admin Alert</option>
																<option value="Change of Venue"<cfif structkeyexists( form, "alerttype" )><cfif trim( form.alerttype ) is "Change of Venue">selected</cfif></cfif>>Change of Venue</option>																
															</select>
														</div>
													</div>
													<cfif structkeyexists( form, "alerttype" )>
														<cfif trim( form.alerttype ) is "Game Alert">
															<cfinvoke component="apis.com.admin.smsalertservice" method="getcontacts" returnvariable="contactslist">
															<div class="form-group">
																<label class="col-lg-2 control-label">Team Contact:</label>
																<div class="col-lg-6">
																	<select name="contactid" class="form-control">
																		<option value="">Select Contact</option>
																		<cfloop query="contactslist">
																			<option value="#contactid#">#contactname# (#numalerts#)
																		</cfloop>
																	</select>															
																</div>
															</div>
															
																<div class="form-group">
																	<label class="col-lg-2 control-label">Game:</label>
																	<div class="col-lg-6">
																		<select name="gameid" class="form-control">
																			<option value="">Select Game</option>
																			<option value="6899">02-14-2017 : Silverhawks vs. Warriors</option> 
																		</select>
																	</div>
																</div>
															
														<cfelseif trim( form.alerttype ) is "Shooter Alert">													
															<div class="form-group">
																<label class="col-lg-2 control-label">Shooter:</label>
																<div class="col-lg-6">
																	<select name="shooterid" class="form-control">
																		<option value="">Select Shooter</option>
																	</select>														
																</div>
															</div>
														<cfelseif trim( form.alerttype ) is "Field Admin Alert">													
															<div class="form-group">
																<label class="col-lg-2 control-label">Field Admin:</label>
																<div class="col-lg-6">
																															
																</div>
															</div>
														</cfif>
														
														<div class="form-group" id="data_1">
															<label class="col-lg-2 control-label">Message Text:</label>
															<div class="col-lg-2 input-group date" style="padding-left:15px;">
																<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																<input type="text" class="form-control m-b" name="alertdate" <cfif structkeyexists( form, "alertdate" )>value="#dateformat( form.alertdate, "mm/dd/yyyy" )#"<cfelse>value="#dateformat( now(), "mm/dd/yyyy" )#"</cfif> />
															</div>
														</div>
														<div class="form-group">
															<label class="col-lg-2 control-label">Message Text:</label>
															<div class="col-lg-2 input-group clockpicker" data-autoclose="true" style="padding-left:15px;">
																<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
																<input type="text" class="form-control m-b" name="alerttime" <cfif structkeyexists( form, "alerttime" )>value="#timeformat( form.alerttime, "hh:mm:ss" )#"<cfelse>value="#timeformat( now(), "hh:mm:ss" )#"</cfif>  />
															</div>
														</div>																										
														
														<div class="form-group">
															<label class="col-lg-2 control-label">Message Text:</label>
															<div class="col-lg-6">
																<input type="text" class="form-control" placeholder="Enter a brief message..." name="msgtext" />															
															</div>
														</div>													
														<div class="form-group">
															<div class="col-sm-offset-2 col-sm-4">
																<button class="btn btn-md btn-success" type="submit"><i class="fa fa-envelope"></i> Send</button>
																<a href="#application.root##url.event#" class="btn btn-md btn-default"><i class="fa fa-times-circle"></i> Reset</a>
																<input type="hidden" name="createAlert" value="True" />
															</div>
														</div>
													</cfif>
												</form>
											</div>
										</div>
										<cfif not structkeyexists( form, "alerttype" )>
											<cfinvoke component="apis.com.admin.smsalertservice" method="getqueuedalerts" returnvariable="queuedalertslist">				
											</cfinvoke>

											<cfinvoke component="apis.com.admin.smsalertservice" method="getsentalerts" returnvariable="sentalertslist">				
											</cfinvoke>
											<div class="row" style="margin-top:25px;">
												<div class="col-lg-12">													
													<ul class="nav nav-tabs">
														<li class="active"><a data-toggle="tab" href="##queued">Queued Alerts</a></li>
														<li><a data-toggle="tab" href="##sent">Sent Alerts</a></li>														  
													</ul>
													
													<div class="tab-content">
														<div id="queued" class="tab-pane fade in active">
															<cfif queuedalertslist.recordcount neq 0>														
																<h2 style="margin-top:10px;vertical-align:middle"><i class="fa fa-mobile"></i> Queued Alerts <span style="padding:5px;" class="label label-default pull-right">Total Queued Alerts: #queuedalertslist.recordcount#</span></h2>																	
																	<div class="table-responsive">									
																		<table class="table table-striped">
																			<thead>
																				<tr>										
																					<th>Actions</th>
																					<th>Alert Date</th>
																					<th>Alert Type</th>
																					<th>Contact</th>
																					<th>To</th>
																					<th>Status</th>
																					<th>Info</th>												
																				</tr>
																			</thead>
																			<tbody>															
																				<cfloop query="queuedalertslist">
																					<tr>
																						<td><i class="fa fa-check-circle" title="edit"></i> <i class="fa fa-times-circle" title="delete"></i></td>
																						<td>#dateformat( alertdatetime, "mm/dd/yyyy" )# #timeformat( alertdatetime, "hh:mm:ss" )#</td>
																						<td>#alerttype#</td>
																						<td>#contactname#</td>
																						<td>#contactnumber#</td>
																						<td><cfif alertsent eq 1><span class="label label-success">Sent</span><cfelse><span class="label label-default">Queued</span></cfif></td>
																						<td><small>Game: #hometeam# vs. #awayteam# on #dateformat( gamedate, "mm/dd/yyyy" )#</small></td>
																					</tr>
																				</cfloop>															
																			</tbody>
																		</table>
																	</div>
															<cfelse>
																<br />
																<div class="alert alert-danger alert-dismissable">
																	<h5>There are currently <b>0</b> queued alerts in the database.</h5>
																</div>
															</cfif>													
														</div>
															
														<div id="sent" class="tab-pane fade">
															<cfif sentalertslist.recordcount neq 0>	
																<h2 style="margin-top:10px;vertical-align:middle"><i class="fa fa-mobile"></i> Sent Alerts <span style="padding:5px;" class="label label-success pull-right">Total Sent Alerts: #sentalertslist.recordcount#</span></h2>
																	<div class="table-responsive">									
																		<table class="table table-striped">
																			<thead>
																				<tr>										
																					<th>Alert Sent Date</th>
																					<th>Contact</th>
																					<th>To</th>
																					<th>Status</th>
																					<th>Info</th>
																					<th>MsgID</th>
																				</tr>
																			</thead>
																			<tbody>															
																				<cfloop query="sentalertslist">
																					<tr>
																						<td>#dateformat( alertsentdate, "mm/dd/yyyy" )# #timeformat( alertsentdate, "hh:mm:ss" )#</td>
																						<td>#contactname#</td>
																						<td>#contactnumber#</td>
																						<td><cfif alertsent eq 1><span class="label label-success">Sent</span><cfelse><span class="label label-default">Queued</span></cfif></td>
																						<td><small><b>#alerttype#</b>: #hometeam# vs. #awayteam# on #dateformat( gamedate, "mm/dd/yyyy" )#</small></td>
																						<td>#sid#</td>
																					</tr>
																				</cfloop>															
																			</tbody>
																		</table>
																	</div>
															<cfelse>
																<div class="alert alert-danger alert-dismissable">
																	<h5>There are no alerts in the database.</h5>
																</div>
															</cfif>
														</div>														  
													</div>												
												</div>
											</div>
										</cfif>
									</div>
								</div>								
							</div>	
						</cfoutput>
						
						
				</div><!-- /.container -->
			</div><!-- /.wrapper-content -->
		
