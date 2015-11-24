
				
				
				
				
				
				

				<cfif structkeyexists( url, "option" ) and trim( url.option ) eq "season_pass">
					
					<cfif structkeyexists( url, "team_id" )>
						<cfset teamid = url.team_id />
						<cfinvoke component="apis.com.store.storegameservice" method="getteambyid" returnvariable="teaminfo">
							<cfinvokeargument name="teamid" value="#teamid#">
						</cfinvoke>					
					<cfelse>
						<cflocation url="index.cfm" addtoken="no">
					</cfif>
					
						<cfif structkeyexists( session, "cart_id" )>
						
							<!--- // add cart item to existing cart --->
							<cftry>
								<cfquery name="additemtocart">
									insert into cart_items(cart_id, cart_item, cart_item_descr, cart_item_qty, cart_item_price, cart_item_total)
										values(
												<cfqueryparam value="#session.cart_id#" cfsqltype="cf_sql_integer" />,
												<cfqueryparam value="QwikCut Season Pass" cfsqltype="cf_sql_varchar" />,
												<cfqueryparam value="#teaminfo.teamorgname# - #teaminfo.teamlevelname#" cfsqltype="cf_sql_varchar" />,
												<cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
												<cfqueryparam value="25.00" cfsqltype="cf_sql_float" />,
												<cfqueryparam value="25.00" cfsqltype="cf_sql_float" />								   
											   );
								</cfquery>
								<cflocation url="cart.cfm" addtoken="yes">
								<cfcatch>
									<div class="alert alert-danger">
										<h5>You've Thrown a Database <b>Error</b></h5> 
											<cfoutput> 
												<!--- The diagnostic message from ColdFusion. ---> 
												<p>#cfcatch.message#</p> 
												<p>Caught an exception, type = #cfcatch.type#</p> 
												<p>The contents of the tag stack are:</p> 
												<cfdump var="#cfcatch.tagcontext#"> 
											</cfoutput>
									</div>
								</cfcatch>
							</cftry>
						
						<cfelse>
						
							<!--- // add cart item to new cart --->
							<cfset thiscart = trim( session.urltoken ) />
							<cfset thiscfid = listfirst( thiscart, "&" ) />
							<cfset thisjsess = listlast( thiscart, "&" ) />
							<cfset thiscfid = listlast( thiscfid, "=" ) />
							<cfset thisjsess = listlast( thisjsess, "=" ) />
							
							
							<cfset mycart = structnew() />
							<cfset mycart.sessionid = session.sessionid />
							<cfset mycart.jsess = thisjsess />
							<cfset mycart.cart_date = today />
							<cfset mycart.cart_cfid = thiscfid />
							
							<!-- try to insert into the database --->
							<cftry>
								<cfquery name="createcart">
									insert into carts(cart_session, cart_date, cart_cfid, cart_active, cart_jsess)
										values(
											   <cfqueryparam value="#mycart.sessionid#" cfsqltype="cf_sql_varchar" maxlength="32" />,
											   <cfqueryparam value="#mycart.cart_date#" cfsqltype="cf_sql_timestamp" />,
											   <cfqueryparam value="#mycart.cart_cfid#" cfsqltype="cf_sql_varchar" maxlength="36" />,
											   <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
											   <cfqueryparam value="#mycart.jsess#" cfsqltype="cf_sql_varchar" maxlength="36" />
											   ); select @@identity as newcartid
								</cfquery>
								
								<!--- // now that we have an existing cart session, add the selected item to the cart --->
								<cfquery name="additemtocart">
									insert into cart_items(cart_id, cart_item, cart_item_descr, cart_item_qty, cart_item_price, cart_item_total)
										values(
											   <cfqueryparam value="#createcart.newcartid#" cfsqltype="cf_sql_integer" />,
											   <cfqueryparam value="QwikCut Season Pass" cfsqltype="cf_sql_varchar" />,
											   <cfqueryparam value="#teaminfo.teamorgname# - #teaminfo.teamlevelname#" cfsqltype="cf_sql_varchar" />,
											   <cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
											   <cfqueryparam value="25.00" cfsqltype="cf_sql_float" />,
											   <cfqueryparam value="25.00" cfsqltype="cf_sql_float" />								   
											   );
								</cfquery>					
								
									<cfset session.cart_id = createcart.newcartid />
									<cflocation url="cart.cfm" addtoken="yes">
								<!--- catch any db errors --->
								<cfcatch type="database">
									<div class="alert alert-danger">
										<h5>You've Thrown a Database <b>Error</b></h5> 
											<cfoutput> 
												<!--- The diagnostic message from ColdFusion. ---> 
												<p>#cfcatch.message#</p> 
												<p>Caught an exception, type = #cfcatch.type#</p> 
												<p>The contents of the tag stack are:</p> 
												<cfdump var="#cfcatch.tagcontext#"> 
											</cfoutput>
									</div>
								</cfcatch>						
							</cftry>
							
							
						
						</cfif>
					
				
				</cfif>