<!--- // record the activity --->
													<cfquery name="activitylog">
														insert into activity(userid, activitydate, activitytype, activitytext)														  													   
														 values(
																<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
																<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																<cfqueryparam value="Delete Record" cfsqltype="cf_sql_varchar" />,
																<cfqueryparam value="deleted the state #chkstate.statename# from the system." cfsqltype="cf_sql_varchar" />																
																);
													</cfquery>