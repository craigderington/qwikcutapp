			
			
			
			<cfif not isuserinrole("admin")>
				<cflocation url="#application.root#user.home&accessdenied=1" addtoken="yes">
			</cfif>
			
			<cfif structkeyexists( url, "closePayroll" )>
				<cfset tempVar = structdelete( session, "payrollid" ) />
				<cflocation url="#application.root##url.event#" addtoken="no">				
			</cfif>

			<cfinvoke component="apis.com.admin.payrolladminservice" method="getpayroll" returnvariable="payroll">
				<cfinvokeargument name="sdate" value="1/1/2017">
				<cfinvokeargument name="edate" value="2/28/2017">
			</cfinvoke>
			
			<cfset payrollstatuslist = valuelist( payroll.payrollstatus, "," ) />
			
			
			<cfif structkeyexists( form, "startNewPayrollPeriod" )>
				<cfif structkeyexists( form, "sdate" )>
					<cfset sdate = dateformat( form.sdate, "mm/dd/yyyy" ) />
					<cfset edate = dateadd( "d", 7, sdate ) />
					<cfquery name="addnewpayroll">
						insert into payroll(payrollbegindate, payrollenddate, payrollstatus, payrollprocessby)
						   values(
									<cfqueryparam value="#sdate#" cfsqltype="cf_sql_timestamp" />,
									<cfqueryparam value="#edate#" cfsqltype="cf_sql_timestamp" />,
									<cfqueryparam value="Not Started" cfsqltype="cf_sql_varchar" />,
									<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar" />						         
								  ); select @@identity as newpayrollid
					
					</cfquery>
					<cfset session.payrollid = addnewpayroll.newpayrollid />
					<cflocation url="#application.root##url.event#" addtoken="yes">
				</cfif>			
			</cfif>
			
			
			<cfif structkeyexists( form, "addToPayroll" )>
				<cfif structkeyexists( form, "shooterid" )>
					<cfif structkeyexists( form, "assignmentid" )>
						<cfif structkeyexists( form, "payrollid" )>						
							<cfquery name="addnewpayroll">
								insert into payrolldetails(payrollid, shooterid, payhours, paystatus, assignmentid)
								   values(
											<cfqueryparam value="#form.payrollid#" cfsqltype="cf_sql_integer" />,
											<cfqueryparam value="#form.shooterid#" cfsqltype="cf_sql_integer" />,
											<cfqueryparam value="1" cfsqltype="cf_sql_numeric" />,
											<cfqueryparam value="QUEUED" cfsqltype="cf_sql_varchar" />,
											<cfqueryparam value="#form.assignmentid#" cfsqltype="cf_sql_integer" />
										  );							
							</cfquery>
							<cfquery name="updatepayrollstatus">
								update payroll
								   set payrollstatus = <cfqueryparam value="In Progress" cfsqltype="cf_sql_varchar" />
								 where payrollid = <cfqueryparam value="#form.payrollid#" cfsqltype="cf_sql_integer" />
							</cfquery>
							<cflocation url="#application.root##url.event#&fuseaction=added" addtoken="yes">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
			
			
			<cfif structkeyexists( url, "fuseaction" )>
				<cfif trim( url.fuseaction ) is "getPayroll">
					<cfif structkeyexists( url, "id" )>
						<cfif isnumeric( url.id )>
							<cfset session.payrollid = url.id />
							<cflocation url="#application.root##url.event#" addtoken="yes">
						</cfif>
					</cfif>					
				</cfif>			
			</cfif>
			
			
			
			<cfif structkeyexists( url, "fuseaction" )>
				<cfif trim( url.fuseaction ) is "deletePayrollID">
					<cfif structkeyexists( url, "id" )>
						<cfif isnumeric( url.id )>
							<cfquery name="killpayrollid">
								delete from payrolldetails
								  where payrolldetailid = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer" />
							</cfquery>
							<cflocation url="#application.root##url.event#" addtoken="yes">
						</cfif>
					</cfif>					
				</cfif>			
			</cfif>
			
			

			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">				
					
					<!-- // include the page heading --->
					<cfinclude template="views/admin-page-heading.cfm">
						
						<cfoutput>
							<div class="row">							
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										
											<h5><i class="fa fa-dashboard"></i> #session.username# | Admin Payroll System</h5>
											<span class="pull-right">										
												<a href="#application.root#admin.reports" class="btn btn-xs btn-info btn-outline"><i class="fa fa-archive"></i> Reports</a>
												<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
												<a href="#application.root#admin.home" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-home"></i> Admin Home</a>
											</span>
										
									</div>						
										
									<div class="ibox-content">
										
										
										<cfif listcontainsnocase( payrollstatuslist, "not started" ) or listcontainsnocase( payrollstatuslist, "in progress" )>
										
											<cfif not structkeyexists( session, "payrollid" )>
												<div class="alert alert-warning alert-box alert-dismissable fade in" role="alert">
													<a href="##" class="close" data-dismiss="alert" aria-label="close">&times;</a>
														<h4><strong><i class="fa fa-warning"></i> SYSTEM NOTICE: You have unfinished payroll items!</strong></h4> 
														<p>Open payroll must be completed before starting a new payroll period.</p>
														<p>Use the table below to re-open your payroll and complete the open payroll record.</p>
												</div>
											</cfif>
										
										<cfelse>
											
											<div class="row">
												<div class="well well-lg">
													<form class="form-inline" name="payrollsearch" id="payrollsearch" method="post" action="">
														<div class="form-group" id="data_1">														
															<div class="input-group date">
																<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																<input type="text" class="form-control" name="sdate" placeholder="Start Date" />															
															</div>
														</div>																								
														<button type="submit" name="startNewPayrollPeriod" class="btn btn-primary" style="margin-top:5px;"><i class="fa fa-dollar"></i> Create Payroll</button>											
													</form>
												</div>
											</div>
										</cfif>
										
										
										<cfif not structkeyexists( session, "payrollid" )>
											<cfif payroll.recordcount gt 0>										
												<div class="table-responsive">
													<table class="table table-striped table-hover">
														<thead>
															<tr>
																<th>Actions</th>
																<th>ID</th>
																<th>Pay Period</th>
																<th>Status</th>														
															</tr>											
														</thead>
														<tbody>
															<cfloop query="payroll">
																<tr>
																	<td><a href="#application.root##url.event#&fuseaction=getPayroll&id=#payrollid#" onclick="return confirm('This will retrieve the open payroll item #payrollid#.  Continue?');"><i class="fa fa-briefcase fa-2x"></i></a></td>
																	<td>#payrollid#</td>
																	<td>#dateformat( payrollbegindate, "mm/dd/yyyy" )# through #dateformat( payrollenddate, "mm/dd/yyyy" )#</td>
																	<td><span class="label label-<cfif trim( payrollstatus ) eq "Completed">success<cfelseif trim( payrollstatus ) eq "In Progress">danger<cfelseif trim( payrollstatus ) eq "Not Started">default<cfelse>warning</cfif>"> #payrollstatus#</span></td>
																</tr>
															</cfloop>
														</tbody>
														<tfoot>
															<tr>
																<td colspan="4"><i class="fa fa-info-circle"></i> The system found #payroll.recordcount# payroll period<cfif payroll.recordcount neq 1>s</cfif> in the database.</td>
															</tr>
														</tfoot>
													</table>										
												</div>											
											</cfif>
										
										
										<cfelse>
										
											<!--- // begin payroll processing --->
											<cfset today = now() />
											<cfset sdate = createdate( year(today), month(today), 1 ) />
											<cfset edate = createdate( year(today), month(today), daysinmonth(today)) />										
											
											<cfinvoke component="apis.com.admin.payrolladminservice" method="getpayrollinfo" returnvariable="payrollinfo">
												<cfinvokeargument name="id" value="#session.payrollid#">
											</cfinvoke>
											
											<cfinvoke component="apis.com.admin.payrolladminservice" method="getpayrolldetails" returnvariable="payrolldetails">
												<cfinvokeargument name="id" value="#session.payrollid#">
											</cfinvoke>
											
											<cfinvoke component="apis.com.admin.payrolladminservice" method="getpayrollshooters" returnvariable="payrollshooters">
												<cfinvokeargument name="id" value="#session.payrollid#">
												<cfinvokeargument name="sdate" value="#sdate#">
												<cfinvokeargument name="edate" value="#edate#">
											</cfinvoke>
											
											<cfset count = 0 />
											
											
											
											
											<cfif payrolldetails.recordcount gt 0>
											
												<div class="well">
													<strong><i class="fa fa-calendar-o"></i> PAY PERIOD:  #dateformat( payrollinfo.payrollbegindate, "mm/dd/yyyy" )# through #dateformat( payrollinfo.payrollenddate, "mm/dd/yyyy" )#</strong>
													<span class="pull-right">
														<a style="margin-top:-7px;" href="#application.root##url.event#&closePayroll=True" class="btn btn-sm btn-danger" onclick="return confirm('This will close your payroll session.  Continue?');"><i class="fa fa-times-circle"></i> Close Payroll</a>
													</span>
												</div>
											
											
												<div class="table-responsive">
													<table class="table table-striped table-hover">
														<thead>
															<tr>
																<th>Remove</th>
																<th>PayID</th>
																<th>Pay Period</th>
																<th>Payroll Name</th>
																<th>Status</th>
																<th>Hours</th>
																<th>Pay Rate</th>																
																<th>Extra Pay</th>
																<th>Total Pay</th>
															</tr>											
														</thead>
														<tbody>
															<form class="form-inline" id="process-payroll" name="process-payroll" method="post" action="">
																<cfloop query="payrolldetails">
																	<cfset totalpay = 65.00 * payhours />
																	<cfif shooterbankname is not "" and shooterbankaccountnumber is not "" and shooterbankroutingnumber is not "">
																		<cfset shootersetup = 1 />
																	<cfelse>
																		<cfset shootersetup = 0 />
																	</cfif>			
																	
																	<tr class="<cfif shootersetup eq 0>danger<cfelse>success</cfif>">
																		<td><a href="#application.root##url.event#&fuseaction=deletePayrollID&id=#payrolldetailid#" onclick="return confirm('This will remove this shooter\'s assignment from the current payroll session.  Continue?');"><i class="fa fa-times-circle fa-2x"></i></a></td>
																		<td>#payrolldetailid#-#assignmentid# <input type="hidden" name="payrolldetailid" value="#payrolldetailid#" /></td>
																		<td><small>#dateformat( payrollbegindate, "mm/dd/yyyy" )# > #dateformat( payrollenddate, "mm/dd/yyyy" )#</small></td>
																		<td>(#shooterid#) #shooterfirstname# #shooterlastname#</td>
																		<td><span class="label label-<cfif trim( paystatus ) eq "Completed">success<cfelseif trim( paystatus ) eq "In Progress">danger<cfelseif trim( paystatus ) eq "queued">default<cfelse>warning</cfif>"> #paystatus#</span></td>
																		<td><input type="text" class="form-control" value="#payhours#" /></td>
																		<td><input type="text" class="form-control" value="65.00" /></td>
																		<td><input type="text" class="form-control" placeholder="0.00" /></td>
																		<td><input type="text" class="form-control" value="#numberformat( totalpay, "999.99" )#"/></td>															
																	</tr>																
																</cfloop>															
															
																<tr class="form-actions">
																	<td colspan="9">
																		<span class="pull-right">
																			<button type="submit" name="processpayroll" id="processpayroll" class="btn btn-md btn-info" onclick="return confirm('This will complete the current payroll process.  Are you sure you want to continue?');">
																				<i class="fa fa-arrow-circle-right"></i> Process Payroll
																			</button>
																		</span>
																	</td>
																</tr>
															</form>
														</tbody>
														<tfoot>
															<tr>
																<td colspan="9"><small><i class="fa fa-info-circle"></i> The system found #payrolldetails.recordcount# shooter<cfif payrolldetails.recordcount neq 1>s</cfif> in this payroll period.</small></td>
															</tr>
														</tfoot>
													</table>										
												</div>
											
											<cfelse>											
												<div class="alert alert-danger alert-box alert-dismissable fade in" role="alert">						
													<a href="#application.root##url.event#&closePayroll=True" onclick="return confirm('This will close your payroll session.  Continue?');" class="close" data-dismiss="alert" aria-label="close"><small>[Close Payroll]</small></a>
														<h4><strong><i class="fa fa-money"></i> No Shooters Added to Payroll: #session.payrollid# : #dateformat( payrollinfo.payrollbegindate, "mm/dd/yyyy" )# through #dateformat( payrollinfo.payrollenddate, "mm/dd/yyyy" )#</strong></h4>
														<p>Begin adding shooters to this Payroll Period by clicking <strong>Add to Payroll</strong>.</p> 
														<p>Use the form buttons below to select this week's game shooters.</p>														
												</div>
												
											</cfif>
											
											
											
											<cfif payrollshooters.recordcount gt 0>
												<div class="table-responsive">
													<table class="table table-hover">
														<thead>
															<th>Shooter</th>
															<th>Game Details</th>
															<th>Status</th>
															<th>Last Update</th>
															<th>Add to Payroll</th>
														<thead>																
														<tbody>
															<cfloop query="payrollshooters">
																<form class="form-inline" name="addpayrollrecord" id="#count#-#shooterid#" method="post" action="">	
																	<tr>
																		<td>#shooterfirstname# #shooterlastname#</td>
																		<td>Game: #hometeam# vs. #awayteam# on #dateformat( gamedate, "mm/dd/yyyy" )#</td>
																		<td>#shooterassignstatus#</td>
																		<td>#dateformat( shooterassignlastupdated, "mm/dd/yyyy" )# #timeformat( shooterassignlastupdated, "hh:mm tt" )#</td>
																		<td>
																			<input type="hidden" name="shooterid" value="#shooterid#" />
																			<input type="hidden" name="assignmentid" value="#shooterassignmentid#" />
																			<input type="hidden" name="payrollid" value="#session.payrollid#" />
																			<button class="btn btn-success" name="addToPayroll"><i class="fa fa-plus"></i> Add To Payroll</button>
																			 
																	</tr>
																</form>
																<cfset count = count + 1 />
															</cfloop>
														</tbody>
																
														<tfoot>
																
														</tfoot>
														
													</table>
												</div>

											<cfelse>
											
												
												
											</cfif>
										
										
										
										
										
										
										
										
										
										
										
										
										</cfif>
									</div>
									<div class="ibox-footer">
										<i class="fa fa-money"></i> QC+ Payroll Admin
									</div>
								</div>
							</div>
						</cfoutput>