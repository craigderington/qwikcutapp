



		<cfset today = now() />	
		
		
		<cfif structkeyexists( session, "vsid" )>		
			<cfinvoke component="apis.com.store.storegameservice" method="getgames" returnvariable="games">
				<cfinvokeargument name="vsid" value="#session.vsid#">
			</cfinvoke>
		
			<cfif structkeyexists( url, "add_to_cart" )>			
				<cfif structkeyexists( url, "game_id" ) and url.game_id neq 0>
					
					<cfset gameid = url.game_id />
					
					<cfinvoke component="apis.com.store.storegameservice" method="getgamedetail" returnvariable="gamedetail">
						<cfinvokeargument name="gameid" value="#gameid#">
					</cfinvoke>
					
					<cfif structkeyexists( session, "cart_id" )>
					
						<!--- // add cart item to existing cart --->
						<cftry>
							<cfquery name="additemtocart">
								insert into cart_items(cart_id, cart_item, cart_item_descr, cart_item_qty, cart_item_price, cart_item_total)
									values(
											<cfqueryparam value="#session.cart_id#" cfsqltype="cf_sql_integer" />,
											<cfqueryparam value="#gamedetail.teamlevelname# Game" cfsqltype="cf_sql_varchar" />,
											<cfqueryparam value="#gamedetail.awayteam# vs. #gamedetail.hometeam# on #dateformat( gamedetail.gamedate, "mm-dd-yyyy" )#" cfsqltype="cf_sql_varchar" />,
											<cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
											<cfqueryparam value="75.00" cfsqltype="cf_sql_float" />,
											<cfqueryparam value="75.00" cfsqltype="cf_sql_float" />								   
										   );
							</cfquery>
							<cflocation url="games.cfm?cart_saved=true" addtoken="no">
							<cfcatch>
								<div class="alert alert-danger">
									<h5>You've Thrown a Database <b>Error</b></h5> 
										<cfoutput> 
											<!--- The diagnostic message from ColdFusion. ---> 
											<p>#cfcatch.message#</p> 
											<p>Caught an exception, type = #cfcatch.type#</p> 
											<p>The contents of the tag stack are:</p> 
											<cfdump var="#cfcatch.tagcontext#"> 
										</cfoutput>
								</div>
							</cfcatch>
						</cftry>
					
					<cfelse>
					
						<!--- // add cart item to new cart --->
						<cfset thiscart = trim( session.urltoken ) />
						<cfset thiscfid = listfirst( thiscart, "&" ) />
						<cfset thisjsess = listlast( thiscart, "&" ) />
						<cfset thiscfid = listlast( thiscfid, "=" ) />
						<cfset thisjsess = listlast( thisjsess, "=" ) />
						
						
						<cfset mycart = structnew() />
						<cfset mycart.sessionid = session.sessionid />
						<cfset mycart.jsess = thisjsess />
						<cfset mycart.cart_date = today />
						<cfset mycart.cart_cfid = thiscfid />
						
						<!-- try to insert into the database --->
						<cftry>
							<cfquery name="createcart">
								insert into carts(cart_session, cart_date, cart_cfid, cart_active, cart_jsess)
									values(
										   <cfqueryparam value="#mycart.sessionid#" cfsqltype="cf_sql_varchar" maxlength="32" />,
										   <cfqueryparam value="#mycart.cart_date#" cfsqltype="cf_sql_timestamp" />,
										   <cfqueryparam value="#mycart.cart_cfid#" cfsqltype="cf_sql_varchar" maxlength="36" />,
										   <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
										   <cfqueryparam value="#mycart.jsess#" cfsqltype="cf_sql_varchar" maxlength="36" />
										   ); select @@identity as newcartid
							</cfquery>
							
							<!--- // now that we have an existing cart session, add the selected item to the cart --->
							<cfquery name="additemtocart">
								insert into cart_items(cart_id, cart_item, cart_item_descr, cart_item_qty, cart_item_price, cart_item_total)
									values(
										   <cfqueryparam value="#createcart.newcartid#" cfsqltype="cf_sql_integer" />,
										   <cfqueryparam value="#gamedetail.teamlevelname# Game" cfsqltype="cf_sql_varchar" />,
										   <cfqueryparam value="#gamedetail.awayteam# vs. #gamedetail.hometeam# on #dateformat( gamedetail.gamedate, "mm-dd-yyyy" )#" cfsqltype="cf_sql_varchar" />,
										   <cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
										   <cfqueryparam value="75.00" cfsqltype="cf_sql_float" />,
										   <cfqueryparam value="75.00" cfsqltype="cf_sql_float" />										   
										   );
							</cfquery>					
							
								<cfset session.cart_id = createcart.newcartid />
								<cflocation url="games.cfm?cart_saved=true" addtoken="no">
							<!--- catch any db errors --->
							<cfcatch type="database">
								<div class="alert alert-danger">
									<h5>You've Thrown a Database <b>Error</b></h5> 
										<cfoutput> 
											<!--- The diagnostic message from ColdFusion. ---> 
											<p>#cfcatch.message#</p> 
											<p>Caught an exception, type = #cfcatch.type#</p> 
											<p>The contents of the tag stack are:</p> 
											<cfdump var="#cfcatch.tagcontext#"> 
										</cfoutput>
								</div>
							</cfcatch>						
						</cftry>
						
						
					
					</cfif>
				
				<cfelseif structkeyexists( url, "option" ) and trim( url.option ) eq "pro">
				
					<cfif structkeyexists( session, "cart_id" )>
					
						<!--- // add cart item to existing cart --->
						<cftry>
							<cfquery name="additemtocart">
								insert into cart_items(cart_id, cart_item, cart_item_descr, cart_item_qty, cart_item_price, cart_item_total)
									values(
											<cfqueryparam value="#session.cart_id#" cfsqltype="cf_sql_integer" />,
											<cfqueryparam value="QwikCut Pro Option" cfsqltype="cf_sql_varchar" />,
											<cfqueryparam value="#games.confname# - All Games" cfsqltype="cf_sql_varchar" />,
											<cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
											<cfqueryparam value="562.50" cfsqltype="cf_sql_float" />,
											<cfqueryparam value="562.50" cfsqltype="cf_sql_float" />								   
										   );
							</cfquery>
							<cflocation url="games.cfm?cart_saved=true" addtoken="no">
							<cfcatch>
								<div class="alert alert-danger">
									<h5>You've Thrown a Database <b>Error</b></h5> 
										<cfoutput> 
											<!--- The diagnostic message from ColdFusion. ---> 
											<p>#cfcatch.message#</p> 
											<p>Caught an exception, type = #cfcatch.type#</p> 
											<p>The contents of the tag stack are:</p> 
											<cfdump var="#cfcatch.tagcontext#"> 
										</cfoutput>
								</div>
							</cfcatch>
						</cftry>
					
					<cfelse>
					
						<!--- // add cart item to new cart --->
						<cfset thiscart = trim( session.urltoken ) />
						<cfset thiscfid = listfirst( thiscart, "&" ) />
						<cfset thisjsess = listlast( thiscart, "&" ) />
						<cfset thiscfid = listlast( thiscfid, "=" ) />
						<cfset thisjsess = listlast( thisjsess, "=" ) />
						
						
						<cfset mycart = structnew() />
						<cfset mycart.sessionid = session.sessionid />
						<cfset mycart.jsess = thisjsess />
						<cfset mycart.cart_date = today />
						<cfset mycart.cart_cfid = thiscfid />
						
						<!-- try to insert into the database --->
						<cftry>
							<cfquery name="createcart">
								insert into carts(cart_session, cart_date, cart_cfid, cart_active, cart_jsess)
									values(
										   <cfqueryparam value="#mycart.sessionid#" cfsqltype="cf_sql_varchar" maxlength="32" />,
										   <cfqueryparam value="#mycart.cart_date#" cfsqltype="cf_sql_timestamp" />,
										   <cfqueryparam value="#mycart.cart_cfid#" cfsqltype="cf_sql_varchar" maxlength="36" />,
										   <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
										   <cfqueryparam value="#mycart.jsess#" cfsqltype="cf_sql_varchar" maxlength="36" />
										   ); select @@identity as newcartid
							</cfquery>
							
							<!--- // now that we have an existing cart session, add the selected item to the cart --->
							<cfquery name="additemtocart">
								insert into cart_items(cart_id, cart_item, cart_item_descr, cart_item_qty, cart_item_price, cart_item_total)
									values(
										   <cfqueryparam value="#createcart.newcartid#" cfsqltype="cf_sql_integer" />,
										   <cfqueryparam value="QwikCut Pro Option" cfsqltype="cf_sql_varchar" />,
										   <cfqueryparam value="#games.confname# - All Games" cfsqltype="cf_sql_varchar" />,
										   <cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
										   <cfqueryparam value="562.50" cfsqltype="cf_sql_float" />,
										   <cfqueryparam value="562.50" cfsqltype="cf_sql_float" />										   
										   );
							</cfquery>					
							
								<cfset session.cart_id = createcart.newcartid />
								<cflocation url="games.cfm?cart_saved=true" addtoken="no">
							<!--- catch any db errors --->
							<cfcatch type="database">
								<div class="alert alert-danger">
									<h5>You've Thrown a Database <b>Error</b></h5> 
										<cfoutput> 
											<!--- The diagnostic message from ColdFusion. ---> 
											<p>#cfcatch.message#</p> 
											<p>Caught an exception, type = #cfcatch.type#</p> 
											<p>The contents of the tag stack are:</p> 
											<cfdump var="#cfcatch.tagcontext#"> 
										</cfoutput>
								</div>
							</cfcatch>						
						</cftry>
						
						
					
					</cfif>
					
				
				</cfif>
			
			<cfelse>
			
				
			
			</cfif>



			
				
		<cfelse>		
			<cflocation url="index.cfm?error=1" addtoken="yes">		
		</cfif>
		
					
		
		
		


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
										<cfif structkeyexists( session, "cart_id" )>
											<cfinvoke component="apis.com.store.storeservice" method="getcartcount" returnvariable="cartcount">
												<cfinvokeargument name="cartid" value="#session.cart_id#">
											</cfinvoke>		
											<ul class="nav navbar-nav pull-right">
												<li>											
													<a href="cart.cfm"><i class="fa fa-shopping-cart"></i> My Cart &nbsp; <span style="margin-left;5px;" class="label label-primary"> #cartcount.totalitems#</span></a>
												</li>											
											</ul>
										</cfif>
									</div>
								</nav>
							</div>
							
							<div class="wrapper wrapper-content animated fadeIn">
								<div class="container">
									<div class="row" style="margin-top:20px;">
										<div class="col-md-12">
											<cfif structkeyexists( url, "cart_saved" )>
												<div class="alert alert-info alert-dismissable">
													<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
													<p><a class="alert-link" href=""><i class="fa fa-check-circle-o"></i> Shopping Cart Saved</a></p>
													
												</div>
											</cfif>
											<div class="ibox">
												<div class="ibox-title">
													<h5><i class="fa fa-shopping-cart"></i> QwikCut | Game Video Store</h5>
													<span class="pull-right">
														<a href="index.cfm" style="margin-right:5px;" class="btn btn-xs btn-success btn-outline"><i class="fa fa-home"></i> Store Home</a>
														<a href="search.cfm" style="margin-right:5px;" class="btn btn-xs btn-default btn-outline"><i class="fa fa-play-circle"></i> Search Games</a>														
														<a href="cart.cfm" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-video-camera"></i> Video Cart</a>
													</span>
												</div>
												<div class="ibox-content ibox-heading border-bottom text-center text-navy">
													<h3><strong>Games List</strong></h3>
													<p>Select an individual game to add to your video cart.</p>
												</div>
												<div class="ibox-content">
													
													<div class="alert alert-success alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<p><a class="alert-link" href="games.cfm?add_to_cart=true&option=pro">QwikCut Pro Option</a><span class="pull-right"><a href="games.cfm?add_to_cart=true&option=pro" class="btn btn-sm btn-success"><i class="fa fa-shopping-cart"></i> Add to Cart</a></span></p>
														<p>Get access to every game, every week for all teams in the selected conference and division.</p>
													</div>
													
													<div class="alert alert-primary alert-dismissable">
														<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
														<p><i class="fa fa-trophy"></i> QwikCut Season Pass</p>
														<p>To purchase a Season Pass, select the team and team level by clicking the team name link in the table below...</p>
													</div>
													
													
													
													
													<div class="table-responsive">
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
																<cfloop query="games">
																	<tr class="gradeX">
																		<td>#gameid#</td>
																		<td>#dateformat( gamedate, "mm-dd-yyyy" )#</td>
																		<td><span class="label label-primary">#teamlevelname#</span></td>
																		<td><a href="season_pass.cfm?option=season_pass&team_id=#awayteamid#">#awayteam#</a> <i>vs.</i> <a href="season_pass.cfm?option=season_pass&team_id=#hometeamid#"><strong>#hometeam#</strong></a></td>
																		<td>#fieldname# Field</td>
																		<td><a href="games.cfm?add_to_cart=true&game_id=#gameid#" class="btn btn-sm btn-primary btn-outline"><i class="fa fa-shopping-cart"></i> Purchase Game</a></td>																	
																	</tr>
																</cfloop>
															</tbody>
															<tfoot>																
																<tr>
																	<td colspan="6"><a href="search.cfm" class="btn btn-xs btn-default"><i class="fa fa-search"></i> Return to Search</a></td>
																</tr>
															</tfoot>
														</table>
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