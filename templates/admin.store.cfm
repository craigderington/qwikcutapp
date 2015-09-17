



			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">				
					
					<!-- // include the page heading --->
					<cfinclude template="views/admin-store-page-heading.cfm">
						
						
						<div class="row">							
							<div class="ibox float-e-margins">
								<div class="ibox-title">
									<cfoutput>
										<h5><i class="fa fa-shopping-cart"></i> #session.username# | Store Administration</h5>
										<span class="pull-right">										
											<a href="#application.root#admin.reports" class="btn btn-xs btn-info btn-outline"><i class="fa fa-archive"></i> Reports</a>
											<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
											<a href="#application.root#admin.home" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-home"></i> Admin Home</a>
										</span>
									</cfoutput>
								</div>
								
								<cfif not structkeyexists( url, "fuseaction" )>	
								
									<div class="ibox-content ibox-heading text-center border-bottom">
										<I>QWIKCUT STORE ORDER ADMIN</I>
									</div>
									
								
									<div class="ibox-content m-b-sm border-bottom">
										<div class="row">
											<div class="col-sm-4">
												<div class="form-group">
													<label class="control-label" for="order_id">Order ID</label>
													<input type="text" id="order_id" name="order_id" value="" placeholder="Order ID" class="form-control">
												</div>
											</div>
											<div class="col-sm-4">
												<div class="form-group">
													<label class="control-label" for="status">Order status</label>
													<input type="text" id="status" name="status" value="" placeholder="Status" class="form-control">
												</div>
											</div>
											<div class="col-sm-4">
												<div class="form-group">
													<label class="control-label" for="customer">Customer</label>
													<input type="text" id="customer" name="customer" value="" placeholder="Customer" class="form-control">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-4">
												<div class="form-group">
													<label class="control-label" for="date_added">Date added</label>
													<div class="input-group date">
														<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input id="date_added" type="text" class="form-control" value="03/04/2014">
													</div>
												</div>
											</div>
											<div class="col-sm-4">
												<div class="form-group">
													<label class="control-label" for="date_modified">Date modified</label>
													<div class="input-group date">
														<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input id="date_modified" type="text" class="form-control" value="03/06/2014">
													</div>
												</div>
											</div>
											<div class="col-sm-4">
												<div class="form-group">
													<label class="control-label" for="amount">Amount</label>
													<input type="text" id="amount" name="amount" value="" placeholder="Amount" class="form-control">
												</div>
											</div>
										</div>
									</div>								
									<div class="row">
										<cfinclude template="views/orders/order_list.cfm">
									</div>								
								<cfelse>								
									<cfif structkeyexists( url, "order_id" ) and isnumeric( url.order_id )>										
										<cfif trim( url.fuseaction ) eq "order_view">
											<cfinclude template="views/orders/order_view.cfm">
										<cfelseif trim( url.fuseaction ) eq "order_edit">
											<cfinclude template="views/orders/order_edit.cfm">
										<cfelseif trim( url.fuseaction ) eq "order_remove">
											<cfinclude template="views/orders/order_remove.cfm">
										<cfelse>										
											<div class="alert alert-danger">
												<h5>Can Not Find View</h5>
												<p>The requested view was not found.  Please <a href="index.cfm">click here</a> to go admin homepage.
											</div>										
										</cfif>								
									</cfif>							
								</cfif>							
							</div>
						</div>