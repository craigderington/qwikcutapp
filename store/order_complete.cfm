


		
		<cfif structkeyexists( session, "thisorder" )>
			<cfinvoke component="apis.com.store.storeservice" method="getcustomerorder" returnvariable="customerorder">
				<cfinvokeargument name="orderid" value="#session.thisorder#">
			</cfinvoke>
			<cfinvoke component="apis.com.store.storeservice" method="getorderdetail" returnvariable="orderdetail">
				<cfinvokeargument name="orderid" value="#session.thisorder#">
			</cfinvoke>
			<cfparam name="order_due_date" default="">
			<cfparam name="order_total" default="0">
			<cfset order_due_date = dateadd( "d", 7, customerorder.order_date ) />
		<cfelse>
			<cflocation url="index.cfm?error=12" addtoken="yes">
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
													<h5><i class="fa fa-shopping-cart"></i> QwikCut | Game Video Store | Order Confirmation </h5>													
												</div>
												
												<div class="ibox-content ibox-heading text-center text-navy">											
													<h3><strong>Thank You for Your Order</strong></h3>
													<p><small>Your order has been confirmed.  You'll receive a Square invoice shortly to complete the payment.</small></p>
												</div>
												
												
												<div class="ibox-content p-xl">
													<div class="row">
														<div class="col-sm-6">
															<h5>From:</h5>
															<address>
																<strong>QwikCut, Inc.</strong><br>
																4043 West State Road 46<br>
																Sanford, FL 32771<br>
																<abbr title="Phone">P:</abbr> (407) 794-5288<br />
																<abbr title="Email">E:</abbr> info@qwikcut.com
															</address>
														</div>

														<div class="col-sm-6 text-right">
															<h4>Invoice No.</h4>
															<h4 class="text-navy">INV-#customerorder.cart_session#</h4>
															<span>To:</span>
															<address>
																<strong>#customerorder.first_name# #customerorder.last_name#</strong><br>
																#customerorder.street_address#<br>
																#customerorder.city#, #customerorder.state# #customerorder.zip_code#<br>
																<abbr title="Phone">P:</abbr> #customerorder.phone_number#<br />
																<abbr title="Email">E:</abbr> #customerorder.customer_email#
															</address>
															<p>
																<span><strong>Invoice Date:</strong> #dateformat( customerorder.order_date, "mm-dd-yyyy" )#</span><br>
																<span><strong>Due Date:</strong> #dateformat( order_due_date, "mm-dd-yyyy" )#</span>
															</p>
														</div>
													</div>

													<div class="table-responsive m-t">
														<table class="table invoice-table">
															<thead>
															<tr>
																<th>Item List</th>
																<th>Quantity</th>
																<th>Unit Price</th>																
																<th>Total Price</th>
															</tr>
															</thead>
															<tbody>
																<cfloop query="orderdetail">
																	<tr>
																		<td><div><strong>#order_item#</strong></div>
																			<small>#order_item_descr#</small></td>
																		<td>1</td>
																		<td>#dollarformat( order_item_price )#</td>																
																		<td>#dollarformat( order_item_total )#</td>
																	</tr>
																	<cfset order_total = order_total + order_item_total />
																</cfloop>
															</tbody>
														</table>
													</div><!-- /table-responsive -->

													<table class="table invoice-total">
														<tbody>
															<tr>
																<td><strong>Sub Total :</strong></td>
																<td>#dollarformat( order_total )#</td>
															</tr>
															<tr>
																<td><strong>Tax :</strong></td>
																<td>0.00</td>
															</tr>
															<tr>
																<td><strong>Total :</strong></td>
																<td>#dollarformat( order_total )#</td>
															</tr>														
														</tbody>
													</table>
													<div class="text-right">
														<a class="btn btn-primary" href="index.cfm"><i class="fa fa-home"></i> Store Home</a>
													</div>

													<div class="well m-t"><i class="fa fa-money"></i> <strong>Square Payments</strong><br />
													  {{ notice about receiving square invoice }}														
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