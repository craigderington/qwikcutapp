


			<!--- // CLD 07-06-2015 // QwikCut Game App templating engine --->

			<!--- Scope the URL variable --->
			<cfparam name="event" default="user.home">

			<!--- generate page template based on event scope --->
			<cfswitch expression="#event#">				
				<cfcase value="user.home">					
					<cfinclude template="../../templates/index.cfm">					
				</cfcase>
				<cfcase value="admin.states">					
					<cfinclude template="../../templates/admin.states.cfm">					
				</cfcase>
				<cfcase value="admin.users">					
					<cfinclude template="../../templates/admin.users.cfm">					
				</cfcase>
				<cfcase value="user.logout">					
					<cfinclude template="../../templates/logout.cfm">					
				</cfcase>
				<cfcase value="user.register">					
					<cfinclude template="../../templates/register.cfm">					
				</cfcase>
				
				<!--- default case --->
				<cfdefaultcase>
					<cfinclude template="../../templates/index.cfm">
				</cfdefaultcase>			
			</cfswitch>