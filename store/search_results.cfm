

		
		
		
		
					
		
		
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
													<h5><i class="fa fa-shopping-cart"></i> QwikCut | Game Video Store</h5>
													<span class="pull-right">
														<a href="index.cfm" style="margin-right:5px;" class="btn btn-xs btn-success btn-outline"><i class="fa fa-home"></i> Store Home</a>
														<a href="" style="margin-right:5px;" class="btn btn-xs btn-default btn-outline"><i class="fa fa-play-circle"></i> Search Games</a>														
														<a href="" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-video-camera"></i> Video Cart</a>
													</span>
												</div>
												<div class="ibox-content ibox-heading border-bottom text-center text-navy">
													<h3><strong>Your Search Results</strong></h3>
													<p>Select a team match to view and select individual game videos.</p>
												</div>
												<div class="ibox-content">
													
													<!--- // create our struct and make sure we have form POST data --->
													<cfset rm = {} />
													<cfset rm = getHTTPRequestData() />
													
													<cfif trim( rm.method ) eq "POST">			
														<cfif trim( url.fuseaction ) eq "search">
															<cfif structkeyexists( form, "search" )>
																<cfset searchq = trim( form.search ) />
																	<cfif trim( searchq ) neq "">
																		<cfif isdate( searchq )>
																			<cfset searchvartype = "date" />
																			<cfset searchvar = dateformat( searchq ) />
																		<cfelse>
																			<cfset searchvartype = "teams" />
																			<cfset searchvar = trim( searchq ) />
																		</cfif>
																				
																		<cfinvoke component="apis.com.store.storegameservice" method="searchgames" returnvariable="gamesearchresults">
																			<cfinvokeargument name="searchvartype" value="#searchvartype#">
																			<cfinvokeargument name="searchvar" value="#searchvar#">
																		</cfinvoke>
																		
																		<cfif gamesearchresults.recordcount gt 0>																						
																			<div class="table-responsive">													
																				<h4><i class="fa fa-th-list"></i> <span class="text-success">Search Results | #gamesearchresults.recordcount# game<cfif gamesearchresults.recordcount gt 1>s</cfif> found.  Click Go to View Details.</span>  <span class="pull-right"><a href="index.cfm" class="btn btn-xs btn-white"><i class="fa fa-refresh"></i> Reset</a></span></h4>
																					<table class="table table-bordered table-hover table-striped">
																							<thead>
																								<tr>
																									<th class="text-center">Go</th>
																									<th>Teams</th>
																									<th>Conference</th>
																									<th>Date</th>
																									<th>Game Count</th>
																								</tr>
																							</thead>
																							<tbody>
																								<cfoutput query="gamesearchresults">
																									<tr>
																										<td class="text-center text-primary"><a href=""><i class="fa fa-play-circle fa-2x"></i></a></td>
																										<td>#trim( awayteam )# <i>vs.</i> <strong>#trim( hometeam )#</strong></td>
																										<td>#confname#</td>
																										<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>
																										<td><span class="label label-warning">#totalgames#</span></td>
																									</tr>
																								</cfoutput>													
																							</tbody>
																							<tfoot>
																								<tr>
																									<td colspan="5"><span class="help-block"><i class="fa fa-exclamation-circle"></i><small> Home teams shown in bold.</small></span></td>
																								</tr>
																							</tfoot>
																					</table>
																			</div>
																
																
																		<cfelse>
																		
																			<div style="padding:20px;">
																				<div class="alert alert-danger alert-dismissable">
																					<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																					<p><i class="fa fa-exclamation-circle"></i> <a class="alert-link" href="">Sorry!</a>  Your search for <i>#trim( form.search )#</i> did not match any results in the database.  Search Options are team name, conference name or game date.</p>
																					<p><strong>Please try again...</strong>
																				</div>
																				<br />
																													
																					<form class="form-horizontal m-b" name="searchgames" method="post" action="search_results.cfm?fuseaction=search">
																						<fieldset>
																							<div class="input-group">
																								<input type="text" placeholder="Search for Games by Team or Game Dates" name="search" class="input-sm form-control" onblur="javascript:this.form.submit();" <cfif structkeyexists( form, "search" )>value="#trim( form.search )#"</cfif>> 
																								<span class="input-group-btn">
																									<button type="submit" name="dosearch" class="btn btn-sm btn-primary"> Go!</button> 
																								</span>
																							</div>
																						</fieldset>
																					</form>		
																				
																				
																			</div>																			
																
																		</cfif>									
																		
																		
																	<cfelse>
																		<div class="row">
																			<div class="alert alert-danger">
																				<h5>Error!</h5>
																				<p>Your search query is empty.  Please try again... </p>
																			</div>
																			<br />
																													
																					<form class="form-horizontal m-b" name="searchgames" method="post" action="search_results.cfm?fuseaction=search">
																						<fieldset>
																							<div class="input-group">
																								<input type="text" placeholder="Search for Games by Team or Game Dates" name="search" class="input-sm form-control" onblur="javascript:this.form.submit();" <cfif structkeyexists( form, "search" )>value="#trim( form.search )#"</cfif>> 
																								<span class="input-group-btn">
																									<button type="submit" name="dosearch" class="btn btn-sm btn-primary"> Go!</button> 
																								</span>
																							</div>
																						</fieldset>
																					</form>	
																			
																			
																			
																		</div>
																	</cfif>				
																					
															<cfelse>
																<div class="row">
																	<div class="alert alert-danger">
																		<h5>Error!</h5>
																		<p>There was a problem procesing your search query.  Please try again...</p>
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
													<cfelse>
														<div class="row">
															<div class="alert alert-danger">
																<h5>Error!</h5>
																<p>Invalid request method... </p>
															</div>
														</div>
													</cfif>
													
													
													
													
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


	