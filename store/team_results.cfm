

		
			
			
		
		
		
		
		
		
		
		
			<cfif structkeyexists( url, "cid" ) and structkeyexists( url, "fuseaction" )>
				<cfif isnumeric( url.cid ) and trim( url.fuseaction ) eq "getteams">
					<cfinvoke component="apis.com.store.storegameservice" method="getteams" returnvariable="teamlist">
						<cfinvokeargument name="conferenceid" value="#url.cid#">
					</cfinvoke>
					<cfinvoke component="apis.com.store.storegameservice" method="getconference" returnvariable="conferencename">
						<cfinvokeargument name="conferenceid" value="#url.cid#">
					</cfinvoke>
					
					<cfif structkeyexists( url, "team_org_name" )>
						<cfset teamorgname = trim( url.team_org_name ) />
						<cfinvoke component="apis.com.store.storegameservice" method="getteamsbyname" returnvariable="teams">
							<cfinvokeargument name="teamorgname" value="#teamorgname#">
						</cfinvoke>
					</cfif>
					
					
					
				<cfelse>
					<div class="row">
						<div class="alert alert-danger">
							<h5>System Error!</h5>
							<p>Sorry, invalid search parameters!</p>
						</div>
					</div>
				</cfif>
			<cfelse>
				<div class="row">
					<div class="alert alert-danger">
						<h5>System Error!</h5>
						<p>Sorry, the search query structure is malformed and the operation can not be completed... </p>
					</div>
				</div>
			</cfif>
			
			
			
			
		
		





			

		
		
		
		
		
		
		
		<cfset today = now() />


		<!doctype html>
			<html lang="en">			
				<head>
					<cfoutput>
						<title>#application.title#</title>
					</cfoutput>									
									
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="apple-mobile-web-app-capable" content="yes"> 				
					
					<!-- Boostrap and Font-Awesome -->
					<link href="../css/bootstrap.min.css" rel="stylesheet">
					<link href="../font-awesome/css/font-awesome.css" rel="stylesheet">
					<link href="../css/animate.css" rel="stylesheet">
					<link href="../css/style.css" rel="stylesheet">					
					<link href="../css/plugins/datapicker/datepicker3.css" rel="stylesheet">
					<link href="../css/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet">
					<link href="../css/plugins/steps/jquery.steps.css" rel="stylesheet">

					<!--- // make sure that none of our dynamic pages are cached by the users browser --->
					<cfheader name="cache-control" value="no-cache,no-store,must-revalidate" >
					<cfheader name="pragma" value="no-cache" >
					<cfheader name="expires" value="#getHttpTimeString( Now() )#" >
					
					<!--- // shortcut icon --->
					<link rel="shortcut icon" href="http://qwikcut.cloudapp.net/qwikcutapp/favicon.ico?v=2" type="image/x-icon" />
					<link rel="icon" href="http://qwikcut.cloudapp.net/qwikcutapp/favicon.ico?v=2" type="image/x-icon">
					<link rel="apple-touch-icon" href="http://qwikcut.cloudapp.net/qwikcutapp/img/qwikcut-icon-60x60.png"/>
					
					<!--- // also ensure that non-dynamic pages are not cached by the users browser --->
					<META HTTP-EQUIV="expires" CONTENT="-1">
					<META HTTP-EQUIV="pragma" CONTENT="no-cache">
					<META HTTP-EQUIV="cache-control" CONTENT="no-cache,no-store,must-revalidate">
				
				</head>
				
				<cfoutput>
				
				
				
				<body class="top-navigation">				
					<div id="wrapper">					
						<div id="page-wrapper" class="gray-bg">
							<div class="row border-bottom white-bg">
								<nav class="navbar navbar-fixed-top" role="navigation">
									<div class="navbar-header">
										<button aria-controls="navbar" aria-expanded="false" data-target="##navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
											<i class="fa fa-reorder"></i>
										</button>
										<a href="index.cfm" class="navbar-brand"><i class="fa fa-upload"></i> QwikCut</a>
									</div>
						
									<div class="navbar-collapse collapse" id="navbar">
										<ul class="nav navbar-nav">
											<li class="active">
												<a aria-expanded="false" role="button" href="index.cfm"> Game Video Store</a>
											</li>
										</ul>												
									</div>
								</nav>
							</div>
							
							<div class="wrapper wrapper-content animated fadeIn">
								<div class="container">
									<div class="row" style="margin-top:20px;">
										<div class="col-md-12">
											<div class="ibox">
												<div class="ibox-title">
													<h5><i class="fa fa-shopping-cart"></i> QwikCut | Game Video Store  <a href="index.cfm" style="margin-left: 5px;" class="btn btn-xs btn-white"><i class="fa fa-refresh"></i> Reset</a></h5>
													<span class="pull-right">
														<a href="index.cfm" style="margin-right:5px;" class="btn btn-xs btn-success btn-outline"><i class="fa fa-home"></i> Store Home</a>
														<a href="search.cfm" style="margin-right:5px;" class="btn btn-xs btn-default btn-outline"><i class="fa fa-play-circle"></i> Search Games</a>														
														<a href="cart.cfm" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-video-camera"></i> Video Cart</a>
													</span>
												</div>
												<div class="ibox-content ibox-heading border-bottom text-center text-navy">
													
													<cfif structkeyexists( url, "team_org_name" )>
														<h3><strong>#teams.teamorgname# Search Results</strong></h3>
														<p>Select a team's division to view individual games.</p>
													<cfelse>
														<h3><strong>#conferencename.confname# Team Search Results</strong></h3>
														<p>Select a team organization to view individual divisions.</p>
													</cfif>
												</div>
												<div class="ibox-content">										
													<div class="table-responsive">
														
														<cfif structkeyexists( url, "team_org_name" )>
														
															<table class="table table-striped table-hover" >
																<thead>
																	<tr>
																		<th>Select</th>
																		<th>Team Name</th>																	
																		<th>Division</th>
																		<th>Status</th>
																		<th>Actions</th>
																	</tr>
																</thead>
																<tbody>
																	<cfloop query="teams">
																		<tr>
																			<td><a href="games_list.cfm?team_id=#teamid#"><i class="fa fa-trophy fa-2x text-navy"></a></td>
																			<td><a href="games_list.cfm?team_id=#teamid#"><strong>#teamorgname#</strong></a></td>																		
																			<td class="center"><span class="label label-success">#teamlevelname#</td>
																			<td class="center"><i class="fa fa-check-circle-o text-primary fa-2x"></i></td>
																			<td><a href="season_pass.cfm?team_id=#teamid#&option=season_pass" class="btn btn-sm btn-primary"><i class="fa fa-shopping-cart"></i> Buy Season Pass</a></td>
																		</tr>
																	</cfloop>
																</tbody>
																<tfoot>
																	<tr>
																		<td colspan="4"><small>Showing #teams.recordcount# team divisions for #teams.teamname#.</small><span class="pull-right"><a href="index.cfm" class="btn btn-xs btn-white"><i class="fa fa-refresh"></i> Reset</a></span></td>
																	</tr>
																</tfoot>
															</table>
														
														<cfelse>
														
															<table class="table table-striped table-hover" >
																<thead>
																	<tr>
																		<th>Select</th>
																		<th>Team Name</th>																	
																		<th>Team Count</th>
																		<th>Status</th>
																	</tr>
																</thead>
																<tbody>
																	<cfloop query="teamlist">
																		<tr>
																			<td><a href="team_results.cfm?cid=#url.cid#&fuseaction=getteams&team_org_name=#trim( teamorgname )#"><i class="fa fa-trophy fa-2x text-navy"></a></td>
																			<td><a href="team_results.cfm?cid=#url.cid#&fuseaction=getteams&team_org_name=#trim( teamorgname )#"><strong>#teamorgname#</strong></a></td>																		
																			<td class="center">#totalteams#</td>
																			<td class="center"><i class="fa fa-check-circle-o text-primary fa-2x"></i></td>
																		</tr>
																	</cfloop>
																</tbody>
																<tfoot>
																	<tr>
																		<td colspan="4"><small>Showing #teamlist.recordcount# team organizations.</small><span class="pull-right"><a href="index.cfm" class="btn btn-xs btn-white"><i class="fa fa-refresh"></i> Reset</a></span></td>
																	</tr>
																</tfoot>
															</table>
														
														</cfif>
														
														
													</div>
												</div>
											</div>
										</div>
									</div>
								</div><!-- /.container -->
							</div><!-- /.wrapper-content -->
		

				
				
				
				
				</cfoutput>
				
				
				</div><!-- / .page-wrapper -->
        </div><!-- /.wrapper -->
		
		
		<!--- // footer --->	
		
		
		<cfoutput>
			<div class="footer fixed">
				<div class="pull-right">
					Game Video &amp; Analytics
				</div>
				<div>
					<strong>&copy; #year( now() )# Qwikcut.com.  All Rights Reserved.</strong>
				</div>				
			</div>
		</cfoutput>
		
		<!-- mainly scripts -->
		<script src="../js/jquery-2.1.1.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		<script src="../js/plugins/metisMenu/jquery.metisMenu.js"></script>
		<script src="../js/plugins/slimscroll/jquery.slimscroll.min.js"></script>	
		
		<!-- custom and plugin javascript -->
		<script src="../js/inspinia.js"></script>		
		
		<!-- date picker -->
		<script src="../js/plugins/datapicker/bootstrap-datepicker.js"></script>
		<!-- Date range picker -->
		<script src="../js/plugins/daterangepicker/daterangepicker.js"></script>
			<script>
			$(document).ready(function(){
				$('#data_1 .input-group.date').datepicker({
					todayBtn: "linked",
					keyboardNavigation: false,
					forceParse: false,
					calendarWeeks: true,
					autoclose: true
				});
				$('#data_5 .input-daterange').datepicker({
					keyboardNavigation: false,
					forceParse: false,
					autoclose: true
				});
			});
		</script>
		
		
		

		<!-- Flot 
		<script src="js/plugins/flot/jquery.flot.js"></script>
		<script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
		<script src="js/plugins/flot/jquery.flot.resize.js"></script>		
		<script src="js/plugins/chartJs/Chart.min.js"></script>		
		<script src="js/plugins/peity/jquery.peity.min.js"></script>		
		<script src="js/demo/peity-demo.js"></script>
		-->
	</body>
</html>


	