


			
			
			
			
			<cfif structkeyexists( session, "cart_id" )>
				<cfset cartid = session.cart_id />
				<cfinvoke component="apis.com.store.storeservice" method="getmycart" returnvariable="mycart">
					<cfinvokeargument name="cartid" value="#cartid#">
				</cfinvoke>
				<cfinvoke component="apis.com.store.storeservice" method="getcart" returnvariable="cartItemList">
					<cfinvokeargument name="cartid" value="#cartid#">
				</cfinvoke>
			<cfelse>
				<cflocation url="index.cfm?error=1" addtoken="yes">
			</cfif>
			
			<cfif structkeyexists( session, "vsid" )>
				<cfset gameid = session.vsid />
				<cfinvoke component="apis.com.store.storegameservice" method="getconferencedivision" returnvariable="gameinfo">
					<cfinvokeargument name="gameid" value="#session.vsid#">
				</cfinvoke>
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
													<h5><i class="fa fa-shopping-cart"></i> QwikCut | Game Video Store | Checkout</h5>
													
												</div>
												<div class="ibox-content" style="min-height:<cfif structkeyexists( form, "submitthisorder" )>850px<cfelse>600px</cfif>;">


													<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "submitthisorder" )>
					
														<cfset form.validate_require = "firstname|Please enter your first name.;lastname|Please enter your last name.;streetaddress|Please enter your street address.;city|Please enter your city.;state|Please enter your state of residence.;zipcode|Please enter your zip code.;phone|Please enter your phone number.;email|Please enter your email." />
														<cfset form.validate_email = "email|The email address is not a recognized format.  Please re-enter." />
														
															<cfscript>
																objValidation = createobject( "component","apis.udfs.validation" ).init();
																objValidation.setFields( form );
																objValidation.validate();
															</cfscript>

															<cfif objValidation.getErrorCount() is 0>							
																
																<!--- define our form structure and set form values --->
																<cfset c = structnew() />
																<cfset c.firstname = trim( form.firstname ) />
																<cfset c.lastname = trim( form.lastname ) />
																<cfset c.order_date = today />
																<cfset c.address = trim( form.streetaddress ) />
																<cfset c.city = trim( form.city ) />
																<cfset c.state = trim( left( ucase( form.state ), 2 )) />
																<cfset c.zipcode = trim( form.zipcode ) />
																<cfset c.phone = trim( form.phone ) />
																<cfset c.email = trim( form.email ) />
																<cfset c.division = trim( form.division ) />
																<cfset c.conference = trim( form.conference ) />
																<cfset c.hudlid = trim( form.hudluser ) />
															
																
																	<cfquery name="createcustomer">
																		insert into customers(customer_date, first_name, last_name, street_address, city, state, zip_code, phone_number, customer_active, customer_email, conference, division, hudl_id)
																		 values(
																				<cfqueryparam value="#c.order_date#" cfsqltype="cf_sql_timestamp" />,
																				<cfqueryparam value="#c.firstname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.lastname#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.address#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.city#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.state#" cfsqltype="cf_sql_varchar" maxlength="2" />,
																				<cfqueryparam value="#c.zipcode#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.phone#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,	
																				<cfqueryparam value="#c.email#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.conference#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.division#" cfsqltype="cf_sql_varchar" maxlength="50" />,
																				<cfqueryparam value="#c.hudlid#" cfsqltype="cf_sql_varchar" maxlength="50" />													
																				); select @@identity as newcustomerid
																	</cfquery>

																		<!--- // create order --->
																		<cfquery name="createorderfromcart">
																			insert into orders(cart_id, order_date, order_status, order_completed, customer_id)														  													   
																			 values(
																					<cfqueryparam value="#session.cart_id#" cfsqltype="cf_sql_integer" />,
																					<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
																					<cfqueryparam value="In Process" cfsqltype="cf_sql_varchar" />,
																					<cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
																					<cfqueryparam value="#createcustomer.newcustomerid#" cfsqltype="cf_sql_integer" />
																					); select @@identity as neworderid
																		</cfquery>
																		<cfset session.thisorder = createorderfromcart.neworderid />
																		<cfloop query="cartItemList">
																			<cfquery name="addcartitemtoorder">
																				insert into order_items(order_id, order_item, order_item_descr, order_item_qty, order_item_price, order_item_total)
																					values(
																						   <cfqueryparam value="#createorderfromcart.neworderid#" cfsqltype="cf_sql_integer" />,
																						   <cfqueryparam value="#cart_item#" cfsqltype="cf_sql_varchar" />,
																						   <cfqueryparam value="#cart_item_descr#" cfsqltype="cf_sql_varchar" />,
																						   <cfqueryparam value="#cart_item_qty#" cfsqltype="cf_sql_integer" />,
																						   <cfqueryparam value="#cart_item_price#" cfsqltype="cf_sql_float" />,
																						   <cfqueryparam value="#cart_item_total#" cfsqltype="cf_sql_float" />										   
																						   );
																			</cfquery>																		
																		</cfloop>
																		<cfset temp_v = structdelete( session, "vsid" ) />
																		<cfset temp_c = structdelete( session, "cart_id" ) />
																		
																		
																		<!--- // send the order by email --->
																		<cfmail from="info@qwikcut.com" to="#c.email#" cc="rob@qwikcut.com" bcc="cderington@gmail.com" subject="Game Video Order" type="HTML"><cfoutput><div align="center"><a href="http://www.qwikcut.com"><img src="http://qwikcut.cloudapp.net/qwikcutapp/img/qc-logo-600x176.jpg" height="176" width="600"></a></div>
<div style="padding:7px;">			
<h3>Thank You, #c.firstname# #c.lastname#!</h3>
<p>Your game video order has been received and is being processed.</p>
<p>You will be receiving an order invoice via email from Square.  Please click the link in the Square invoice email to make your payment online at Square's website.</p>

