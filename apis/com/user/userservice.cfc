<cfcomponent displayname="userservice">
	<cffunction name="init" access="public" output="false" returntype="userservice" hint="I initialize the user data object.">
		<cfreturn this >
	</cffunction>
	<cffunction name="getuserprofile" access="public" returntype="query" output="false" hint="I get the user profile.">
		<cfargument name="id" type="numeric" required="yes" default="#session.userid#">
		<cfset var userprofile ="" />
		<cfquery name="userprofile">
			select u.firstname, u.lastname, u.username, u.password, u.lastlogindate, u.lastloginip, u.email, u.userrole
			  from users u
			 where u.userid =<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn userprofile>
	</cffunction>
</cfcomponent>