






				<!--- // change the game field --->
				<div class="col-md-6">				
					<cfinclude template="game-field-map-view.cfm">				
				</div>
				
				
				<div class="col-md-6">
					
					<!--- // begin form processing --->
					<cfif structkeyexists( form, "fieldnames" ) and structkeyexists( form, "changeGameField" )>
										
						<cfset form.validate_require = "gamefieldid|Please select a new field to change the current game field." />
											
							<cfscript>
								objValidation = createobject( "component","apis.udfs.validation" ).init();
								objValidation.setFields( form );
								objValidation.validate();
							</cfscript>

							<cfif objValidation.getErrorCount() is 0>							
												
								<!--- define our form structure and set form values --->
								<cfset f = structnew() />
								<cfset f.fieldid = form.gamefieldid />
								<cfset f.gamevsid = session.vsid />			
													
									<cfquery name="changegamefield">
										update versus
										   set fieldid = <cfqueryparam value="#f.fieldid#" cfsqltype="cf_sql_integer" />
										 where vsid = <cfqueryparam value="#f.gamevsid#" cfsqltype="cf_sql_integer" />																
									</cfquery>
									
									<cfquery name="updategamesfield">
										update games
										   set fieldid = <cfqueryparam value="#f.fieldid#" cfsqltype="cf_sql_integer" />
										 where vsid = <cfqueryparam value="#f.gamevsid#" cfsqltype="cf_sql_integer" />																
									</cfquery>
									
									<!--- // begin notify shooters --->
									
									<!--- // end notify shooters --->

									<!--- // record the activity --->
									<cfquery name="activitylog">
										insert into activity(userid, activitydate, activitytype, activitytext)														  													   
											values(
													<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />,
													<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
													<cfqueryparam value="Modify Record" cfsqltype="cf_sql_varchar" />,
													<cfqueryparam value="changed the game field for Game: #f.gamevsid# to field ID: #f.fieldid#." cfsqltype="cf_sql_varchar" />																
													);
									</cfquery>
													
									<cflocation url="#application.root##url.event#&fuseaction=#url.fuseaction#&scope=gf1" addtoken="no">				
												
									
									<!--- If the required data is missing - throw the validation error --->
							<cfelse>
											
								<div class="alert alert-danger alert-dismissable">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">&times;</button>
										<h5><error>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</error></h5>
											<ul>
												<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
													<li class="formerror"><cfoutput>#variables.objValidation.getMessage(rr)#</cfoutput></li>
												</cfloop>
											</ul>
										</div>				
												
							</cfif>										
											
					</cfif>
					<!--- // end form processing --->
					
					<cfinvoke component="apis.com.admin.fieldadminservice" method="getfields" returnvariable="fieldlist">
						<cfinvokeargument name="stateid" value="#session.stateid#">
					</cfinvoke>
					
					<cfoutput>
						<form class="form-horizontal" name="change-game-field" method="post">
							<fieldset>
								<div class="form-group">
									<label class="label control-label">Select New Field</label>
									<select class="form-control" name="gamefieldid">
										<option value="" selected>Select Field</option>
										<cfloop query="fieldlist">
											<option value="#fieldid#"<cfif versus.fieldid eq fieldlist.fieldid>selected</cfif>>#fieldname# Field - #fieldcity#, #stateabbr#</option>
										</cfloop>
									</select>
								</div>
								<div class="hr-line-dashed" style="margin-top:25px;"></div>
									<div class="form-group">
										<div class="col-lg-offset-2 col-lg-10">
											<button class="btn btn-primary" type="submit" name="changeGameField"><i class="fa fa-save"></i> Change Game Field</button>
											<a href="#application.root##url.event#&fuseaction=#url.fuseaction#" class="btn btn-default"><i class="fa fa-remove"></i> Cancel</a>																		
										</div>
								</div>							
							</fieldset>				
						</form>
					</cfoutput>
					
					
					
				</div>