<cfcomponent displayname="activityservice">
	<cffunction name="init" access="public" output="false" hint="I initialize the activity service data object">
		<cfreturn this>
	</cffunction>
	<cffunction name="getuseractivity" access="public" returntype="query" hint="I get the user activity details.">
		<cfargument name="id" default="#session.userid#">
		<cfset var useractivity = "" />
			<cfquery name="useractivity">
				select top 100 activitytype, activitydate, activitytext, u.firstname, u.lastname
				  from activity a, users u
				 where a.userid = u.userid
				   and u.userid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			  order by a.activityid desc			
			</cfquery>
		<cfreturn useractivity>
	</cffunction>
</cfcomponent>