<cfcomponent displayname="useradminservice">		
	<cffunction name="init" access="public" output="false" returntype="useradminservice" hint="I create an initialized user admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getusers" output="false" returntype="query" access="remote" hint="I get the list of users">
		<cfset var userlist = "" />
			<cfquery name="userlist">
					select userid, username, firstname, lastname, password, confid, lastloginip, lastlogindate, email, userrole, useracl
				      from users
				  order by lastname, firstname asc
			</cfquery>
		<cfreturn userlist>
	</cffunction>
			
	<cffunction name="getuserdetail" output="false" returntype="query" access="remote" hint="I get the user detail.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
			<cfset var userdetail = "" />
				<cfquery name="userdetail">
					select userid, username, firstname, lastname, password, confid, lastloginip, lastlogindate, email, userrole, useracl
					  from users
					 where userid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> 
				</cfquery>
		<cfreturn userdetail>
	</cffunction>
			
			
			
			
</cfcomponent>