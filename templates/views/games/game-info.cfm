		<!doctype html>
			<html lang="en">			
				<head>
					<cfoutput>
						<title>#application.title#</title>
					</cfoutput>									
									
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="apple-mobile-web-app-capable" content="yes">
										
					<!-- bootstrap and fa4 -->
					<link href="../../../css/bootstrap.min.css" rel="stylesheet">
					<link href="../../../font-awesome/css/font-awesome.css" rel="stylesheet">
					

					<!--- // make sure that none of our dynamic pages are cached by the users browser --->
					<cfheader name="cache-control" value="no-cache,no-store,must-revalidate" >
					<cfheader name="pragma" value="no-cache" >
					<cfheader name="expires" value="#getHttpTimeString( Now() )#" >
					
					
					
					
					<!--- // also ensure that non-dynamic pages are not cached by the users browser --->
					<META HTTP-EQUIV="expires" CONTENT="-1">
					<META HTTP-EQUIV="pragma" CONTENT="no-cache">
					<META HTTP-EQUIV="cache-control" CONTENT="no-cache,no-store,must-revalidate">
					
					<script LANGUAGE="JavaScript"> 
						<!-- 
						// *** CLD - 2008-05-19 - Close Window Refresh Parent Window 
						function closeWindow()  
						{ 
						window.close(); 
						if (window.opener && !window.opener.closed) { 
						window.opener.location.reload(); 
						}  
						 
						} 
 
					// --> 
					</script>
					
					
					
				</head>

				<body>
				<cfoutput>
					
					
					<nav class="navbar navbar-inverse" role="navigation">
						<div class="navbar-header">							
							<a href="" class="navbar-brand"><small><i class="fa fa-video-camera"></i> QwikCut | Assign Shooter | Game ID: #url.id#<small></a>
						</div>					
					</nav>
					
									<!--- // begin form processing --->
									<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "assignselectedshooter" )>
														
										<cfset form.validate_require = "shooterid|Please select a videographer from the list.;id|There was an internal error.  Please go back and try again..." />
															
											<cfscript>
												objValidation = createobject( "component","apis.udfs.validation" ).init();
												objValidation.setFields( form );
												objValidation.validate();
											</cfscript>

											<cfif objValidation.getErrorCount() is 0>							
																
												<!--- define our form structure and set form values --->
												<cfset s = structnew() />
												<cfset s.shooterassignid = 0 />
												<cfset s.shooterid = form.shooterid />
												<cfset s.gamevsid = form.id />
												<cfset s.gameid = 0 />
												<cfset s.assigndate = now() />
												<cfset s.assignstatus = "Assigned" />
												<cfset s.notificationtype = "Shooter Notification" />
												<cfset s.notificationstatus = "Queued" />
												<cfset s.notificationtext = "New game assignment." />
													
													<!--- // did not create shooterassignment pkid as auto_increment, workaround --->
													<cfquery name="getlastassignment">
														select max(shooterassignmentid) as assignlastid
														  from shooterassignments
													</cfquery>													
													
													<cfif getlastassignment.assignlastid neq "">													
														<cfset s.shooterassignid = getlastassignment.assignlastid  />
														<cfset s.shooterassignid = s.shooterassignid + 1 />													
													<cfelse>
														<cfset s.shooterassignid = 2365 />
													</cfif>
													
													<cfquery name="getgames">
														select top 1 g.gameid
														  from games g
														 where g.vsid = <cfqueryparam value="#s.gamevsid#" cfsqltype="cf_sql_integer" />														
													</cfquery>
													
													<cfset s.gameid = getgames.gameid />
													
													<cfquery name="assignshooters">
														insert into shooterassignments(shooterassignmentid,gameid,vsid,shooterid,shooterassignstatus,shooterassigndate,shooterassignlastupdated)
															values (
																	<cfqueryparam value="#s.shooterassignid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.gameid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.gamevsid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.shooterid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.assignstatus#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#s.assigndate#" cfsqltype="cf_sql_timestamp" />,
																	<cfqueryparam value="#s.assigndate#" cfsqltype="cf_sql_timestamp" />
																	);
													</cfquery>

													<cfinvoke component="apis.com.admin.shooteradminservice" method="getshooter" returnvariable="shooter">
														<cfinvokeargument name="id" value="#s.shooterid#">
													</cfinvoke>											
													
														<!--- // email --->
														<cfquery name="creategamenotification">
															<!--- // add game assignment to the notification service queue --->											
															insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)														  													   
																values(
																		<cfqueryparam value="#s.gamevsid#" cfsqltype="cf_sql_integer" />,
																		<cfqueryparam value="#s.gameid#" cfsqltype="cf_sql_integer" />,
																		<cfqueryparam value="#s.notificationtype#" cfsqltype="cf_sql_varchar" />,
																		<cfqueryparam value="#s.notificationtext#" cfsqltype="cf_sql_varchar" />,
																		<cfqueryparam value="#s.assigndate#" cfsqltype="cf_sql_timestamp" />,
																		<cfqueryparam value="#s.notificationstatus#" cfsqltype="cf_sql_varchar" />,																		
																		<cfif trim( shooter.shooteralertpref ) eq "txt">
																			<cfqueryparam value="0" cfsqltype="cf_sql_integer" />,
																		<cfelse>
																			<cfqueryparam value="#s.shooterid#" cfsqltype="cf_sql_integer" />,
																		</cfif>
																		<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
																		<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
																		);
														</cfquery>												
															
														<cfif trim( shooter.shooteralertpref ) eq "txt">	
															
															<cfinvoke component="apis.com.admin.gameadminservice" method="getalertversus" returnvariable="versus">
																<cfinvokeargument name="vsid" value="#s.gamevsid#">
															</cfinvoke>														
															
															<cfset s.alerttext = 'New game assignment: ' & versus.hometeam & ' vs. ' & versus.awayteam & ' on ' & dateformat( versus.gamedate, 'mm/dd/yyyy' ) & ' at ' & timeformat( versus.gametime, 'hh:mm' ) & '.  Field: ' & versus.fieldname & '.  Located at: ' & versus.fieldaddress1 & ' ' & versus.fieldaddress2 & ' ' & versus.fieldcity & ', ' & versus.stateabbr & '.' />
															
															<!--- // text message --->
															<cfquery name="creategamenotification">
																insert into shooteralerts(shooterid, alertdatetime, alerttype, alerttext)
																	values(
																		   <cfqueryparam value="#s.shooterid#" cfsqltype="cf_sql_integer" />,
																		   <cfqueryparam value="#s.assigndate#" cfsqltype="cf_sql_timestamp" />,
																		   <cfqueryparam value="Game Alert" cfsqltype="cf_sql_varchar" />,
																		   <cfqueryparam value="#s.alerttext#" cfsqltype="cf_sql_varchar" />																   
																		  );
															</cfquery>
													
														</cfif>
													<!--- // end notify shooters --->
													
													<!---
													<cfquery name="creategamenotification">
														<!--- // add game assignment to the notification service queue --->											
														insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)														  													   
															values(
																	<cfqueryparam value="#s.gamevsid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.gameid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#s.notificationtype#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#s.notificationtext#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#s.assigndate#" cfsqltype="cf_sql_timestamp" />,
																	<cfqueryparam value="#s.notificationstatus#" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="#s.shooterid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
																	<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
																	);
													</cfquery>
													
													 // end notify shooters --->

													<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
															values(
																	<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																	<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																	<cfqueryparam value="Add Record" cfsqltype="cf_sql_varchar" />,
																	<cfqueryparam value="assigned shooter #s.shooterid# to Game ID: #s.gamevsid#." cfsqltype="cf_sql_varchar" />																
																	);
													</cfquery>
													
													<cflocation url="#listlast(cgi.script_name, "/" )#?id=#s.gamevsid#" addtoken="no">													
												
													<div class="container">
														<div style="padding:15px;">
															<div class="alert alert-info">
																<h5><i class="fa fa-save"></i> <strong>Game Assignment Saved &amp; Shooter Notified. </strong></h5>
																<p>The selected shooter was assigned to the match.  Click Close to Continue Assignments.</p>
																<br />
																<a href="javascript:closeWindow();" class="btn btn-sm btn-primary"><i class="fa fa-save"></i> Close</a>											
															</div>
														</div>
													</div>
																
													
													<!--- If the required data is missing - throw the validation error --->
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
									<cfelse>
										
										<cfif structkeyexists( url, "id" ) and isnumeric( url.id )>					
										
											<cfinvoke component="apis.com.admin.gameadminservice" method="getgameinfo" returnvariable="gameinfo">
												<cfinvokeargument name="id" value="#url.id#">
												<cfinvokeargument name="isactive" value="1" />
											</cfinvoke>
											
											<cfinvoke component="apis.com.admin.shooteradminservice" method="getregionshooters" returnvariable="shooterregionlist">
												<cfinvokeargument name="regionid" value="#gameinfo.regionid#">
											</cfinvoke>
									
											<cfif gameinfo.recordcount gt 0>
											
												<cfinvoke component="apis.com.admin.gameadminservice" method="getgameshooters" returnvariable="gameshooters">
													<cfinvokeargument name="vsid" value="#url.id#">
												</cfinvoke>
												
												<div class="container" style="padding: 10px;">
													<cfif gameshooters.recordcount gt 0>
														<div class="table-responsive">														
															<table class="table table-striped table-bordered table-hover">
																<thead>
																	<tr>
																		<th>Shooter Assigned</th>
																		<th>Assignment Date</th>
																		<th>Assignment Status</th>
																	</tr>
																</thead>
																<tbody>
																	<cfloop query="gameshooters">
																		<tr>
																			<td><i class="fa fa-video-camera"></i> #shooterfirstname# #shooterlastname#</td>
																			<td>#dateformat( shooterassigndate, "mm/dd/yyyy" )#</td>
																			<td><span class="<cfif trim( shooterassignstatus ) is "accepted">label label-primary<cfelseif trim( shooterassignstatus ) is "assigned">label label-danger<cfelse>label label-default</cfif>">#shooterassignstatus#</span></td>
																		</tr>
																	</cfloop>
																</tbody>
																<tfoot>
																	<tr>
																		<td colspan="3">#gameshooters.recordcount# total shooter<cfif gameshooters.recordcount neq 1>s</cfif> assigned.</td>
																	</tr>
																</tfoot>
															</table>														
														</div>
													<cfelse>
														<div class="alert alert-info alert-dismissable">
															<p><i class="fa fa-info-circle"></i> There are no shooters assigned to this game.</p>
														</div>													
													</cfif>
													
													<div class="well">
														
														<div style="margin-left:15px;">
														
															<h4 class="m-b"><i class="fa fa-play-circle"></i> <strong>Game Info</strong></h4>
															<p><strong>Conference:</strong> #gameinfo.confname#</p>
															<p><strong>Teams:</strong> #gameinfo.awayteam# <i>vs.</i> <strong>#gameinfo.hometeam#</strong></p>
															<p><strong>Field:</strong> #gameinfo.fieldname#</p>
															<p><strong>Game Date/Time:</strong> #dateformat( gameinfo.gamedate, "mm-dd-yyyy" )# @ #timeformat( gameinfo.gamedate, "hh:mm tt" )#</p>
														
														</div>
														
														<br />
														
														<form name="assign-shooter-to-game" method="post" class="form-inline" action="#listlast(cgi.script_name, "/" )#?id=#url.id#">						
															<div class="col-md-2">
																<label class="control-label" for="shooterlist">Shooter List</label>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<select name="shooterid" class="form-control">
																		<option value="" selected>Select Shooter</option>
																		<cfloop query="shooterregionlist">
																			<option value="#shooterid#">#shooterfirstname# #shooterlastname#</option>
																		</cfloop>
																	</select>
																	<input type="hidden" name="id" value="#url.id#" />
																</div>
															</div>
															
															<div class="form-group">
																<span style="margin-left:15px;">
																	<button type="submit" name="assignselectedshooter" class="btn btn-sm btn-primary"><i class="fa fa-save"></i> Assign Shooter</button>
																	<a href="javascript:window.self.close();" class="btn btn-sm btn-default"><i class="fa fa-times-circle"></i> Cancel</a>
																	<cfif gameshooters.recordcount gt 0>
																		<a href="javascript:closeWindow();" class="btn btn-sm btn-success"><i class="fa fa-th-list"></i> Finished Assignments</a>	
																	</cfif>
																</span>
															</div>									
														</form>
													</div>
													
													<!---
													<cfif gameshooters.recordcount gt 0>
														<div class="container">
															<div style="padding:15px;">
																<div class="alert alert-info">
																	<h5><i class="fa fa-save"></i> <strong>Game Assignment Saved &amp; Shooter Notified. </strong></h5>
																	<p>The selected shooter was assigned to the match.  Click Close to Continue Assignments.</p>
																	<br />
																	<a href="javascript:closeWindow();" class="btn btn-sm btn-primary"><i class="fa fa-save"></i> Close</a>											
																</div>
															</div>
														</div>
													</cfif>
													--->
													
												</div>
											<cfelse>
											
												{{ error recordset }}
												
											</cfif>
										<cfelse>
										
											{{ error in correct format of the id }}
										
										</cfif>
									
									</cfif>
		
				</cfoutput>
		
				<!-- Mainly scripts -->
				<script src="../../../js/jquery-2.1.1.js"></script>
				<script src="../../../js/bootstrap.min.js"></script>
					
				
				<!-- Custom and plugin javascript -->
				<script src="../../../js/inspinia.js"></script>

	
			</body>
		</html>





