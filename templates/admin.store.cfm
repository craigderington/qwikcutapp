



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
									
								<div class="ibox-content ibox-heading text-center">
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
									
										<div class="ibox">
											<div class="ibox-content">

												<table class="footable table table-stripped toggle-arrow-tiny default footable-loaded" data-page-size="15">
													<thead>
													<tr>

														<th class="footable-visible footable-first-column footable-sortable">Order ID<span class="footable-sort-indicator"></span></th>
														<th data-hide="phone" class="footable-visible footable-sortable">Customer<span class="footable-sort-indicator"></span></th>
														<th data-hide="phone" class="footable-visible footable-sortable">Amount<span class="footable-sort-indicator"></span></th>
														<th data-hide="phone" class="footable-visible footable-sortable">Date added<span class="footable-sort-indicator"></span></th>
														<th data-hide="phone,tablet" class="footable-visible footable-sortable">Date modified<span class="footable-sort-indicator"></span></th>
														<th data-hide="phone" class="footable-visible footable-sortable">Status<span class="footable-sort-indicator"></span></th>
														<th class="text-right footable-visible footable-last-column footable-sortable">Action<span class="footable-sort-indicator"></span></th>

													</tr>
													</thead>
													<tbody>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
														   3214
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$500.00
														</td>
														<td class="footable-visible">
															03/04/2015
														</td>
														<td class="footable-visible">
															03/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															324
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$320.00
														</td>
														<td class="footable-visible">
															12/04/2015
														</td>
														<td class="footable-visible">
															21/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															546
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$2770.00
														</td>
														<td class="footable-visible">
															06/07/2015
														</td>
														<td class="footable-visible">
															04/08/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															6327
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$8560.00
														</td>
														<td class="footable-visible">
															01/12/2015
														</td>
														<td class="footable-visible">
															05/12/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															642
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$6843.00
														</td>
														<td class="footable-visible">
															10/04/2015
														</td>
														<td class="footable-visible">
															13/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															7435
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$750.00
														</td>
														<td class="footable-visible">
															04/04/2015
														</td>
														<td class="footable-visible">
															14/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															3214
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$500.00
														</td>
														<td class="footable-visible">
															03/04/2015
														</td>
														<td class="footable-visible">
															03/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															324
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$320.00
														</td>
														<td class="footable-visible">
															12/04/2015
														</td>
														<td class="footable-visible">
															21/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															546
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$2770.00
														</td>
														<td class="footable-visible">
															06/07/2015
														</td>
														<td class="footable-visible">
															04/08/2015
														</td>
														<td class="footable-visible">
															<span class="label label-danger">Canceled</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															6327
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$8560.00
														</td>
														<td class="footable-visible">
															01/12/2015
														</td>
														<td class="footable-visible">
															05/12/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															642
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$6843.00
														</td>
														<td class="footable-visible">
															10/04/2015
														</td>
														<td class="footable-visible">
															13/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															7435
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$750.00
														</td>
														<td class="footable-visible">
															04/04/2015
														</td>
														<td class="footable-visible">
															14/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															324
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$320.00
														</td>
														<td class="footable-visible">
															12/04/2015
														</td>
														<td class="footable-visible">
															21/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-warning">Expired</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															546
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$2770.00
														</td>
														<td class="footable-visible">
															06/07/2015
														</td>
														<td class="footable-visible">
															04/08/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: table-row;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															6327
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$8560.00
														</td>
														<td class="footable-visible">
															01/12/2015
														</td>
														<td class="footable-visible">
															05/12/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															642
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$6843.00
														</td>
														<td class="footable-visible">
															10/04/2015
														</td>
														<td class="footable-visible">
															13/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															7435
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$750.00
														</td>
														<td class="footable-visible">
															04/04/2015
														</td>
														<td class="footable-visible">
															14/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															3214
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$500.00
														</td>
														<td class="footable-visible">
															03/04/2015
														</td>
														<td class="footable-visible">
															03/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															324
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$320.00
														</td>
														<td class="footable-visible">
															12/04/2015
														</td>
														<td class="footable-visible">
															21/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															546
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$2770.00
														</td>
														<td class="footable-visible">
															06/07/2015
														</td>
														<td class="footable-visible">
															04/08/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															6327
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$8560.00
														</td>
														<td class="footable-visible">
															01/12/2015
														</td>
														<td class="footable-visible">
															05/12/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															642
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$6843.00
														</td>
														<td class="footable-visible">
															10/04/2015
														</td>
														<td class="footable-visible">
															13/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															7435
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$750.00
														</td>
														<td class="footable-visible">
															04/04/2015
														</td>
														<td class="footable-visible">
															14/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															324
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$320.00
														</td>
														<td class="footable-visible">
															12/04/2015
														</td>
														<td class="footable-visible">
															21/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															546
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$2770.00
														</td>
														<td class="footable-visible">
															06/07/2015
														</td>
														<td class="footable-visible">
															04/08/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															6327
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$8560.00
														</td>
														<td class="footable-visible">
															01/12/2015
														</td>
														<td class="footable-visible">
															05/12/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															642
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$6843.00
														</td>
														<td class="footable-visible">
															10/04/2015
														</td>
														<td class="footable-visible">
															13/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															7435
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$750.00
														</td>
														<td class="footable-visible">
															04/04/2015
														</td>
														<td class="footable-visible">
															14/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															3214
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$500.00
														</td>
														<td class="footable-visible">
															03/04/2015
														</td>
														<td class="footable-visible">
															03/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															324
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$320.00
														</td>
														<td class="footable-visible">
															12/04/2015
														</td>
														<td class="footable-visible">
															21/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															546
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$2770.00
														</td>
														<td class="footable-visible">
															06/07/2015
														</td>
														<td class="footable-visible">
															04/08/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															6327
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$8560.00
														</td>
														<td class="footable-visible">
															01/12/2015
														</td>
														<td class="footable-visible">
															05/12/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-even" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															642
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$6843.00
														</td>
														<td class="footable-visible">
															10/04/2015
														</td>
														<td class="footable-visible">
															13/07/2015
														</td>
														<td class="footable-visible">
															<span class="label label-success">Shipped</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>
													<tr class="footable-odd" style="display: none;">
														<td class="footable-visible footable-first-column"><span class="footable-toggle"></span>
															7435
														</td>
														<td class="footable-visible">
															Customer example
														</td>
														<td class="footable-visible">
															$750.00
														</td>
														<td class="footable-visible">
															04/04/2015
														</td>
														<td class="footable-visible">
															14/05/2015
														</td>
														<td class="footable-visible">
															<span class="label label-primary">Pending</span>
														</td>
														<td class="text-right footable-visible footable-last-column">
															<div class="btn-group">
																<button class="btn-white btn btn-xs">View</button>
																<button class="btn-white btn btn-xs">Edit</button>
																<button class="btn-white btn btn-xs">Delete</button>
															</div>
														</td>
													</tr>



													</tbody>
													<tfoot>
													<tr>
														<td colspan="7" class="footable-visible">
															<ul class="pagination pull-right"><li class="footable-page-arrow disabled"><a data-page="first" href="first"><i class="fa fa-angle-double-left"></i></a></li><li class="footable-page-arrow disabled"><a data-page="prev" href="prev"><i class="fa fa-angle-left"></i></a></li><li class="footable-page active"><a data-page="0" href="">1</a></li><li class="footable-page"><a data-page="1" href="">2</a></li><li class="footable-page"><a data-page="2" href="">3</a></li><li class="footable-page-arrow"><a data-page="next" href="next"><i class="fa fa-angle-right"></i></a></li><li class="footable-page-arrow"><a data-page="last" href="last"><i class="fa fa-angle-double-right"></i></a></li></ul>
														</td>
													</tr>
													</tfoot>
												</table>

											</div>
										</div>
									</div>
								
							</div>
						</div>