<br /><br />



<p>Thank You.</p>
<p>QwikCut.com</p>		
	

<br /><br /><br /><br />

<p><small>This is an automated email sent from a unattended mailbox. Please do not reply to this email directly.  Please direct all questions or comments to info@qwikcut.com</small></p>
<p><small>Email sent on behalf of QwikCut.com on #dateformat( now(), "mm/dd/yyyy" )# at #timeformat( now(), "hh:mm:ss tt" )#</small></p>
</div>
</cfoutput>																						
																		
																		
																			<cfmailparam name="reply-to" value="info@qwikcut.com">
																		</cfmail>
																		
																		
																		
																		
																		
																		
																		
																		
																	<cflocation url="order_complete.cfm" addtoken="no">				
																
													
															<!--- If the required data is missing - throw the validation error --->
															<cfelse>
															
																<div class="alert alert-danger alert-dismissable">
																	<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
																		<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h2>
																		<ul>
																			<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
																				<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
																			</cfloop>
																		</ul>
																</div>				
																
															</cfif>										
															
														</cfif>
														<!--- // end form processing --->
















													<!--- // draw the checkout customer form --->
													<form class="form-horizontal" name="check-out-customer" method="post" action="">	
															<div class="col-md-8">														
																<fieldset>
																	<div class="form-group">
																		<label class="col-md-2 control-label">First Name</label>
																		<div class="col-md-8">
																			<input type="text" placeholder="Enter First Name" class="form-control" name="firstname" <cfif structkeyexists( form, "firstname" )>#trim( form.firstname )#</cfif> />																			
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Last Name</label>
																		<div class="col-md-8">
																			<input type="text" placeholder="Enter Last Name" class="form-control" name="lastname" <cfif structkeyexists( form, "lastname" )>#trim( form.lastname )#</cfif> />																			
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Address</label>
																		<div class="col-md-8">
																			<input type="text" placeholder="Enter Street Address" class="form-control" name="streetaddress" <cfif structkeyexists( form, "streetaddress" )>#trim( form.streetaddress )#</cfif> />																			
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">City, State, Zip</label>
																		<div class="col-md-4">
																			<input type="text" placeholder="Enter City" class="form-control" name="city" <cfif structkeyexists( form, "city" )>#trim( form.city )#</cfif>/>																		
																		</div>
																		<div class="col-md-2">
																			<input type="text" placeholder="Enter State" class="form-control" name="state" <cfif structkeyexists( form, "state" )>#trim( left( form.state, 2 ))#</cfif>/>
																		</div>
																		<div class="col-md-2">
																			<input type="text" placeholder="Enter Zip Code" class="form-control" name="zipcode" <cfif structkeyexists( form, "zipcode" )>#trim( form.zipcode )#</cfif>/>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Phone</label>
																		<div class="col-md-8">
																			<input type="text" placeholder="Enter Phone Number" class="form-control" name="phone" <cfif structkeyexists( form, "phone" )>#trim( form.phone )#</cfif> />																			
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Email</label>
																		<div class="col-md-8">
																			<input type="text" placeholder="Enter Email Address" class="form-control" name="email" <cfif structkeyexists( form, "email" )>#trim( form.email )#</cfif> />																			
																			<span class="help-block">You'll receive a Square automated payment invoice at this email address.</span>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Hudl Username</label>
																		<div class="col-md-8">
																			<input type="text" placeholder="Hudl username" class="form-control" name="hudluser" <cfif structkeyexists( form, "hudluser" )>#trim( form.hudluser )#</cfif> />
																			<span class="help-block">This is required to share the video with you. </span>
																		</div>
																	</div>
																	<div class="hr-line-dashed"></div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Conference</label>
																		<div class="col-md-8">
																			<input type="text" class="form-control" name="conference" value="#trim( gameinfo.confname )#" />																		
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Division</label>
																		<div class="col-md-8">
																			<input type="text" class="form-control" name="division" value="#trim( gameinfo.teamlevelname )#" />																		
																		</div>
																	</div>																	
																</fieldset>																
															</div>

															<div class="col-md-4">
																<div class="table-responsive">
																	<table class="table table-hover" >
																		<thead>
																			<tr>
																				<th>Item</th>																		
																				<th>Quantity</th>
																				<th>Price</th>
																			</tr>
																		</thead>
																		<tbody>
																			<cfparam name="carttotal" default="0">
																			<cfloop query="cartItemList">
																				<tr class="m-b">
																					<td>#cart_item#</td>																			
																					<td>#cart_item_qty#</td>
																					<td>#dollarformat( cart_item_price )#</td>																			
																				</tr>
																				<cfset carttotal = carttotal + cart_item_price />
																			</cfloop>
																		</tbody>
																		<tfoot>
																			<tr>
																				<td></td>
																				<td><strong>Total:</strong></td>
																				<td><strong>#dollarformat( carttotal )#</strong></td>
																			</tr>
																		</tfoot>
																	</table>
																	
																	<br />
																	
																	
																		<button type="submit" name="submitthisorder" class="btn btn-lg btn-primary"><i class="fa fa-check"></i> Submit Order</button>
																		<a href="index.cfm" class="btn btn-lg btn-white"><i class="fa fa-times-circle"></i> Cancel</a>
																	
																	<br /><br />
																	
																		<div class="well" style="padding:20px;">
																			* A Hudl account is required to view game media.  If you do not have a Hudl account, QwikCut will aquire a new Hudl account for you for an additional $99. Please direct any questions to <a href="mailto:info@qwikcut.com">info@qwikcut.com</a>.
																		
																		</div>
																	
																	
																</div>
															</div>
													</form>
												
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