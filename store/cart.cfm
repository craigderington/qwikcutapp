



		
		
		
		<cfset today = now() />	
		
		<cfif structkeyexists( session, "cart_id" )>
			<cfinvoke component="apis.com.store.storeservice" method="getcart" returnvariable="cartItemList">
				<cfinvokeargument name="cartid" value="#session.cart_id#">
			</cfinvoke>
		<cfelse>
			<cflocation url="index.cfm?error=1" addtoken="yes">
		</cfif>
		
		
		<cfif structkeyexists( url, "fuseaction" ) and structkeyexists( url, "rcid" )>	
			<cfset cartitemid = url.rcid />			
			<cfif trim( url.fuseaction ) eq "removeItem" and isnumeric( url.rcid )>
				<cfquery name="killstorecartitem">
					delete from cart_items
					 where cart_item_id = <cfqueryparam value="#cartitemid#" cfsqltype="cf_sql_integer" />
				</cfquery>
				<cflocation url="cart.cfm" addtoken="no">
			</cfif>
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
										<ul class="nav navbar-nav pull-right">
											<li>
												<cfif structkeyexists( session, "cart_id" )>
													<cfinvoke component="apis.com.store.storeservice" method="getcartcount" returnvariable="cartcount">
														<cfinvokeargument name="cartid" value="#session.cart_id#">
													</cfinvoke>													
													<a href="cart.cfm"><i class="fa fa-shopping-cart"></i> My Cart &nbsp; <span style="margin-left;5px;" class="label label-primary"> #cartcount.totalitems#</span></a>
												</cfif>
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
													<h5><i class="fa fa-shopping-cart"></i> QwikCut | Game Video Store | Your Game Video Cart </h5>
													<span class="pull-right">
														<a href="index.cfm" style="margin-right:5px;" class="btn btn-xs btn-success btn-outline"><i class="fa fa-home"></i> Store Home</a>
														<a href="search.cfm" style="margin-right:5px;" class="btn btn-xs btn-default btn-outline"><i class="fa fa-play-circle"></i> Search Games</a>														
														<a href="cart.cfm" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-video-camera"></i> Video Cart</a>
													</span>
												</div>
												<div class="ibox-content ibox-heading border-bottom text-center text-navy">
													<h3><strong>Your Game Video Cart</strong></h3>
													<cfif cartItemList.recordcount gt 0>
													<p>To continue, click Checkout or Continue Shopping</p>
													</cfif>
												</div>
												<div class="ibox-content">				
													<cfparam name="carttotal" default="0">
													
													<cfif cartItemList.recordcount gt 0>
													
														<div class="table-responsive">
															<table class="table table-hover" >
																<thead>
																	<tr>
																		<th>Item</th>
																		<th>Description</th>
																		<th>Quantity</th>
																		<th>Price</th>
																		<th>Total</th>
																		<th>Actions</th>
																	</tr>
																</thead>
																<tbody>
																	<cfloop query="cartItemList">
																		<tr class="m-b">
																			<td><strong>#cart_item#</strong></td>
																			<td>#cart_item_descr#</td>
																			<td>#cart_item_qty#</td>
																			<td>#dollarformat( cart_item_price )#</td>
																			<td>#dollarformat( cart_item_total )#</td>
																			<td><a href="cart.cfm?fuseaction=removeItem&rcid=#cart_item_id#" onclick="return confirm('Are you sure you want to remove the selected cart item from your shopping cart?');" class="btn btn-sm btn-default btn-outline"><i class="fa fa-times-circle"></i></a></td>
																		</tr>
																		<cfset carttotal = carttotal + cart_item_total />
																	</cfloop>
																</tbody>
																<tfoot>																
																	<tr>
																		<td colspan="3"><small>#cartcount.totalitems# item<cfif cartcount.totalitems gt 1>s</cfif> in your cart.</small></td>
																		<td><span class="pull-right"><strong>Cart Total:</strong></span></td>
																		<td class="text-navy"><strong>#dollarformat( carttotal )#</strong></td>
																		<td>&nbsp</td>
																	</tr>																
																</tfoot>
															</table>
															<br />
															<span class="pull-right"><a style="margin-right:5px;" href="games.cfm" class="btn btn-md btn-success"><i class="fa fa-shopping-cart"></i> Continue Shopping?</a> <a href="checkout.cfm" class="btn btn-md btn-primary"><i class="fa fa-check-circle-o"></i> Check Out</a></span>
														</div>
													
													<cfelse>
													
														<div class="alert alert-danger alert-dismissable">
															<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
															<h5><i class="fa fa-warning"></i> Store Error!</h5>
															<p>Your cart is empty...</p>
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