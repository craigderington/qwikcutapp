


			<!--- // CLD 07-06-2015 // QwikCut Game App templating engine --->

			<!--- Scope the URL variable --->
			<cfparam name="event" default="user.home">

			<!--- generate page template based on event scope --->
			<cfswitch expression="#event#">				
				<cfcase value="user.home">					
					<cfinclude template="../../templates/index.cfm">					
				</cfcase>
				<cfcase value="user.profile">					
					<cfinclude template="../../templates/user.profile.cfm">				
				</cfcase>
				<cfcase value="user.settings">					
					<cfinclude template="../../templates/user.settings.cfm">			
				</cfcase>
				<cfcase value="user.reminders">					
					<cfinclude template="../../templates/user.reminders.cfm">				
				</cfcase>
				<cfcase value="user.activity">					
					<cfinclude template="../../templates/user.activity.cfm">				
				</cfcase>
				<cfcase value="user.image">					
					<cfinclude template="../../templates/user.image.cfm">				
				</cfcase>
				<cfcase value="admin.home">					
					<cfinclude template="../../templates/admin.home.cfm">				
				</cfcase>
				<cfcase value="admin.states">					
					<cfinclude template="../../templates/admin.states.cfm">					
				</cfcase>
				<cfcase value="admin.conferences">					
					<cfinclude template="../../templates/admin.conferences.cfm">					
				</cfcase>
				<cfcase value="admin.users">					
					<cfinclude template="../../templates/admin.users.cfm">					
				</cfcase>
				<cfcase value="admin.fields">					
					<cfinclude template="../../templates/admin.fields.cfm">					
				</cfcase>
				<cfcase value="admin.teams">					
					<cfinclude template="../../templates/admin.teams.cfm">					
				</cfcase>
				<cfcase value="admin.games">					
					<cfinclude template="../../templates/admin.games.cfm">					
				</cfcase>
				<cfcase value="admin.shooters">					
					<cfinclude template="../../templates/admin.shooters.cfm">					
				</cfcase>
				<cfcase value="admin.reports">					
					<cfinclude template="../../templates/admin.reports.cfm">					
				</cfcase>
				<cfcase value="admin.settings">					
					<cfinclude template="../../templates/admin.settings.cfm">					
				</cfcase>
				<cfcase value="admin.payroll">					
					<cfinclude template="../../templates/admin.payroll.cfm">					
				</cfcase>
				<cfcase value="user.logout">					
					<cfinclude template="../../templates/logout.cfm">					
				</cfcase>
				<cfcase value="user.register">					
					<cfinclude template="../../templates/register.cfm">					
				</cfcase>
				<cfcase value="shooter.accept">					
					<cfinclude template="../../templates/shooter.accept.cfm">					
				</cfcase>
				<cfcase value="shooter.game">					
					<cfinclude template="../../templates/shooter.game.cfm">					
				</cfcase>
				<cfcase value="shooter.games">					
					<cfinclude template="../../templates/shooter.games.cfm">					
				</cfcase>
				<cfcase value="team.games">					
					<cfinclude template="../../templates/team.games.cfm">					
				</cfcase>
				<cfcase value="admin.store">					
					<cfinclude template="../../templates/admin.store.cfm">				
				</cfcase>
				<cfcase value="notification.service">					
					<cfinclude template="../../templates/notification.service.cfm">					
				</cfcase>
				<cfcase value="do.alerts">
					<cfinclude template="../../templates/alerts.cfm">
				</cfcase>
				
				<!--- default case --->
				<cfdefaultcase>
					<cfinclude template="../../templates/index.cfm">
				</cfdefaultcase>			
			</cfswitch>