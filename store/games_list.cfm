

		
			
			
		
		
			<cfset myref = cgi.http_referer />
		
			<cfif structkeyexists( url, "fuseaction" )>
				<cfif structkeyexists( url, "vsid" )>
					<cfset vsid = url.vsid />
					<cfset session.vsid = url.vsid />
					<cflocation url="games.cfm" addtoken="no">
				</cfif>
			</cfif>
		
		
		
			<cfif structkeyexists( url, "team_id" )>
				<cfif isnumeric( url.team_id )>
					<cfset teamid = url.team_id />
					<cfinvoke component="apis.com.store.storegameservice" method="getteambyid" returnvariable="teaminfo">
						<cfinvokeargument name="teamid" value="#teamid#">
					</cfinvoke>
					<cfinvoke component="apis.com.store.storegameservice" method="getgamesbyteam" returnvariable="teamgames">
						<cfinvokeargument name="teamid" value="#teamid#">
					</cfinvoke>
					
				<cfelse>
					<div class="row">
						<div class="alert alert-danger">
							<h5>System Error!</h5>
							<p>Sorry, invalid search parameters!</p>
						</div>
					</div>
				</cfif>
			<cfelse>
				<div class="row" style="margin-top:40px;">
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
													<h5><i class="fa fa-shopping-cart"></i> QwikCut | Game Video Store  <a href="#myref#" style="margin-left: 5px;" class="btn btn-xs btn-white"><i class="fa fa-refresh"></i> Reset</a></h5>
													<span class="pull-right">
														<a href="index.cfm" style="margin-right:5px;" class="btn btn-xs btn-success btn-outline"><i class="fa fa-home"></i> Store Home</a>
														<a href="search.cfm" style="margin-right:5px;" class="btn btn-xs btn-default btn-outline"><i class="fa fa-play-circle"></i> Search Games</a>														
														<a href="cart.cfm" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-video-camera"></i> Video Cart</a>
													</span>
												</div>
												<div class="ibox-content ibox-heading border-bottom text-center text-navy">										
													<h3><strong>#trim( teaminfo.teamorgname )# Games List</strong></h3>
													<p>Select an individual game to add game to your video cart.</p>													
												</div>
												<div class="ibox-content">										
													<div class="table-responsive">
														
														<cfif teamgames.recordcount gt 0>
															
															<div class="alert alert-success alert-dismissable">
																<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																<p><a class="alert-link" href="games.cfm?add_to_cart=true&option=pro">QwikCut Pro Option</a><span class="pull-right"><a href="games.cfm?add_to_cart=true&option=pro" class="btn btn-sm btn-success"><i class="fa fa-shopping-cart"></i> Add to Cart</a></span></p>
																<p>Get access to every game, every week for all teams in the selected conference and division.</p>
															</div>
															
															<table class="table table-striped table-hover" >
																<thead>
																	<tr>
																		<th>Game ID</th>
																		<th>Game Date</th>																	
																		<th>Division</th>
																		<th>Teams</th>
																		<th>Field</th>
																		<th>Actions</th>
																	</tr>
																</thead>
																<tbody>
																	<cfloop query="teamgames">
																		<tr>
																			<td><a href="#cgi.script_name#?fuseaction=getgames&vsid=#vsid#">#gameid#</a></td>
																			<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>																		
																			<td><span class="label label-success">#teamlevelname#</td>
																			<td>#awayteam# <i>vs.</i> #hometeam#</td>
																			<td>#fieldname# Field</td>
																			<td><a href="" class="btn btn-sm btn-primary"><i class="fa fa-shopping-cart"></i> Buy Season Pass</a></td>
																		</tr>
																	</cfloop>
																</tbody>
																<tfoot>
																	<tr>
																		<td colspan="6"><small>Showing #teamgames.recordcount# game<cfif teamgames.recordcount gt 1>s</cfif> for #teaminfo.teamorgname# - #teaminfo.teamlevelname#</small><span class="pull-right"><a href="#myref#" class="btn btn-xs btn-white"><i class="fa fa-refresh"></i> Reset</a></span></td>
																	</tr>
																</tfoot>
															</table>
														
														<cfelse>
														
															<div class="alert alert-danger">
																<h5>Sorry, No Games Found!</h5>
																<p>The selected team and division does not have any scheduled games to display. Please <a href="javascript:history.back(-1);">click here</a> to return to the previous page.</p>
															</div>
														
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
		
		
		
		
		

		
	</body>
</html>


	