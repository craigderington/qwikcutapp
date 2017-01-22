<cfcomponent displayname="gamealertservice">

	<cffunction name="init" access="public" output="false" returntype="gamealertservice" hint="I create an initialized game alert service object.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getalerts" access="public" returntype="query" output="false" hint="I get the game alerts.">		
		<cfset var gamealerts = "" />
		<cfquery name="gamealerts">
			  select alertid, contactid, alertdatetime, alerttype, alerttext, alertread, alertdismissed,
				     alertqueued, alertsent, alertsentdate, gameid
			    from alerts
			order by alertdate DESC
		</cfquery>
		<cfreturn gamealerts>
	</cffunction>
	
	<cffunction name="getgamealertsqueue" access="public" output="false" returntype="query" hint="I get the game alerts queue.">
		<cfset var gamealertsqueue = "" />
		<cfquery name="gamealertsqueue">
			select alertid, contactid, alertdatetime, alerttype, alerttext, alertread, alertdismissed,
				   alertqueued, alertsent, alertsentdate, gameid
			  from dbo.alerts
			 where alertqueued = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			   and alertsent = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
		  order by alertid ASC
		</cfquery>
		<cfreturn gamealertsqueue>
	</cffunction>
	
	<cffunction name="pollgames" access="public" output="false" returntype="string" hint="I find upcoming games to schedule game alerts.">
		<cfargument name="gamedate" type="date" required="true" default="#now()#">
		<cfargument name="enddate" type="date" required="true" default="#dateadd( "d", now(), 1 )#">
		<cfset var gamealertsgenerated = "False" />
		
		<cfquery name="alerts">
			select gameid from alerts order by gameid asc
		</cfquery>
		<cfif alerts.recordcount gt 0>
			<cfset alertgamelist = valuelist(alerts.gameid, ",") />
		<cfelse>
			<cfset alertgamelist = "0,1" />
		</cfif>
		
		<cfquery name="gettodaysgames">
			select gameid, hometeamid, awayteamid, gamedate, fieldid, vsid, gamestatus
			  from games
			 where gamedate > <cfqueryparam value="#arguments.gamedate#" cfsqltype="cf_sql_timestamp" />
			   and gamedate < <cfqueryparam value="#arguments.enddate#" cfsqltype="cf_sql_timestamp" />
			   and gamestatus <> <cfqueryparam value="FINAL" cfsqltype="cf_sql_varchar" />
			   and gameid not in(<cfqueryparam value="#alertgamelist#" cfsqltype="cf_sql_integer" list="yes" />)
		  order by gameid asc
		</cfquery>
			
			<cfif gettodaysgames.recordcount gt 0>
				<cfloop query="gettodaysgames">
					<cfset mygameid = gettodaysgames.gameid />
					<cfset homeid = gettodaysgames.hometeamid />
					<cfset awayid = gettodaysgames.awayteamid />
					<cfquery name="gethometeamcontacts">
						select contactid, teamid, contactname, coachlastname, contactnumber, contactprovider, contactactive,
						       contactemail
						  from teamcontacts
						 where teamid = <cfqueryparam value="#homeid#" cfsqltype="cf_sql_integer" />
						   and contactactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
					</cfquery>
					<cfif gethometeamcontacts.recordcount gt 0>
						<cfloop query="gethometeamcontacts">
							<cfset today = now() />
							<cfset alerttext = "This is a game alert.  Please confirm the game date and location by replying directly to this message and sending CONFIRMED! or CHANGE EVENT!" />
							<cfquery name="creategamealerts">
								insert into alerts(contactid, alertdatetime, alerttype, alerttext, alertread, alertdismissed, alertqueued, alertsent, gameid)
									values(
											<cfqueryparam value="#contactid#" cfsqltype="cf_sql_integer" />,
											<cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />,
											<cfqueryparam value="Game Alert" cfsqltype="cf_sql_varchar" />,
											<cfqueryparam value="#alerttext#" cfsqltype="cf_sql_varchar" />,
											<cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
											<cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
											<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
											<cfqueryparam value="0" cfsqltype="cf_sql_bit" />,
											<cfqueryparam value="#mygameid#" cfsqltype="cf_sql_integer" />
									       );
							</cfquery>							
						</cfloop>
						<cfset gamealertsgenerated = "True" />
					<cfelse>
						<cfset gamealertsgenerated = "False" />					
					</cfif>			
				</cfloop>			
			<cfelse>			
				<cfset gamealertsgenerated = "False" />		
			</cfif>	
		<cfreturn gamealertsgenerated>
	</cffunction>
	

	<cffunction name="sendgamealerts" access="public" output="false" returntype="any" hint="I send the games alerts.">			
			<cfargument name="alertid" type="numeric" required="yes">			
			
			<cfset arguments.senderemail = "systems@qwikcut.com"  />
			<cfset msgstatus = "" />
			
			<cfquery name="alertinfo">
				select alertid, gameid, contactid, alerttype, alerttext
				  from alerts
				 where alertid = <cfqueryparam value="#arguments.alertid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="gameinfo">
				 select gameid, f.fieldname, v.gamedate, v.hometeam, v.awayteam
				   from games g, fields f, versus v
				  where g.fieldid = f.fieldid
				    and g.vsid = v.vsid
					and g.gameid = <cfqueryparam value="#alertinfo.gameid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="contactinfo">
			    select contactid, contactname, contactnumber, contactprovider, contactemail, contactactive, numalerts
				  from teamcontacts
				  where contactid = <cfqueryparam value="#alertinfo.contactid#" cfsqltype="cf_sql_integer" />
			</cfquery>

			<cfif contactinfo.contactprovider is not "" and trim( contactinfo.contactprovider ) is not "@noprovider">
				<cfset sendtoaddress = contactinfo.contactnumber & contactinfo.contactprovider />			
				<!--- // send text message.  limit messages to 100 characters to avoid message splitting --->
				<cfmail from="#arguments.senderemail#" to="#sendtoaddress#" subject="#alertinfo.alerttype#">
					 #alertinfo.alerttext#
					<cfmailparam name="reply-to" value="info@qwikcut.com">
				</cfmail>
				
				<cfset newalertcount = contactinfo.numalerts + 1 />
				<cfquery name="updatesendstats">
					update teamcontacts
					   set numalerts = <cfqueryparam value="#newalertcount#" cfsqltype="cf_sql_integer" />
					 where contactid = <cfqueryparam value="#contactinfo.contactid#" cfsqltype="cf_sql_integer" />
				</cfquery>
				<cfset today = now() />
				<cfquery name="updatealerts">
					update alerts
					   set alertsent = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
					       alertsentdate = <cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />,
						   alertqueued = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
					 where alertid = <cfqueryparam value="#alertinfo.alertid#" cfsqltype="cf_sql_integer" />
				</cfquery>
				
		
			<cfelse>
			
				<!--- TODO:  send email confirmation instead ---> 
				
			</cfif>
				
				
			<cfset msgstatus = "Message Sent!" />
		<cfreturn msgstatus>
	</cffunction>
	
</cfcomponent>