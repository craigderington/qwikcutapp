


			<!--- // CLD 07-06-2015 // QwikCut Game App templating engine --->

			<!--- Scope the URL variable --->
			<cfparam name="event" default="index">

			<!--- generate page template based on event scope --->
			<cfswitch expression="#event#">				
				<cfcase value="dashboard">					
					<cfinclude template="../../templates/index.cfm">					
				</cfcase>
				<cfcase value="season.stats">					
					<cfinclude template="../../templates/season-stats.cfm">					
				</cfcase>
				<cfcase value="game.stats">					
					<cfinclude template="../../templates/game-stats.cfm">					
				</cfcase>
				<cfcase value="team.roster">					
					<cfinclude template="../../templates/team-roster.cfm">					
				</cfcase>
				<cfcase value="do.logout">					
					<cfinclude template="../../templates/logout.cfm">					
				</cfcase>
				<!--- default case --->
				<cfdefaultcase>
					<cfinclude template="../../templates/index.cfm">
				</cfdefaultcase>			
			</cfswitch>