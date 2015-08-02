

	
	
	
			<!---
			<cfinvoke component="apis.com.user.userservice" method="getusersettings" returnvariable="usersettings">
				<cfinvokeargument name="id" value="#session.userid#">
			</cfinvoke>
			--->

				
			<cfoutput>	
				<div class="wrapper wrapper-content animated fadeInRight">
					<div class="row" style="margin-top:25px;">
						<div class="ibox">
							<div class="ibox-title">
								<h5><i class="fa fa-th-list"></i> #session.username# | User Settings</h5>
								<span class="pull-right">
									<a href="#application.root#user.home" class="btn btn-xs btn-primary btn-outline"><i class="fa fa-dashboard"></i> Dashboard</a>
								</span>								
							</div>
							<div class="ibox-content">						
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class=""><a href="#application.root#user.profile"><i class="fa fa-user"></i> My Profile</a></li>
										<li class="active"><a href="#application.root#user.settings"><i class="fa fa-cog"></i> Settings</a></li>
										<li class=""><a href="#application.root#user.image"><i class="fa fa-image"></i> Profile Image</a></li>
										<li class=""><a href="#application.root#user.activity"><i class="fa fa-database"></i> User Activity</a></li>
									</ul>
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<form class="form-horizontal">
													<div class="form-group"><label class="col-sm-2 control-label">Mail Server Address:</label>
														<div class="col-sm-6">
															<input type="text" class="form-control" placeholder="Mail Server Address" value="" />
															<span class="help-block m-b-none">Example: mail.domain.com</span> 
														</div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">Mail Server Port:</label>
														<div class="col-sm-6"><input type="text" class="form-control" placeholder="Mail Server Port" value="" /></div>
													</div>
													<div class="form-group"><label class="col-sm-2 control-label">Mail Username:</label>
														<div class="col-sm-6"><input type="text" class="form-control" placeholder="Mail Username" value="" /></div>
													</div>																							
													<div class="form-group"><label class="col-sm-2 control-label">Mail Password:</label>
														<div class="col-sm-6">
															<input type="text" class="form-control" placeholder="Mail Password" />
														</div>
													</div>													
													<div class="hr-line-dashed" style="margin-top:15px;"></div>
													<div class="form-group">
														<div class="col-lg-offset-2 col-lg-6">
															<button class="btn btn-primary" type="submit" name="saveUserSettings"><i class="fa fa-save"></i> Save Settings</button>
															<a href="#application.root#user.home" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
														</div>
													</div>
												</form>
											</div>
										</div>                              
									</div>
								</div>
							</div>
						</div> 
					</div>
				</div>
			</cfoutput>