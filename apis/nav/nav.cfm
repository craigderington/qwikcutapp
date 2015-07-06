


			<!--- // CLD 07-06-2015 // QwikCut Game App templating engine --->

			<!--- Scope the URL variable --->
			<cfparam name="event" default="page.index">

			<!--- generate page template based on event scope --->
			<cfswitch expression="#event#">				
				<cfcase value="page.index">					
					<cfinclude template="../../templates/page.index.cfm">					
				</cfcase>
				<cfcase value="page.logout">					
					<cfinclude template="../../templates/page.logout.cfm">					
				</cfcase>				
				<!--- default case --->
				<cfdefaultcase>
					<cfinclude template="../../templates/page.index.cfm">
				</cfdefaultcase>
			
			</cfswitch>