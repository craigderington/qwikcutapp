







					<!--- // run the game alert function and return the variable --->
					<cfset today = now() />
					<cfset gamedate = today />
					<cfset enddate = dateadd( "d", 1, gamedate ) />
					
					<cfinvoke component="apis.com.notifications.gamealertservice" method="pollgames" returnvariable="gamealertsgenerated">
						<cfinvokeargument name="gamedate" value="#gamedate#">
						 <cfinvokeargument name="enddate" value="#enddate#">
					</cfinvoke>
					
					
					<cfoutput>
						#gamealertsgenerated#
					</cfoutput>