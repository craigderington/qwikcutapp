




				
				<cfoutput>
					<form name="shootert-add-new" class="form-horizontal" method="post" action="">						
						<div class="form-group">
							<label class="col-lg-2 control-label">First Name</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Shooter First Name" name="shooterfirstname" <cfif structkeyexists( form, "shooterfirstname" )>value="#trim( form.shooterfirstname )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Last Name</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Shooter Last Name" name="shooterlastname" <cfif structkeyexists( form, "shooterlastname" )>value="#trim( form.shooterlastname )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Address</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Address 1" name="shooteradd1" <cfif structkeyexists( form, "shooteradd1" )>value="#trim( form.shooteradd1 )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Address 2</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Address 2" name="shooteradd2" <cfif structkeyexists( form, "shooteradd2" )>value="#trim( form.shooteradd2 )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">City</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="City" name="shootercity" <cfif structkeyexists( form, "shootercity" )>value="#trim( form.shootercity )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">State</label>
							<div class="col-lg-10">
								<select name="state" id="state" class="form-control">
									<option value="" selected>Select State</option>
									<cfloop query="statelist">
										<option value="#stateid#">#statename#</option>
									</cfloop>
								</select>
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Zip Code</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Zip Code" name="shooterzip" <cfif structkeyexists( form, "shooterzip" )>value="#trim( form.shooterzip )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Email</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Email Address" name="shooteremail" <cfif structkeyexists( form, "shooteremail" )>value="#trim( form.shooteremail )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<label class="col-lg-2 control-label">Mobile</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" placeholder="Mobile Phone Number" name="shootercellphone" <cfif structkeyexists( form, "shootercellphone" )>value="#trim( form.shootercellphone )#"</cfif> />
							</div>
						</div>											
						<div class="hr-line-dashed"></div>
						<div class="form-group">
							<div class="col-sm-4 col-sm-offset-2">
								<button class="btn btn-primary" type="submit"><i class="fa fa-save"></i> Save Shooter</button>
								<a href="#application.root##url.event#" class="btn btn-white" type="submit"><i class="fa fa-remove"></i> Cancel</a>													
							</div>
						</div>						
					</form>
				</cfoutput>