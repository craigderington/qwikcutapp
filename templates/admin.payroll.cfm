			
			
			
			<cfif not isuseinrole("admin")>
				<cflocation url="#application.root#userhome" addtoken="yes">
			</cfif>



			<div class="wrapper wrapper-content animated fadeIn">
				<div class="container">				
					
					<!-- // include the page heading --->
					<cfinclude template="views/admin-page-heading.cfm">
						
						
						<div class="row">							
							<div class="ibox float-e-margins">
								<div class="ibox-title">
									<cfoutput>
										<h5><i class="fa fa-dashboard"></i> #session.username# | Admin Payroll System</h5>
										<span class="pull-right">										
											<a href="#application.root#admin.reports" class="btn btn-xs btn-info btn-outline"><i class="fa fa-archive"></i> Reports</a>
											<a href="#application.root#admin.settings" class="btn btn-xs btn-default btn-outline" style="margin-left:5px;"><i class="fa fa-cogs"></i> Admin Settings</a>
											<a href="#application.root#admin.home" class="btn btn-xs btn-primary btn-outline" style="margin-left:5px;"><i class="fa fa-home"></i> Admin Home</a>
										</span>
									</cfoutput>
								</div>
									
								<div class="ibox-content ibox-heading text-center">
									<I>QWIKCUT PAYROLL SYSTEM</I>
								</div>
									
								<div class="ibox-content">
									<div class="row">
										<div class="col-sm-5 m-b-xs">
											<select class="input-sm form-control input-s-sm inline">
												<option value="0">Filter 1</option>
												<option value="1">Option 2</option>
												<option value="2">Option 3</option>
												<option value="3">Option 4</option>
											</select>
										</div>
										<div class="col-sm-4 m-b-xs">
											<div data-toggle="buttons" class="btn-group">
												<label class="btn btn-sm btn-white"> <input type="radio" id="option1" name="options"> Day </label>
												<label class="btn btn-sm btn-white active"> <input type="radio" id="option2" name="options"> Week </label>
												<label class="btn btn-sm btn-white"> <input type="radio" id="option3" name="options"> Month </label>
											</div>
										</div>
										<div class="col-sm-3">
											<div class="input-group"><input type="text" placeholder="Search" class="input-sm form-control"> <span class="input-group-btn">
												<button type="button" class="btn btn-sm btn-primary"> Go!</button> </span></div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>

													<th></th>
													<th>Shooter Name</th>
													<th>Completed</th>
													<th>Task</th>
													<th>Date</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><div class="icheckbox_square-green checked" style="position: relative;"><input type="checkbox" checked="" class="i-checks" name="input[]" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></td>
													<td>Shooter A</td>
													<td><span class="pie" style="display: none;">0.52/1.561</span><svg class="peity" height="16" width="16"><path d="M 8 8 L 8 0 A 8 8 0 0 1 14.933563796318165 11.990700825968545 Z" fill="#1ab394"></path><path d="M 8 8 L 14.933563796318165 11.990700825968545 A 8 8 0 1 1 7.999999999999998 0 Z" fill="#d7d7d7"></path></svg></td>
													<td>20%</td>
													<td>Jul 14, 2013</td>
													<td><a href="#"><i class="fa fa-check text-primary"></i></a></td>
												</tr>
												<tr>
													<td><div class="icheckbox_square-green" style="position: relative;"><input type="checkbox" class="i-checks" name="input[]" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></td>
													<td>Shooter B</td>
													<td><span class="pie" style="display: none;">6,9</span><svg class="peity" height="16" width="16"><path d="M 8 8 L 8 0 A 8 8 0 0 1 12.702282018339785 14.47213595499958 Z" fill="#1ab394"></path><path d="M 8 8 L 12.702282018339785 14.47213595499958 A 8 8 0 1 1 7.999999999999998 0 Z" fill="#d7d7d7"></path></svg></td>
													<td>40%</td>
													<td>Jul 16, 2013</td>
													<td><a href="#"><i class="fa fa-check text-primary"></i></a></td>
												</tr>
												<tr>
													<td><div class="icheckbox_square-green" style="position: relative;"><input type="checkbox" class="i-checks" name="input[]" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></td>
													<td>Shooter C</td>
													<td><span class="pie" style="display: none;">3,1</span><svg class="peity" height="16" width="16"><path d="M 8 8 L 8 0 A 8 8 0 1 1 0 8.000000000000002 Z" fill="#1ab394"></path><path d="M 8 8 L 0 8.000000000000002 A 8 8 0 0 1 7.999999999999998 0 Z" fill="#d7d7d7"></path></svg></td>
													<td>75%</td>
													<td>Jul 18, 2013</td>
													<td><a href="#"><i class="fa fa-check text-danger"></i></a></td>
												</tr>
												<tr>
													<td><div class="icheckbox_square-green" style="position: relative;"><input type="checkbox" class="i-checks" name="input[]" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></td>
													<td>Shooter D</td>
													<td><span class="pie" style="display: none;">4,9</span><svg class="peity" height="16" width="16"><path d="M 8 8 L 8 0 A 8 8 0 0 1 15.48012994148332 10.836839096340286 Z" fill="#1ab394"></path><path d="M 8 8 L 15.48012994148332 10.836839096340286 A 8 8 0 1 1 7.999999999999998 0 Z" fill="#d7d7d7"></path></svg></td>
													<td>18%</td>
													<td>Jul 22, 2013</td>
													<td><a href="#"><i class="fa fa-check text-warning"></i></a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>