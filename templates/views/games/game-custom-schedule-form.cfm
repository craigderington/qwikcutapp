







		
		
		
						
						
						<form name="create-custom-game-schedule" method="post" action="">
							<div class="form-group">								
								<label class="col-sm-4 control-label" for="conferencetype">Conference Type</label>								
								<div class="col-sm-8">
									<select name="conferencetype" class="form-control m-b" onchange="javascript:this.form.submit();">
										<option value="none">Select Conference Type</option>
										<option value="YF"<cfif structkeyexists( form, "conferencetype" ) and trim( form.conferencetype ) eq "YF">selected</cfif>>Youth Football</option>
										<option value="HS"<cfif structkeyexists( form, "conferencetype" ) and trim( form.conferencetype ) eq "HS">selected</cfif>>High School Football</option>
									</select>
								</div>
							</div>
							
							<cfif structkeyexists( form, "conferencetype" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getconferences" returnvariable="conferencelist">												
									<cfinvokeargument name="conferencetype" value="#trim( form.conferencetype )#">
								</cfinvoke>
								<div class="form-group">								
									<label class="col-sm-4 control-label" for="conferenceid">Conference</label>								
									<div class="col-sm-8">
										<select name="conferenceid" class="form-control m-b" onchange="javascript:this.form.submit();">
											<cfoutput query="conferencelist">
												<option value="#confid#"<cfif structkeyexists( form, "conferenceid" )><cfif form.conferenceid eq conferencelist.confid>selected</cfif></cfif>>#trim( confname )#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>

							<cfif structkeyexists( form, "conferenceid" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getteamlevels" returnvariable="teamlevels">												
									<cfinvokeargument name="conferencetype" value="#trim( form.conferencetype )#">
								</cfinvoke>
								<div class="form-group">								
									<label class="col-sm-4 control-label" for="division">Division</label>								
									<div class="col-sm-8">
										<select name="division" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="0">Select Division</option>
											<cfoutput query="teamlevels">
												<option value="#teamlevelid#"<cfif structkeyexists( form, "division")><cfif form.division eq teamlevels.teamlevelid>selected</cfif></cfif>>#teamlevelname#</option>
											</cfoutput>
										</select>
									</div>
								</div>							
							</cfif>
							
							<cfif structkeyexists( form, "division" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="gethometeam" returnvariable="hometeam">
									<cfinvokeargument name="conferenceid" value="#form.conferenceid#">
								</cfinvoke>	
								<div class="form-group">							
									<label class="col-sm-4 control-label" for="hometeam">Home Team</label>								
									<div class="col-sm-8">
										<select name="hometeam" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="none">Select Home Team</option>
											<cfoutput query="hometeam">
												<option value="#trim( teamorgname )#"<cfif structkeyexists( form, "hometeam" )><cfif trim( form.hometeam ) eq trim( hometeam.teamorgname )>selected</cfif></cfif>>#trim( teamorgname )#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>
							
							<cfif structkeyexists( form, "hometeam" )>
								<cfinvoke component="apis.com.admin.gameadminservice" method="getawayteam" returnvariable="awayteam">
									<cfinvokeargument name="conferenceid" value="#form.conferenceid#">
									<cfinvokeargument name="teamorgname" value="#trim( form.hometeam )#">													
								</cfinvoke>
								<div class="form-group">								
									<label class="col-sm-4 control-label" for="awayteam">Away Team</label>								
									<div class="col-sm-8">
										<select name="awayteam" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="none">Select Away Team</option>
											<cfoutput query="awayteam">
												<option value="#trim( teamorgname )#"<cfif structkeyexists( form, "awayteam" )><cfif trim( form.awayteam ) eq trim( awayteam.teamorgname )>selected</cfif></cfif>>#trim( teamorgname )#</option>
											</cfoutput>										
										</select>
									</div>
								</div>
							</cfif>
							
							<cfif structkeyexists( form, "awayteam" )>
								<cfinvoke component="apis.com.admin.fieldadminservice" method="getfields" returnvariable="fieldlist">
									<cfinvokeargument name="stateid" value="#session.stateid#">																					
								</cfinvoke>
								<div class="form-group">								
									<label class="col-sm-4 control-label" for="gamefield">Game Field</label>								
									<div class="col-sm-8">
										<select name="gamefield" class="form-control m-b" onchange="javascript:this.form.submit();">
											<option value="0">Select Game Field</option>
											<cfoutput query="fieldlist">
												<option value="#fieldid#"<cfif structkeyexists( form, "gamefield")><cfif form.gamefield eq fieldlist.fieldid>selected</cfif></cfif>>#fieldname# - #stateabbr#</option>
											</cfoutput>
										</select>
									</div>
								</div>
							</cfif>
							
							<cfif structkeyexists( form, "gamefield" )>
								<cfoutput>
									<div class="form-group" id="data_1">
										<label class="col-sm-4 control-label" for="gamedate">Game Date</label>
										<div class="col-sm-7 input-group date">
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											<input type="text" class="form-control m-b" name="gamedate" placeholder="Select Game Date" <cfif structkeyexists( form, "gamedate" )>value="#dateformat( form.gamedate, "mm/dd/yyyy" )#"</cfif> />													
										</div>
									</div>
									<div class="form-group" id="data_2">
										<label class="col-sm-4 control-label" for="gametime">Game Time</label>
										<div class="col-sm-7 input-group clockpicker" data-autoclose="true">															
											<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											<input type="text" class="form-control m-b" name="gametime" placeholder="Select Game Time" <cfif structkeyexists( form, "gametime" )>value="#dateformat( form.gametime, "mm/dd/yyyy" )#"</cfif>  />
										</div>
									</div>
								</cfoutput>
								
								<div class="hr-line-dashed"></div>
							
								<div class="form-group">
									<div class="col-sm-offset-4 col-sm-8">
										<button type="submit" class="btn btn-md btn-primary">Schedule Game</button>
										<a href="" class="btn btn-md btn-success"><i class="fa fa-refresh"></i> Reset</a>
									</div>							
								</div>
						
						
							</cfif>
						
						
						</form>